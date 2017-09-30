//
//  EAUserSearchViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAUserSearchViewController.h"
#import "EAUserSearchHeader.h"
#import "TKRequestHandler+User.h"
#import "EAUserDataModel+Pinyin.h"

@interface EAUserSearchViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) NSArray *pinyinArray;
@property(nonatomic , strong) NSDictionary *nameDict;
@property(nonatomic , strong) EAUserSearchHeader *searchHeader;
@property(nonatomic , assign) NSInteger pageIndex;
@property(nonatomic , strong) NSMutableArray *userList;
@property(nonatomic , strong) NSMutableSet *choosedUsers;


@end

@implementation EAUserSearchViewController

-(void)initNavbar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction:)];
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.title.length == 0) {
        self.title = @"交接给";
    }
    
    [self initNavbar];
    
    _searchHeader = [[EAUserSearchHeader alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH,40 )];
    _searchHeader.searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchHeader;
    
    [self loadUsers];
    
    _choosedUsers = [[NSMutableSet alloc]init];
    self.tableView.allowsMultipleSelection = _multiChoose;
    
    
}

-(void)loadUsers
{
    MBProgressHUD *hud = [EATools showLoadHUD:self.view];
    self.userList = [NSMutableArray new];
    self.pageIndex = 0;
    [self loadUserReqeust:hud];
}

-(void)loadUserReqeust:(MBProgressHUD *)hud
{
    [[TKRequestHandler sharedInstance] findUsers:_pageIndex completion:^(NSURLSessionDataTask *task, EAUserModel *model, NSError *error) {
        if (error == nil && model.success) {
            [self.userList addObjectsFromArray:model.data.list];
            if (!model.data.lastPage && [model.data.pages integerValue] > self.pageIndex+1) {
                self.pageIndex++;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loadUserReqeust:hud];
                });
            }else{
                self.nameDict = [EAUserDataModel userPinyinDictForList:self.userList];
                self.pinyinArray = [[self.nameDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString *  _Nonnull obj2) {
                    return [obj1 compare:obj2];
                }];
                [hud hideAnimated:true];
                [self.tableView reloadData];
            }
        }
    }];
}

-(void)finishAction:(id)sender
{
    NSArray *users = nil;
    if ([_choosedUsers count] > 0 ) {
        users = [_choosedUsers allObjects];
    }
    if (_chooseUserBlock) {
        _chooseUserBlock(users);
    }
    
    [self.navigationController popViewControllerAnimated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_pinyinArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = _pinyinArray[section];
    NSArray *values = _nameDict[key];
    return [values count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor themeBlackColor];
        cell.textLabel.font =[UIFont systemFontOfSize:15];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = HexColor(0x28cfc1);
    }
    
    NSString *key = _pinyinArray[indexPath.section];
    NSArray *values = _nameDict[key];
    EAUserDataListModel *model = values[indexPath.row];
    cell.textLabel.text = model.name;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *key = _pinyinArray[section];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];//HexColor(0x00b0ce);
    label.text = key;
    [label sizeToFit];
    label.left = 16.5;
    label.centerY = 14;
    
    UIView *header = [[UIView alloc]init];
    [header addSubview:label];
    header.backgroundColor = HexColor(0xf7f7f7);
    
    return header;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _pinyinArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = _pinyinArray[indexPath.section];
    NSArray *values = _nameDict[key];
    EAUserDataListModel *model = values[indexPath.row];
    [_choosedUsers addObject:model];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = _pinyinArray[indexPath.section];
    NSArray *values = _nameDict[key];
    EAUserDataListModel *model = values[indexPath.row];
    [_choosedUsers removeObject:model];
}

#pragma mark - search bar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    return true;
}

@end
