//
//  EASettingViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASettingViewController.h"
#import "EAAboutViewController.h"
#import <SDImageCache.h>
#import "TKAccountManager.h"
#import "TKRequestHandler+Login.h"

@interface EASettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong) UITableView *tableView;

@end

@implementation EASettingViewController

+(instancetype)controller
{
    return [[EASettingViewController alloc]init];
}

-(void)logoutAction
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"您是否要退出登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[TKAccountManager sharedInstance] logout];
        [NotificationCenter postNotificationName:kLogoutNotification object:nil];
        
        [[TKRequestHandler sharedInstance] logoutCompletion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [controller addAction:confirm];
    [controller addAction:cancel];
    
    [self.navigationController presentViewController:controller animated:true completion:nil];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-70) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -30, 0, 0);
    
    [self.view addSubview:self.tableView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:HexColor(0x28cfc1)];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.titleLabel.font = SYS_FONT(18.5);
    button.frame = CGRectMake(18, self.view.height-70, self.view.width - 36, 45);
    [button addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
        cell.textLabel.font = SYS_FONT(17.5);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *title = nil;
    switch (indexPath.row) {
        case 0:
            title = @"新消息提醒";
            break;
        case 1:
            title = @"关于EIS Air";
            break;
            
        case 2:
            title = @"清除缓存";
            break;
        default:
            break;
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            NSURL *openURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication]openURL:openURL];
        }
            break;
        case 1:
        {
            EAAboutViewController *controller = [[EAAboutViewController alloc]init];
            [self.navigationController pushViewController:controller animated:true];
        }
            break;
        case 2:
        {
            MBProgressHUD *hud = [EATools showLoadHUD:self.view];
            hud.label.text = @"正在清除缓存";
            [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
                [hud hideAnimated:true afterDelay:0.5];
            }];            
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
