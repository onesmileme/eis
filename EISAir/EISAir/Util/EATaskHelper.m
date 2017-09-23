//
//  EATaskHelper.m
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskHelper.h"
#import "EATaskModel.h"
@interface EATaskHelper()

@property(nonatomic , strong) NSDictionary *taskExecuteStatusDict;
@property(nonatomic , strong) NSDictionary *taskMyExecuteStatusDict;
@property(nonatomic , strong) NSDictionary *taskStatusDict;

@end

@implementation EATaskHelper

IMP_SINGLETON

-(instancetype)init
{
    self = [super init];
    if (self) {
        /*
         WAIT("wait", "待执行"), EXECUTE("execute", "执行中"), FINISH("finish", "已完成"), INVALID("invalid", "已失效");
         */
        _taskStatusDict = @{@"wait":@"待执行" ,@"execute":@"执行中" ,@"finish":@"已完成" , @"invalid":@"已失效"};
        /*
         ISSUE("issue", "发出"), RECEIVE("receive", "领取任务"),
         COMPLETED("completed", "已完成"), UNFINISH("unfinish","未完成"),
         REFUSE("refuse", "已拒绝"), ASSIGN("assign", "指派");
         */
        _taskExecuteStatusDict = @{@"issue":@"发出",@"receive":@"领取任务",@"completed":@"已完成",@"unfinish":@"未完成",@"refuse":@"已拒绝",@"assign":@"指派",@"invalid":@"已失效"};
        
        _taskMyExecuteStatusDict = @{@"completed":@"该任务已完成！",@"refuse":@"你已拒绝该任务！",@"assign":@"你已指派该任务！",@"invalid":@"该任务已失效！"};
    }
    return self;
}

+(EATaskStatus)taskStatus:(EATaskDataListModel *)model
{
    EATaskStatus status = EATaskStatusUnknown;
    NSString *s = [model.taskStatus lowercaseString];
    if ([s isEqualToString:@"wait"]) {
        status = EATaskStatusWait;
    }else if ([s isEqualToString:@"execute"]){
        status = EATaskStatusExecute;
    }else if ([s isEqualToString:@"finish"]){
        status = EATaskStatusFinish;
    }else if ([s isEqualToString:@"invalid"]){
        status = EATaskStatusInvalid;
    }
    
    return status;
}

+(EATaskExecuteStatus)taskMyExecuteStatus:(EATaskDataListModel *)model
{
    EATaskExecuteStatus status = EATaskExecuteStatusUnknown;
    NSString *s = [model.myExecuteStatus lowercaseString];
    if ([s isEqualToString:@"issue"]) {
        status = EATaskExecuteStatusIssue;
    }else if ([s isEqualToString:@"receive"]) {
        status = EATaskExecuteStatusReceive;
    }else if ([s isEqualToString:@"completed"]) {
        status = EATaskExecuteStatusCompleted;
    }else if ([s isEqualToString:@"unfinish"]) {
        status = EATaskExecuteStatusUnfinish;
    }else if ([s isEqualToString:@"refuse"]) {
        status = EATaskExecuteStatusRefuse;
    }else if ([s isEqualToString:@"assign"]) {
        status = EATaskExecuteStatusAssign;
    }else if ([s isEqualToString:@"invalid"]) {
        status = EATaskExecuteStatusInvalid;
    }
    
    return status;
}

+(NSString *)executeStatusName:(EATaskExecuteStatus)status
{
    /*
     EATaskExecuteStatusIssue = 0 ,
     EATaskExecuteStatusReceive = 1,
     EATaskExecuteStatusCompleted = 2,
     EATaskExecuteStatusUnfinish = 3,
     EATaskExecuteStatusRefuse = 4,
     EATaskExecuteStatusAssign = 5,
     EATaskExecuteStatusInvalid = 6,
     EATaskExecuteStatusUnknown = 100,
     */
    
    switch (status) {
        case EATaskExecuteStatusIssue:
            return @"issue";
            break;
        case EATaskExecuteStatusAssign:
            return @"assign";
        case EATaskExecuteStatusRefuse:
            return @"refuse";
        case EATaskExecuteStatusInvalid:
            return @"invalid";
        case EATaskExecuteStatusReceive:
            return @"receive";
        case EATaskExecuteStatusCompleted:
            return @"completed";
        case EATaskExecuteStatusUnfinish:
            return @"unfinish";
        default:
            break;
    }
    
    return nil;
}

-(NSString *)valueForStatus:(NSString *)key
{
    return _taskStatusDict[key];
}

-(NSString *)valueForExecuteStatus:(NSString *)key
{
    return _taskExecuteStatusDict[key];
}

-(NSString *)statusForModel:(EATaskDataListModel *)model
{
    return _taskMyExecuteStatusDict[model.myExecuteStatus];
}

@end
