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

@interface EASettingViewController ()

@end

@implementation EASettingViewController

+(instancetype)controller
{
    return [[EASettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -30, 0, 0);
    
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
        case 1:
        {
            EAAboutViewController *controller = [[EAAboutViewController alloc]init];
            [self.navigationController pushViewController:controller animated:true];
        }
            break;
        case 2:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
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
