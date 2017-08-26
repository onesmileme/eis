//
//  EABaseTableViewController.m
//  CaiLianShe
//
//  Created by chunhui on 16/3/2.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import "EABaseTableViewController.h"
#import "UIBarButtonItem+Navigation.h"
#import "UINavigationItem+margin.h"

@interface EABaseTableViewController ()

@property(nonatomic , assign) NSTimeInterval startShowTimestamp;

@end

@implementation EABaseTableViewController

+(instancetype)nibController
{
    NSString *name = NSStringFromClass(self);
    return  [[self alloc]initWithNibName:name bundle:nil];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _customRefreshTip = YES;
        _customBackItem = YES;
        _pagedurationLog = YES;
        self.pageName = @"";
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        _customBackItem = YES;
        _customRefreshTip = YES;
        _pagedurationLog = YES;
        self.pageName = @"";
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.customRefreshTip = YES;
    _customBackItem = YES;
    _pagedurationLog = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = false;
    self.automaticallyAdjustsScrollViewInsets = false;
    if (_customBackItem) {
        [self initBackItem];
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//-(void)initNavbarTitle
//{
//    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.text = self.title;
//    titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    titleLabel.textColor = [UIColor themeRedColor];
//    [titleLabel sizeToFit];
//    self.navigationItem.titleView = titleLabel;
//}

-(void)initBackItem
{
    UIBarButtonItem *backItem = [UIBarButtonItem defaultLeftItemWithTarget:self action:@selector(backAction)];
    
    [self.navigationItem setMarginLeftBarButtonItem:backItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //首页手指从最左侧滑动不处理
    if (self.navigationController &&  [[self.navigationController viewControllers] count] == 1) {
        return NO;
    }
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


//- (void)dealloc
//{
//    [self removeNightModelObserve];
//}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
