//
//  EATaskDetailViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskDetailViewController.h"
#import "EATaskStateInfoTableViewCell.h"
#import "EATaskStateDoingTableViewCell.h"
#import "TKRequestHandler+Task.h"
#import "EATaskHandleTableViewCell.h"
#import "EATaskStateTableViewCell.h"


@interface EATaskDetailViewController ()

@property(nonatomic , strong) NSMutableArray *stateList;
@property(nonatomic , assign) BOOL showHandle;

@end

@implementation EATaskDetailViewController

+(instancetype)controller
{
    EATaskDetailViewController *controller = [[EATaskDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    controller.hidesBottomBarWhenPushed = true;
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [[EATaskHelper sharedInstance] valueForStatus:self.task.taskStatus];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = false;
    
    UINib *nib = [UINib nibWithNibName:@"EATaskStateDoingTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"doing_cell"];
    
    nib = [UINib nibWithNibName:@"EATaskStateTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"state_cell"];
    
    nib = [UINib nibWithNibName:@"EATaskHandleTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"handle_cell"];
    
    nib = [UINib nibWithNibName:@"EATaskStateInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"info_cell"];
    
    _showHandle = [[self.task.taskStatus lowercaseString] isEqualToString:@"wait"];
    _stateList = [NSMutableArray new];
    
    [self loadTaskStatusInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTaskStatusInfo
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [[TKRequestHandler sharedInstance] findTaskResultByTaskId:self.task.tid completion:^(NSURLSessionDataTask *task, EATaskStatusModel *model, NSError *error) {
        if (error || !model.success) {
            hud.label.text = @"获取任务信息失败";
            [hud hideAnimated:true afterDelay:0.7];
        }else{
            [hud hideAnimated:true];
            [_stateList addObjectsFromArray:model.data];
            [self.tableView reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section = 2;
    if (_showHandle) {
        section += 1;
    }
    
    return section;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1 && _showHandle) {
        return 1;
    }
    return _stateList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(indexPath.section == 0){
        
        EATaskStateInfoTableViewCell *icell = [tableView dequeueReusableCellWithIdentifier:@"info_cell"];
        
        [icell updteWithModel:self.task];
        
        cell = icell;
        
    }else if (_showHandle && indexPath.section == 1 ) {
        
        EATaskHandleTableViewCell *hcell = [tableView dequeueReusableCellWithIdentifier:@"handle_cell"];
        if (!hcell.handleBlock) {
            hcell.handleBlock = ^(EATashHandler handler) {
                switch (handler) {
                    case EATashHandlerAccept:
                        
                        break;
                    case EATashHandlerReject:
                        
                        break;
                        
                    case EATashHandlerToOther:
                        
                        break;
                    default:
                        break;
                }
            };
        }
        
        cell = hcell;
        
    }else{
        
        EATaskStateTableViewCell *scell = [tableView dequeueReusableCellWithIdentifier:@"state_cell"];
        
        EATaskStatusDataModel *model = self.stateList[indexPath.row];
        [scell updateWithModel:model isStart:indexPath.row == 0 isLast:indexPath.row == self.stateList.count - 1];
        
        cell = scell;
        
//        EATaskStateDoingTableViewCell *dcell = [tableView dequeueReusableCellWithIdentifier:@"doing_cell"];
//
//        cell = dcell;
    }
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [EATaskStateInfoTableViewCell heightForModel:self.task];
    }
    if (_showHandle && indexPath.section == 1) {
        return 145;
    }
    
    return 65;//normal status
    //TODO: add executing height
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || (_showHandle && section == 2)) {
        return 10;
    }
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 || (_showHandle && section == 2)) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 00, self.view.width, 10)];
        header.backgroundColor = HexColor(0xf7f7f7);
        return header;
    }
    return nil;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
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
