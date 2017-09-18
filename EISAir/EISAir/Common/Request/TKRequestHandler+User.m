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
        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/user/findUsers",AppHost];
        EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
        NSDictionary *param = @{@"orgId":dinfo.orgId,@"siteId":dinfo.siteId};
        
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

-(NSURLSessionDataTask *)findUsersCompletion:(void(^)(NSURLSessionDataTask *task , EAUserModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/user/findUsers",AppHost];
    EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
    NSDictionary *param = @{@"orgId":dinfo.orgId,@"siteId":dinfo.siteId};
    
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
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/user/findLoginUser",AppHost];
    
    return [self getRequestForPath:path param:nil jsonName:@"EALoginUserInfoModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        
        if (completion) {
            completion(sessionDataTask,(EALoginUserInfoModel *)model,error);
        }
        
    }];
}

@end
