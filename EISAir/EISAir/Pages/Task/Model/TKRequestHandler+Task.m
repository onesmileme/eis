//
//  TKRequestHandler+Task.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Task.h"
#import "EANetworkManager.h"

@implementation TKRequestHandler (Task)

-(NSURLSessionDataTask *)findEisTask:(NSString *)tid filterParam:(EATaskFilterModel *)filterParam completion:(void(^)(NSURLSessionDataTask *task , EATaskModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findEisTask",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    if (filterParam) {
        NSDictionary *json = [filterParam toDictionary];
        if (json) {
            [param addEntriesFromDictionary:json];
        }
    }
    
    return [self postRequestForPath:path param:param jsonName:@"EATaskModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        
    }];
}

//删除任务
-(NSURLSessionDataTask *)deleteTaskById:(NSString *)taskId completion:(void(^)(NSURLSessionDataTask *task , BOOL success , NSError *error))completion
{
    //GET /eis/open/task/deleteEisTaskById
        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/deleteEisTaskById",AppHost];
    
    NSDictionary *param = @{@"id":taskId};
    return [self getRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        
        if (completion) {
            BOOL success = false;
            if (response) {
                if ([response[@"success"] boolValue]) {
                    success = true;
                }else{
                    error = [NSError errorWithDomain:@"请求失败" code:-10000 userInfo:nil];
                }
            }

            completion(sessionDataTask,success,error);
        }
    }];
}

//GET /eis/open/task/findDataComplete
-(NSURLSessionDataTask *)findDataComplete:(NSString *)taskId orgId:(NSString *)orgId siteId:(NSString *)siteId completion:(void(^)(NSURLSessionDataTask *task , BOOL success , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findDataComplete",AppHost];
    NSDictionary *param = @{@"taskId":taskId,@"orgId":orgId?:@"",@"siteId":siteId};
    
    return [self getRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        if (completion) {
            BOOL success = false;
            if (response) {
                if ([response[@"success"] boolValue]) {
                    success = true;
                }else{
                    error = [NSError errorWithDomain:@"请求失败" code:-10000 userInfo:nil];
                }
            }
            completion(sessionDataTask,success,error);
        }
    }];
    
}

//GET /eis/open/task/findEisTaskById 根据任务id查询任务
-(NSURLSessionDataTask *)findEisTaskById:(NSString *)tid  completion:(void(^)(NSURLSessionDataTask *task , EATaskModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findEisTask",AppHost];
    NSDictionary *param = @{@"id":tid};
    
    
    return [self postRequestForPath:path param:param jsonName:@"EATaskModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        
    }];
}


//查询我的任务
-(NSURLSessionDataTask *)findMyTask:(EATaskFilterModel *)filterParam completion:(void(^)(NSURLSessionDataTask *task , EATaskModel *model , NSError *error))completion
{
    ///eis/open/task/findEisTaskByUser
    

    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findEisTaskByUser",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    if (filterParam) {
        NSDictionary *json = [filterParam toDictionary];
        if (json) {
            [param addEntriesFromDictionary:json];
        }
    }
    
    return [self postRequestForPath:path param:param jsonName:@"EATaskModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EATaskModel *)model,error);
        }
    }];
}



@end
