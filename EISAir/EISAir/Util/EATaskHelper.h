//
//  EATaskHelper.h
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , EATaskStatus) {
    EATaskStatusWait = 0 ,
    EATaskStatusExecute = 1,
    EATaskStatusFinish = 2,
    EATaskStatusInvalid = 3,
    EATaskStatusUnknown = 100
};

/*
 ISSUE("issue", "发出"), RECEIVE("receive", "领取任务"),
 COMPLETED("completed", "已完成"), UNFINISH("unfinish","未完成"),
 REFUSE("refuse", "已拒绝"), ASSIGN("assign", "指派");
 */

typedef NS_ENUM(NSInteger , EATaskExecuteStatus) {
    EATaskExecuteStatusIssue = 0 ,
    EATaskExecuteStatusReceive = 1,
    EATaskExecuteStatusCompleted = 2,
    EATaskExecuteStatusUnfinish = 3,
    EATaskExecuteStatusRefuse = 4,
    EATaskExecuteStatusAssign = 5,
    EATaskExecuteStatusInvalid = 6,
    EATaskExecuteStatusUnknown = 100,
};

@class EATaskDataListModel;
@interface EATaskHelper : NSObject

DEF_SINGLETON;

+(EATaskStatus)taskStatus:(EATaskDataListModel *)model;

+(EATaskExecuteStatus)taskMyExecuteStatus:(EATaskDataListModel *)model;

+(NSString *)executeStatusName:(EATaskExecuteStatus)status;

-(NSString *)valueForStatus:(NSString *)key;

-(NSString *)valueForExecuteStatus:(NSString *)key;

-(NSString *)statusForModel:(EATaskDataListModel *)model;

@end
