//
//  EAUserInfoModifyViewController.m
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAUserInfoModifyViewController.h"
#import "EAModifyPasswordViewController.h"
#import "EAUserInfoAvatarCell.h"
#import "EALoginUserInfoModel.h"

@interface EAUserInfoModifyViewController ()

@end

@implementation EAUserInfoModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        
        EAUserInfoAvatarCell *c = [tableView dequeueReusableCellWithIdentifier:@"avatar_cell"];
        
        
        cell = c;
        
    }else{
        
        
        
        if (indexPath.row == 0 || indexPath.row == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"info_cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"info_cell"];
            }
            cell.detailTextLabel.textColor = HexColor(0xd8d8d8);
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
        }
        
        if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSString *title = nil;
        NSString *detail = nil;
        switch (indexPath.row) {
            case 0://登录名
                title = @"登录名";
                detail = self.userInfo.loginName;
                break;
            case 1:
                title = @"角色";
                detail = self.userInfo.roleName;
                break;
            case 2:
                title = @"修改密码";
                break;
            case 3:
                title = @"邮箱";
                break;
            case 4:
                title = @"手机号";
                break;
            default:
                break;
        }
        
        cell.textLabel.text = title;
        if (detail) {
            cell.detailTextLabel.text = detail;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  CGFLOAT_MIN;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        EAModifyPasswordViewController *controller = [[EAModifyPasswordViewController alloc]init];
        [self.navigationController pushViewController:controller animated:true];
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
