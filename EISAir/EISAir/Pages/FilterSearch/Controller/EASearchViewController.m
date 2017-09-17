//
//  EASearchViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASearchViewController.h"
#import "EAMessageSearchFilterView.h"
#import "EAScanViewController.h"
#import "EAMsgSearchHistoryView.h"
#import "TKRequestHandler+Search.h"
#import "TKRequestHandler+Message.h"
#import "EAMessageFilterResultViewController.h"


@interface EASearchViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) UITextField *searchBar;
@property(nonatomic , strong) EAMessageSearchFilterView *filterView;
@property(nonatomic , strong) EAMsgSearchHistoryView *historyView;
@property(nonatomic , strong) NSMutableArray *historyKeys;
@property(nonatomic , strong) NSMutableArray *objList;
@property(nonatomic , copy)   NSString *searchKey;
@property(nonatomic , weak)   NSURLSessionDataTask *task;

@end

@implementation EASearchViewController


-(void)initNavbar
{
    _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 33)];
    _searchBar.borderStyle = UITextBorderStyleNone;
    _searchBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    _searchBar.layer.cornerRadius = 4;
    _searchBar.layer.masksToBounds = true;
    _searchBar.delegate = self;
    
    //left view
    //search
    UIImageView *searchView =  [[UIImageView alloc]initWithImage:SYS_IMG(@"seach_icon1")];
    searchView.contentMode = UIViewContentModeCenter;
    searchView.frame = CGRectMake(0, 0, 35, 33);
    _searchBar.leftView = searchView;
    
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.titleView = _searchBar;
    
    _searchBar.font = SYS_FONT(14);
    
    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"请输入名称描述" attributes:@{NSFontAttributeName:SYS_FONT(14),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _searchBar.attributedPlaceholder = placeholder;
    
    UIImage *img = SYS_IMG(@"scan") ;
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(scanAction:)];
    self.navigationItem.rightBarButtonItem = scanItem;
}

-(EAMessageSearchFilterView *)filterView
{
    if (!_filterView) {
        CGRect frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64);
        
        NSArray *items = @[@{@"name":@"1111",@"info":@"2222"} , @{@"name":@"3333",@"info":@"2222"} , @{@"name":@"4444",@"info":@"2222"}];
        
        _filterView = [[EAMessageSearchFilterView alloc]initWithFrame:frame items:items];
    }
    return _filterView;
}

-(EAMsgSearchHistoryView *)historyView
{
    if (!_historyView) {
        CGRect frame = self.view.bounds;
        _historyView = [[EAMsgSearchHistoryView alloc]initWithFrame:frame];
        _historyView.clearBlock = ^{
            
        };
        _historyView.chooseBlock = ^(NSString *key) {
            
        };
    }
    return _historyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavbar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.historyKeys = [[NSMutableArray alloc]init];
    NSArray *keys = [[NSUserDefaults standardUserDefaults] objectForKey:@"history_key"];
    
//    keys = @[@"abc",@"haha",@"消息",@"说些什么",@"dingding"];
    
    [self.historyKeys addObjectsFromArray:keys];
            
    if (keys.count > 0) {
        [self.historyView updateWithKeys:keys];
        [self.tableView addSubview:self.historyView];
        self.tableView.scrollEnabled = false;
    }
    
    _objList = [NSMutableArray new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:self.historyKeys forKey:@"history_key"];
}

-(void)scanAction:(id)sender
{
    EAScanViewController *controller = [EAScanViewController scanController];
    [self.navigationController pushViewController:controller animated:true];
}

-(void)search:(NSString *)text
{
    if (text.length == 0) {
        return;
    }
    if (self.task.state == NSURLSessionTaskStateRunning) {
        [self.task cancel];
    }
    EAMsgFilterModel *filterModel = [[EAMsgFilterModel alloc]init];
    filterModel.objName = text;
    NSURLSessionDataTask *task = [[TKRequestHandler sharedInstance] searchWithFilterParam:filterModel completion:^(NSURLSessionDataTask *task, EAMsgSearchTipModel *model, NSError *error) {
        if (model.data.count > 0) {
            self.searchKey = text;
            [self.objList removeAllObjects];
            [self.objList addObjectsFromArray:model.data];
            [self.tableView reloadData];
        }
    }];
    self.task = task;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_objList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    UIView *split = [cell.contentView viewWithTag:100];
    if (!split) {
        split = [[UIView alloc]initWithFrame:CGRectMake(0, 42, self.view.width, 0.5)];
        split.backgroundColor = HexColor(0xf3f3f3);
        split.tag = 100;
        [cell.contentView addSubview:split];
    }
    EAMsgSearchTipDataModel *model = _objList[indexPath.row];
    cell.textLabel.attributedText = [self titleFor:model.objName];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.searchBar.text;
    NSInteger index =-1;
    for (NSInteger i = 0 ; i  < self.historyKeys.count ; i++) {
        NSString *str = self.historyKeys[i];
        if ([str isEqualToString:key]) {
            index = i;
            break;
        }
    }
    if (index >= 0) {
        [self.historyKeys removeObjectAtIndex:index];
    }
    [self.historyKeys insertObject:key atIndex:0];
    
    //show detail
    EAMsgSearchTipDataModel *model = _objList[indexPath.row];
    
    EAMessageFilterResultViewController *controller = [[EAMessageFilterResultViewController alloc]init];
    EAMsgFilterModel *filterModel = [[EAMsgFilterModel alloc]init];
    filterModel.objList = @[model.objId];
    [self.navigationController pushViewController:controller animated:true];    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.5;
}

-(NSAttributedString *)titleFor:(NSString *)objName
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:objName attributes:@{NSFontAttributeName:SYS_FONT(14),NSForegroundColorAttributeName:HexColor(0x2a2a2a)}];
    NSDictionary *dict = @{NSForegroundColorAttributeName:HexColor(0xb0b0b0)};
    for (NSInteger i = 0 ; i < objName.length ; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *sub = [objName substringWithRange:range];
        if ([self.searchKey containsString:sub]) {
            [title addAttributes:dict range:range];
        }
    }
    
    return title;
}

#pragma mark - uitextfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.historyView.superview) {
        [self.historyView removeFromSuperview];
        self.tableView.scrollEnabled = true;
    }
    
    return true;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *content = [[NSMutableString alloc]initWithString:textField.text ];
    
    [content replaceCharactersInRange:range withString:string];
    
    [self search:content];
    
    return true;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self search:textField.text];
    [textField resignFirstResponder];
    return true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
