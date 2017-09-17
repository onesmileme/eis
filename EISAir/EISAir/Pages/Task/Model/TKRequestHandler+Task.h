//
//  TKRequestHandler+Task.h
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EATaskModel.h"
#import "EATaskFilterModel.h"
#import "EATaskStatusModel.h"

@interface TKRequestHandler (Task)

-(NSURLSessionDataTask *)findEisTask:(NSString *)tid filterParam:(EATaskFilterModel *)filterParam completion:(void(^)(NSURLSessionDataTask *task , EATaskModel *model , NSError *error))completion;

-(NSURLSessionDataTask *)deleteTaskById:(NSString *)taskId completion:(void(^)(NSURLSessionDataTask *task , BOOL success , NSError *error))completion;

-(NSURLSessionDataTask *)findDataComplete:(NSString *)taskId orgId:(NSString *)orgId siteId:(NSString *)siteId completion:(void(^)(NSURLSessionDataTask *task , BOOL success , NSError *error))completion;

-(NSURLSessionDataTask *)findEisTaskById:(NSString *)tid  completion:(void(^)(NSURLSessionDataTask *task , EATaskModel *model , NSError *error))completion;
/*
 * 查询我的任务
 */
-(NSURLSessionDataTask *)findMyTask:(EATaskFilterModel *)filterParam completion:(void(^)(NSURLSessionDataTask *task , EATaskModel *model , NSError *error))completion;

/*
 * 查询task 状态流转
 */
-(NSURLSessionDataTask *)findTaskResultByTaskId:(NSString *)taskId completion:(void(^)(NSURLSessionDataTask *task , EATaskStatusModel *model , NSError *error))completion;

@end
