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

//+(void)load
//{
//    
//    //GET /eis/open/task/findTaskResultByTaskId
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findPointData",AppHost];
//        EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
//        
////        EATaskFilterModel *filter = [[EATaskFilterModel alloc]init];
////        filter.orgId = dinfo.orgId;
////        filter.siteId = dinfo.siteId;
////        filter.pageNum = 0;
////        filter.pageSize = @"20";
////        filter.dateType = @"check";
//        
//        
////        NSDictionary *param = [filter toDictionary ];
//        
//        NSDictionary *param = @{@"taskId":@"402881455e50c691015e50c7a66c0000",@"orgId":dinfo.orgId,@"siteId":dinfo.siteId};
//        [[TKRequestHandler sharedInstance]getRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
//            
//            if (error) {
//                NSLog(@"error is: \n%@",error);
//                NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
//                NSString *info = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
//                NSLog(@"info is: \n%@\n",info);
//            }
//            if (response) {
//                NSData *d = [NSJSONSerialization dataWithJSONObject:response options:kNilOptions error:nil];
//                NSString *json = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
//                NSLog(@"json is:+++++ \n%@\n\n",json);
//            }
//            
//        }];
//        
//    });
//}

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
-(NSURLSessionDataTask *)findEisTaskById:(NSString *)tid  completion:(void(^)(NSURLSessionDataTask *task , EATaskDetailModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findEisTaskById",AppHost];
    NSMutableDictionary *param = [@{@"id":tid} mutableCopy];
    
    EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
    param[@"siteId"] = dinfo.siteId;
    param[@"orgId"] = dinfo.orgId;
    
    return [self getRequestForPath:path param:param jsonName:@"EATaskDetailModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EATaskDetailModel *)model , error);
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

-(NSURLSessionDataTask *)findTaskResultByTaskId:(NSString *)taskId completion:(void(^)(NSURLSessionDataTask *task , EATaskStatusModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findTaskResultByTaskId",AppHost];
    EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
    NSDictionary *param = @{@"taskId":taskId?:@"",@"orgId":dinfo.orgId,@"siteId":dinfo.siteId};

    return [self getRequestForPath:path param:param jsonName:@"EATaskStatusModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EATaskStatusModel *)model , error);
        }
    }];
}

/*
 * 更改task状态
 */
-(NSURLSessionDataTask *)saveEisTaskResult:(EATaskUpdateModel *)filterParam completion:(void(^)(NSURLSessionDataTask *task , EATaskUpdateModel *model , NSError *error))completion
{
    ///eis/open/task/findEisTaskByUser
    
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/saveEisTaskResult",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    if (filterParam) {
        NSDictionary *json = [filterParam toDictionary];
        if (json) {
            [param addEntriesFromDictionary:json];
        }
    }
    
    return [self postRequestForPath:path param:param jsonName:@"EATaskUpdateModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EATaskUpdateModel *)model,error);
        }
    }];
}

///eis/open/task/findPointData

-(NSURLSessionDataTask *)findPointData:(NSString *)taskId completion:(void(^)(NSURLSessionDataTask *task , EATaskItemModel *model , NSError *error))completion
{
    
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/findPointData",AppHost];
    EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
    NSDictionary *param = @{@"taskId":taskId?:@"",@"orgId":dinfo.orgId,@"siteId":dinfo.siteId};
    
    return [self postRequestForPath:path param:param jsonName:@"EATaskItemModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EATaskItemModel *)model,error);
        }
    }];
}

//open/task/savePointData
-(NSURLSessionDataTask *)savePointData:(NSString *)tagId createDate:(NSString *)date value:(NSString *)value completion:(void(^)(NSURLSessionDataTask *task , BOOL success , NSError *error))completion
{
    
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/task/savePointData",AppHost];
    EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
    NSMutableDictionary *param = [@{@"orgId":dinfo.orgId,@"siteId":dinfo.siteId} mutableCopy];
    if (date.length > 0) {
        param[@"timestamp"] = date;
    }
    if (value.length > 0) {
        param[@"value"] = value;
    }
    if (tagId.length > 0) {
        param[@"tagid"] = tagId;
    }
    
    
    return [self postRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id response, NSError * _Nullable error) {
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
