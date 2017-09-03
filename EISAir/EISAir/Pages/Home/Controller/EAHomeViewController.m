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

@interface EAHomeViewController ()

@property(nonatomic , strong) EAHomeHeaderView *headerView;
@property(nonatomic , strong) EAHomeFooterView *footerView;

@end

@implementation EAHomeViewController

+(instancetype)controller
{
    EAHomeViewController *controller = [[EAHomeViewController alloc]initWithStyle:UITableViewStyleGrouped];
    controller.hidesBottomBarWhenPushed = true;
    
    return controller;
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
    
    [self.headerView updateModel:nil];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    switch (indexPath.section) {
        case 0:
        {
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
