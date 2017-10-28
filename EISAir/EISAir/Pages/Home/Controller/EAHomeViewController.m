//
//  EAHomeViewController.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAHomeViewController.h"
#import "EAHomeHeaderView.h"
#import "EAHomeFooterView.h"
#import "EAHomeTableViewCell.h"
#import "TKAccountManager.h"
#import "EAPushManager.h"
#import "TKRequestHandler+User.h"
#import "EAProjectTableViewController.h"
#import "EAUserInfoViewController.h"
#import "TKRequestHandler+User.h"

@interface EAHomeViewController ()

@property(nonatomic , strong) EAHomeHeaderView *headerView;
@property(nonatomic , strong) EAHomeFooterView *footerView;
@property(nonatomic , strong) UIButton *backBtn;
@end

@implementation EAHomeViewController

+(instancetype)controller
{
    EAHomeViewController *controller = [[EAHomeViewController alloc]initWithStyle:UITableViewStyleGrouped];
    controller.hidesBottomBarWhenPushed = true;
    
    return controller;
}

-(void)initnav
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 30, 45, 36);
    UIImage *img = SYS_IMG(@"normal_back");
    [backBtn setBackgroundImage:img forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UINib *nib = [UINib nibWithNibName:@"EAHomeHeaderView" bundle:nil];
    self.headerView = [[nib instantiateWithOwner:self options:nil] firstObject];
    
    self.footerView = [[EAHomeFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    nib = [UINib nibWithNibName:@"EAHomeTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell_id"];
    
    self.tableView.backgroundColor = HexColor(0xf7f7f7);
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    EALoginUserInfoDataModel *model = [TKAccountManager sharedInstance].loginUserInfo;
    [self.headerView updateModel:model];
    
    __weak typeof(self) wself = self;
    self.headerView.tapAvatarBlock = ^{
        [wself showUserInfo];
    };
    
    [self loadUserInfo];
    
    [self initnav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}

-(void)loadUserInfo
{
    [[TKRequestHandler sharedInstance] findLoginUserCompletion:^(NSURLSessionDataTask *task, EALoginUserInfoModel *model, NSError *error) {
        if (model.success) {
            [self.headerView updateModel:model.data];
            [TKAccountManager sharedInstance].loginUserInfo = model.data;
            [[TKAccountManager sharedInstance] save];
        }
    }];
    
    [[TKRequestHandler sharedInstance]findCountByUserCompletion:^(NSURLSessionDataTask *task, NSInteger taskCount, NSInteger workRecordCount, NSInteger reportCount, NSError *error) {
        if (error == nil) {
            [self.headerView updateTask:taskCount record:workRecordCount report:reportCount];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EAHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    
    NSString *img = nil;
    NSString *title = nil;
    NSString *detail = nil;
    switch (indexPath.section) {
        case 0:
        {
            img = @"set_icon1";
            title = @"项目信息";
            EALoginUserInfoDataModel *udata = [TKAccountManager sharedInstance].loginUserInfo;
            EALoginUserInfoDataSitesModel *site = [udata.sites firstObject];
            detail = site.name;
            break;
        }
        case 1:
        {
            img = @"set_icon2";
            title = @"设置";
            detail = @"";
            break;
        }
            
        default:
            break;
    }
    
    cell.imageView.image = SYS_IMG(img);
    cell.textLabel.text = title;
    cell.detailTextLabel.text = detail;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 42;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *h = [[UIView alloc]init];
    h.backgroundColor = [UIColor clearColor];
    return h;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *f = [[UIView alloc]init];
    f.backgroundColor = [UIColor clearColor];
    
    return f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    switch (indexPath.section) {
        case 0:
        {
            EAProjectTableViewController *controller = [EAProjectTableViewController controller];
            controller.userInfo = [TKAccountManager sharedInstance].loginUserInfo;
            [self.navigationController pushViewController:controller animated:true];
        }
            break;
        case 1:
        {
            [[EAPushManager sharedInstance] handleOpenUrl:@"eis://show_setting"];
        }
            break;
        default:
            break;
    }
}

-(void)showUserInfo
{
    EAUserInfoViewController *controller = [EAUserInfoViewController controller];
    controller.userInfo = [TKAccountManager sharedInstance].loginUserInfo;
    [self.navigationController pushViewController:controller animated:true];
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
