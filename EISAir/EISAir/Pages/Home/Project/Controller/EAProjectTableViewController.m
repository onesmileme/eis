//
//  EAProjectTableViewController.m
//  EISAir
//
//  Created by chunhui on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAProjectTableViewController.h"
#import "EAProjectInfoTableViewCell.h"
#import "EAProjectTableViewCell.h"

@interface EAProjectTableViewController ()

@property(nonatomic , assign) NSInteger currentIndex;

@end

@implementation EAProjectTableViewController

+(instancetype)controller
{
    EAProjectTableViewController *controller = [[EAProjectTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"项目信息";
    
    UINib *nib = [UINib nibWithNibName:@"EAProjectInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"detail_cell"];
    nib = [UINib nibWithNibName:@"EAProjectTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"info_cell"];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    EALoginUserInfoDataSitesModel *model = _userInfo.sites[_currentIndex];
    
    if (indexPath.section == 0) {
       cell = [tableView dequeueReusableCellWithIdentifier:@"info_cell" ];
        
        switch (indexPath.row) {
            case 0://组织集团
                {
                    cell.textLabel.text = @"组织集团";
                    cell.detailTextLabel.text = model.orgName;
                }
                break;
            case 1:
            {
                cell.textLabel.text = @"当前站点";
                cell.detailTextLabel.text = model.name;
            }
            default:
                break;
        }
        
    }else{
        EAProjectInfoTableViewCell *c = [tableView dequeueReusableCellWithIdentifier:@"detail_cell"];
        NSString *icon = nil;
        NSString *title = nil;
        NSString *detail = nil;
        switch (indexPath.row) {
            case 0:
            {
                icon = @"set_icon5_1";
                title = @"建筑面积/层数";
                detail = [NSString stringWithFormat:@"%@㎡/%@层",model.area,model.floor];
            }
                break;
            case 1:
            {
                icon = @"set_icon5_2";
                title = @"建筑类型";
                detail = model.buildingType;
            }
                break;
            case 2:
            {
                icon = @"set_icon5_3";
                title = @"建筑年代";
                detail = model.buildingYear;
            }
                break;
            case 3:
            {
                icon = @"set_icon5_4";
                title = @"项目地址";
                detail = model.address;
            }
                break;
            default:
                break;
        }
        
        [c updateWithIcon:icon title:title detail:detail];
        
        cell = c;
    }

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
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
