//
//  EATaskHelper.m
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskHelper.h"

@interface EATaskHelper()

@property(nonatomic , strong) NSDictionary *taskExecuteStatusDict;
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
        _taskExecuteStatusDict = @{@"issue":@"发出",@"receive":@"领取任务",@"completed":@"已完成",@"unfinish":@"未完成",@"refuse":@"已拒绝",@"assign":@"指派"};
    }
    return self;
}

-(NSString *)valueForStatus:(NSString *)key
{
    return _taskStatusDict[key];
}

-(NSString *)valueForExecuteStatus:(NSString *)key
{
    return _taskExecuteStatusDict[key];
}

@end
