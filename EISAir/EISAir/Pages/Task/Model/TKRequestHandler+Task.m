//
//  TKRequestHandler+Task.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Task.h"
#import "EANetworkManager.h"
#import "TKAccountManager.h"

@implementation TKRequestHandler (Task)

+(void)load
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findEisTaskById",AppHost];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        param[@"id"] = @"fccae9b4770347ab858709ca7efb55f0";
        [[TKRequestHandler sharedInstance]getRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"error is: \n%@",error);
            }
            if (response) {
                NSData *d = [NSJSONSerialization dataWithJSONObject:response options:kNilOptions error:nil];
                NSString *json = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
                NSLog(@"json is: \n%@\n\n",json);
            }
            
        }];
        
    });
}

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
    NSMutableDictionary *param = [@{@"id":tid} mutableCopy];
    
    EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
    param[@"siteId"] = dinfo.siteId;
    param[@"orgId"] = dinfo.orgId;
    
    return [self postRequestForPath:path param:param jsonName:@"EATaskModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EATaskModel *)model , error);
        }
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

//-(NSURLSessionDataTask *)findEisTaskById:(NSString *)taskId completion:(void(^)(NSURLSessionDataTask *task , EATaskModel *model , NSError *error))completion
//{
//    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findEisTaskById",AppHost];
//    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//    param[@"id"] = taskId?:@"";
//
//    return [self postRequestForPath:path param:param jsonName:@"EATaskModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
//        if (completion) {
//            completion(sessionDataTask,(EATaskModel *)model,error);
//        }
//    }];
//}

@end
