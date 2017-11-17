//
//  TKRequestHandler+User.m
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+User.h"
#import "TKAccountManager.h"

@implementation TKRequestHandler (User)

#if 0

+(void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //GET /eis/open/user/findCountByUser
        NSString *path = [NSString stringWithFormat:@"%@/eis/open/user/findCountByUser", AppHost];
        EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
        NSDictionary *param = nil;//@{@"orgId":dinfo.orgId,@"siteId":dinfo.siteId};
        
        [[TKRequestHandler sharedInstance] getRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"error is: \n%@",error);
                NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSString *info = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
                NSLog(@"info is: \n%@\n",info);
            }
            if (response) {
                NSData *d = [NSJSONSerialization dataWithJSONObject:response options:kNilOptions error:nil];
                NSString *json = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
                NSLog(@"json is:+++++ \n%@\n\n",json);
            }
            
        }];
    });
}

#endif

-(NSURLSessionDataTask *)findUsers:(NSInteger)pageNum completion:(void(^)(NSURLSessionDataTask *task , EAUserModel *model , NSError *error))completion
{
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/user/findUsers",AppHost];
#else
        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/user/findUsers",AppHost];
#endif
    EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
    NSDictionary *param = @{@"orgId":dinfo.orgId,@"siteId":dinfo.siteId,@"pageSize":@"300",@"pageNum":@(pageNum)};
    
    return [self getRequestForPath:path param:param jsonName:@"EAUserModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        
        if (completion) {
            completion(sessionDataTask,(EAUserModel *)model,error);
        }
        
    }];
}

/*
 * 获取登录用户信息
 */
-(NSURLSessionDataTask *)findLoginUserCompletion:(void(^)(NSURLSessionDataTask *task , EALoginUserInfoModel *model , NSError *error))completion
{
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/user/findLoginUser",AppHost];
#else
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/user/findLoginUser",AppHost];
#endif
    
    return [self getRequestForPath:path param:nil jsonName:@"EALoginUserInfoModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        
        if (completion) {
            completion(sessionDataTask,(EALoginUserInfoModel *)model,error);
        }
        
    }];
}
//findCountByUser
-(NSURLSessionDataTask *)findCountByUserCompletion:(void(^)(NSURLSessionDataTask *task , NSInteger taskCount , NSInteger workRecordCount , NSInteger reportCount , NSError *error))completion
{
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/user/findCountByUser",AppHost];
#else
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/user/findCountByUser",AppHost];
#endif
    return [self getRequestForPath:path param:nil finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        
        NSInteger taskCount = 0;
        NSInteger workRecordCount = 0;
        NSInteger reportCount = 0;
        
        if (completion) {
            if (error == nil && response[@"data"]) {
                NSDictionary *data = response[@"data"];
                if ([data[@"taskCount"] respondsToSelector:@selector(integerValue)]) {
                    taskCount = [data[@"taskCount"] integerValue];
                }
                
                if ([data[@"workRecordCount"] respondsToSelector:@selector(integerValue)]) {
                    workRecordCount = [data[@"workRecordCount"] integerValue];
                }
                if ([data[@"reportCount"] respondsToSelector:@selector(integerValue)]) {
                    reportCount = [data[@"reportCount"]integerValue];
                }
            }
            
            completion(sessionDataTask,taskCount,workRecordCount,reportCount,error);
        }
        
    }];
}

@end
