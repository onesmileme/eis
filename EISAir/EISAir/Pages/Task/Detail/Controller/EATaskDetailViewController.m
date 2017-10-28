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
#import "EAUserSearchViewController.h"
#import "EAUserModel.h"
#import "EATaskRejectChooseView.h"
#import "EATaskDetailEditViewController.h"
#import "EATaskHandleFeekbackTableViewCell.h"
#import "EATaskAddTableViewController.h"
#import "EATaskAddTableViewController.h"
#import "TKAccountManager.h"

@interface EATaskDetailViewController ()

@property(nonatomic , strong) NSMutableArray *stateList;
//@property(nonatomic , assign) BOOL showHandle;
@property(nonatomic , strong) UIView *taskHeader;

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
    
    nib = [UINib nibWithNibName:@"EATaskHandleFeekbackTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"feed_cell"];
    
    _stateList = [NSMutableArray new];
    
    [self loadTaskStatusInfo];
    
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

-(void)loadTaskStatusInfo
{
    MBProgressHUD *hud = [EATools showLoadHUD:[[UIApplication sharedApplication]keyWindow]];
    [[TKRequestHandler sharedInstance] findTaskResultByTaskId:self.task.tid completion:^(NSURLSessionDataTask *task, EATaskStatusModel *model, NSError *error) {
        if (error || !model.success) {
            hud.label.text = @"获取任务信息失败";
            [hud hideAnimated:true afterDelay:0.7];
        }else{
            [hud hideAnimated:true];
            [self processTaskStatus:model];
            [self.tableView reloadData];
        }
    }];
    
    [[TKRequestHandler sharedInstance] findEisTaskById:self.task.tid completion:^(NSURLSessionDataTask *task, EATaskDetailModel *model, NSError *error) {

        if (error == nil && model.success) {
            if (model.data.myExecuteStatus) {
                self.task.myExecuteStatus = model.data.myExecuteStatus;
                self.task.taskStatus = model.data.taskStatus;
                self.task = model.data;
                [self.tableView reloadData];
            }
        }

    }];

}

-(BOOL)showHandle
{
    EATaskStatus status = [EATaskHelper taskStatus:self.task];
    if (status == EATaskStatusWait) {
        EATaskExecuteStatus estatus = [EATaskHelper taskMyExecuteStatus:self.task];
        if (estatus != EATaskExecuteStatusAssign && estatus != EATaskExecuteStatusRefuse) {
            return true;
        }
    }
    return false;
}

-(BOOL)showFeedback
{
    EATaskStatus status = [EATaskHelper taskStatus:self.task];
    if (status == EATaskStatusExecute) {
        
        EALoginUserInfoDataModel *uinfo = [[TKAccountManager sharedInstance]loginUserInfo];
        EATaskStatusDataModel *stModel = [self.stateList firstObject];
        if ([stModel.personId isEqualToString:uinfo.personId]) {
            return true;
        }
    }
    
    return false;
}


-(void)processTaskStatus:(EATaskStatusModel *)statusModel
{
    EATaskStatusDataModel *delivery = nil;
    for (EATaskStatusDataModel * m in statusModel.data ) {
        if ([m.anewStatus isEqualToString:@"delivery"]) {
            delivery = m;
            break;
        }
    }
    
//    if (delivery) {
//
//        _stateList = [NSMutableArray new];
//       for (EATaskStatusDataModel * m in statusModel.data ) {
//
//           if (m != delivery ) {
//               //&& [delivery.deliveryTime compare:m.deliveryTime] == NSOrderedDescending
//               [_stateList addObject:m];
//           }
//       }
//    }else{
        _stateList = [[NSMutableArray alloc]initWithArray:statusModel.data];
//    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section = 2;
//    if ([self showHandle]) {
        section += 1; //handle
//    }
    
    section += 1;//feedback
    
    return section;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1 ) {
        if ([self showHandle]) {
            return 1;
        }
        return 0;
    }
    if (section == 2) {
        if ([self showFeedback]) {
            return 1;
        }
        return 0;
    }
    if (_stateList.count > 0) {
        return _stateList.count+1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(indexPath.section == 0){
        
        EATaskStateInfoTableViewCell *icell = [tableView dequeueReusableCellWithIdentifier:@"info_cell"];
        
        [icell updteWithModel:self.task];
        
        cell = icell;
        
    }else if ( indexPath.section == 1 ) {
        
        __weak typeof(self) wself = self;
        //拒绝或者执行任务
        EATaskHandleTableViewCell *hcell = [tableView dequeueReusableCellWithIdentifier:@"handle_cell"];
        if (!hcell.handleBlock) {
            hcell.handleBlock = ^(EATashHandler handler) {
                switch (handler) {
                    case EATashHandlerAccept:
                    {
                        [wself executeTask];
                    }
                        break;
                    case EATashHandlerReject:
                    {
                        [wself rejectTask];
                    }
                        break;
                        
                    case EATashHandlerToOther:
                    {
                        [wself choosePerson];
                    }
                        break;
                    default:
                        break;
                }
            };
        }
        
        cell = hcell;
    }else if (indexPath.section == 2){
        
        EATaskHandleFeekbackTableViewCell *fcell = [tableView dequeueReusableCellWithIdentifier:@"feed_cell"];
        
        if (!fcell.showFeedBack) {
            __weak typeof(self) wself = self;
            fcell.showFeedBack = ^{
                [wself showFeedbackPage];
            };
            
            fcell.showContent = ^{
                [wself handleAddTask];
            };
        }
        
        [fcell updateWithModel:self.task];
        
        cell = fcell;
        
    }else{
        
        if (indexPath.row == 0) {
            
            UITableViewCell *hcell = [tableView dequeueReusableCellWithIdentifier:@"header_cell"];
            if (!hcell) {
                hcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header_cell"];
                
                hcell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UILabel *label = [[UILabel alloc]init];
                label.font = SYS_FONT(13);
                label.textColor = HexColor(0xB0B0B0);
                label.text = @"任务时间线";
                [label sizeToFit];
                label.left = 14;
                label.top = 13.5;
                
                [hcell.contentView addSubview:label];
            }
            
            cell = hcell;
            
        }else{
            
            EATaskStateTableViewCell *scell = [tableView dequeueReusableCellWithIdentifier:@"state_cell"];
            
            NSInteger index = indexPath.row - 1;
            
            EATaskStatusDataModel *model = self.stateList[index];
            [scell updateWithModel:model isStart:index == 0 isLast:index == self.stateList.count - 1];
            
            cell = scell;
            
            //        EATaskStateDoingTableViewCell *dcell = [tableView dequeueReusableCellWithIdentifier:@"doing_cell"];
            //
            //        cell = dcell;
            
        }
        

    }
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [EATaskStateInfoTableViewCell heightForModel:self.task];
    }
    if ( indexPath.section == 1) {
        return 145;
    }
    if (indexPath.section == 2) {
        return 122;
    }
    
    if (indexPath.row == 0) {
        return 35;
    }
    return 65;//normal status
    //TODO: add executing height
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || ([self showHandle] && section == 2) || ([self showFeedback] && section == 3)) {
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
    if (section == 1 || ([self showHandle] && section == 2) || ([self showFeedback] && section == 3)) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 00, self.view.width, 10)];
        header.backgroundColor = HexColor(0xf7f7f7);
        return header;
    }
//    if (!_taskHeader) {
//        _taskHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
//
//        UILabel *label = [[UILabel alloc]init];
//        label.font = SYS_FONT(13);
//        label.textColor = HexColor(0xB0B0B0);
//        label.text = @"任务时间线";
//        [label sizeToFit];
//        label.left = 14;
//        label.top = 13.5;
//
//        [_taskHeader addSubview:label];
//    }
    
    
    return nil;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - task action
-(void)rejectTask
{
    EATaskRejectChooseView *v = [EATaskRejectChooseView view];
    __weak typeof(self) wself = self;
    v.actionBlock = ^(BOOL confirm) {
        if (confirm) {
            [wself rejectAction];
        }
    };
    [v showInView:self.view.window];
}

-(void)executeTask
{
    EATaskDetailEditViewController *controller = [EATaskDetailEditViewController nibController];
    controller.showAssign = false;
    controller.placeHoder = @"完成任务情况描述";
    controller.title = @"执行中";
    controller.task = self.task;
    controller.editType = EATaskEditTypeExecute;
    __weak typeof(self) wself = self;
    controller.doneBlock = ^(NSString *content, EAUserDataListModel *user) {
        [wself loadTaskStatusInfo];
    };
    
    [self.navigationController pushViewController:controller animated:true];
}

-(void)choosePerson
{
    EAUserSearchViewController *controller = [[EAUserSearchViewController alloc]init];
    controller.hidesBottomBarWhenPushed = true;
    controller.title = @"指派给";
    controller.multiChoose = true;
    __weak typeof(self) wself = self;
    controller.chooseUserBlock = ^(NSArray<EAUserDataListModel *> *users) {
        if (users) {
            [wself assignToOtherAction:users];
        }        
    };
    [self.navigationController pushViewController:controller animated:true];
}

-(void)rejectAction
{
    EATaskDetailEditViewController *controller = [EATaskDetailEditViewController nibController];
    controller.showAssign = false;
    controller.placeHoder = @"为什么拒绝";
    controller.title = @"拒绝原因";
    controller.task = self.task;
    controller.editType = EATaskEditTypeReject;
    __weak typeof(self) wself = self;
    controller.doneBlock = ^(NSString *content, EAUserDataListModel *user) {
        [wself loadTaskStatusInfo];
    };
    
    [self.navigationController pushViewController:controller animated:true];
    
}

-(void)assignToOtherAction:(NSArray<EAUserDataListModel *> *)users
{
    EATaskUpdateModel *model = [[EATaskUpdateModel alloc]init];
    NSMutableArray *uids = [[NSMutableArray alloc]init];
    for (EAUserDataListModel *m in users) {
        [uids addObject: m.uid];
    }
    model.transferPersonIds = uids;
    model.anewStatus = @"assign";
    model.taskId = self.task.tid;
    
    MBProgressHUD *hud = [EATools showLoadHUD:self.view];
    [[TKRequestHandler sharedInstance] saveEisTaskResult:model completion:^(NSURLSessionDataTask *task, EATaskUpdateModel *model, NSError *error) {
        if (error == nil && model) {
            [hud hideAnimated:true];
            
            [self loadTaskStatusInfo];
        }else{
            hud.label.text = @"指派失败";
            [hud hideAnimated:true afterDelay:0.7];
        }
    }];
    
}

-(void)showFeedbackPage
{
    EATaskDetailEditViewController *controller = [EATaskDetailEditViewController nibController];
    controller.showAssign = false;
    controller.placeHoder = @"完成任务情况描述";
    controller.title = @"执行中";
    controller.editType = EATaskEditTypeAssign;
    controller.task = self.task;
    __weak typeof(self) wself = self;
    controller.doneBlock = ^(NSString *content, EAUserDataListModel *user) {
        [wself loadTaskStatusInfo];
    };
    
    [self.navigationController pushViewController:controller animated:true];
}

-(void)handleAddTask
{
    EATaskAddTableViewController *controller = [EATaskAddTableViewController controller];
    controller.task = self.task;
    __weak typeof(self) wself = self;
    controller.completionBlock = ^{
        [wself loadTaskStatusInfo];
    };
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
