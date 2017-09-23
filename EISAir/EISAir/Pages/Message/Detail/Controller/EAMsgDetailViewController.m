//
//  EAMsgDetailViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgDetailViewController.h"
#import "EAMsgDetailInfoCell.h"
#import "EAMsgStateInfoCell.h"
#import "EAMsgDetailHeader.h"
#import "TKRequestHandler+Task.h"

@interface EAMsgDetailViewController ()

//@property(nonatomic , strong) EATaskDataModel *taskDateModel;
@property(nonatomic , strong) NSArray *taskStatusList;

@end

@implementation EAMsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息详情";
    
    UINib *nib = [UINib nibWithNibName:@"EAMsgDetailInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"info_cell"];
    nib = [UINib nibWithNibName:@"EAMsgStateInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"state_cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 40, 0, 0);
    self.tableView.allowsSelection = false;
    
    [self loadTaskInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTaskInfo
{
//    if (![self.msgModel.msgType isEqualToString:EIS_MSG_TYPE_ALARM] && [self.msgModel.msgType isEqualToString:EIS_MSG_TYPE_EXCEPTION] ) {
//        //只有报警和异常才显示动态
//        return;
//    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [[TKRequestHandler sharedInstance]findTaskResultByTaskId:self.msgModel.businessId completion:^(NSURLSessionDataTask *task, EATaskStatusModel *model, NSError *error) {
        
        if (error || model.data == nil) {
            hud.label.text = @"获取动态信息失败";
            [hud hideAnimated:true afterDelay:0.7];
            [self.navigationController popViewControllerAnimated:true];
            return ;
        }
        [hud hideAnimated:true];
        self.taskStatusList = model.data;
        [self.tableView reloadData];
        
    }];
    
    
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
    return _taskStatusList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        
        EAMsgDetailInfoCell *icell = [tableView dequeueReusableCellWithIdentifier:@"info_cell"];
        [icell updateWithModel:self.msgModel];
        cell = icell;
        
    }else{
        EAMsgStateInfoCell *scell = [tableView dequeueReusableCellWithIdentifier:@"state_cell"];
        
        EATaskStatusDataModel *task = _taskStatusList[indexPath.row];
        
        [scell updateWithModel:task isFirst:indexPath.row == 0];
        
        cell = scell;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 91;
    }
    return 65;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 && _taskStatusList.count > 0) {
        return 32;
    }
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 && _taskStatusList.count > 0) {
        return 10;
    }
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 && _taskStatusList.count > 0) {
        
        EAMsgDetailHeader *header = [[EAMsgDetailHeader alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 32)];
        header.backgroundColor = [UIColor whiteColor];
        return header;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *footer = [[UIView alloc]init];
        footer.backgroundColor = HexColor(0xf7f7f7);
        return footer;
    }
    return nil;
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
