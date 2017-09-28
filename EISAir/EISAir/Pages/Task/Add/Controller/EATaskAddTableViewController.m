//
//  EATaskAddTableViewController.m
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskAddTableViewController.h"
#import "EATaskItemModel.h"
#import "EAAddTaskInputCell.h"
#import "EAAddTaskDateCell.h"
#import <TPKeyboardAvoidingTableView.h>
#import "TKCommonTools.h"
#import "EAScanViewController.h"
#import "TKRequestHandler+Task.h"
#import "EATaskModel.h"
#import "EATaskAddCollectionViewCell.h"
#import "EAAddTaskGuideView.h"

@interface EATaskAddTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic , strong) UICollectionView *collectionView;
@property(nonatomic , strong) UIButton *nextButton;

@property(nonatomic , strong) EATaskItemModel *model;

@end

@implementation EATaskAddTableViewController

+(instancetype)controller
{
    EATaskAddTableViewController *controller = [[EATaskAddTableViewController alloc]init];
    return controller;
}

-(void)initNavbar
{
    self.title = @"填写数据";
    UIImage *img = SYS_IMG(@"scan") ;
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(scanAction:)];
    self.navigationItem.rightBarButtonItem = scanItem;
    
}

-(void)scanAction:(id)sender
{
    EAScanViewController *controller = [EAScanViewController scanController];
    __weak typeof(self) wself = self;
    controller.doneBlock = ^(NSString *urlcode) {
//        wself.model.index = urlcode;
//        [wself.tableView reloadData];
    };
    [self.navigationController pushViewController:controller animated:true];
}

-(void)showGuide
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"shown_add_task_guide"]){
        EAAddTaskGuideView *guide = [EAAddTaskGuideView view];
        guide.frame = self.view.bounds;
        guide.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        guide.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:guide];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"shown_add_task_guide"];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initNavbar];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.width, SCREEN_HEIGHT - self.navigationController.navigationBar.bottom - 90);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, layout.itemSize.width, layout.itemSize.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[EATaskAddCollectionViewCell class] forCellWithReuseIdentifier:@"cell_id"];
    
    _collectionView.allowsSelection = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.pagingEnabled = YES;
    
    [self.view addSubview:_collectionView];
    [self.view addSubview:[self nextView]];
    
    
    _model = [[EATaskItemModel alloc]init];

    [self loadTaskItems];
    
    [self showGuide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mockData
{
    EATaskItemDataModel *dm1 = [[EATaskItemDataModel alloc]init];
    EATaskItemDataModel *dm2 = [[EATaskItemDataModel alloc]init];
    EATaskItemDataModel *dm3 = [[EATaskItemDataModel alloc]init];
    _model = [[EATaskItemModel alloc]init];
    NSArray *data = @[dm1,dm2,dm3];;
    _model.data = (NSArray<EATaskItemDataModel> *)data;
}

-(void)loadTaskItems
{
    
    [[TKRequestHandler sharedInstance] findPointData:self.task.tid completion:^(NSURLSessionDataTask *task, EATaskItemModel *model, NSError *error) {
        if (error == nil && model.success) {
            self.model = model;
            [self.collectionView reloadData];
        }else{
            [self mockData];
            [self.collectionView reloadData];
        }
    }];
}

-(UIView *)nextView
{
    UIView *nextView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - 90, SCREEN_WIDTH, 90)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:SYS_IMG(@"task_btn_next") forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, 43);
    [button addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(nextView.width/2, nextView.height/2);
    [nextView addSubview:button];
    self.nextButton = button;
    
    nextView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    return nextView;
}

-(void)nextAction
{
    NSInteger page = self.collectionView.contentOffset.x/self.collectionView.width;
    NSIndexPath *indexPath = nil;
    if (page < self.model.data.count-1) {
        indexPath = [NSIndexPath indexPathForItem:page+1 inSection:0];
          [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
    }else{
        EATaskItemDataModel *m = self.model.data[page];
        [self saveModel:m showLoading:true];
    }
}

-(void)saveModel:(EATaskItemDataModel *)m showLoading:(BOOL)showloading
{
    MBProgressHUD *hud = nil;
    if (showloading) {
        hud = [EATools showLoadHUD:self.view];
    }
    [[TKRequestHandler sharedInstance] savePointData:m.tagid createDate:m.meterDate value:m.readCount completion:^(NSURLSessionDataTask *task, BOOL success, NSError *error) {
        if (hud) {
            hud.label.text = @"保存失败";
            [hud hideAnimated:true afterDelay:1];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _model.data.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EATaskAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    
    EATaskItemDataModel *m = self.model.data[indexPath.item];
    [cell updateWithModel:m];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == _model.data.count -1) {
        
        [self.nextButton setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        [self.nextButton setTitle:@"下一个" forState:UIControlStateNormal];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
