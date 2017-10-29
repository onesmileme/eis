//
//  TKRequestHandler+UserInfo.m
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+UserInfo.h"
#import "TKAccountManager.h"

@implementation TKRequestHandler (UserInfo)


-(NSURLSessionDataTask *)updateUserInfo:(EAUserInfoFilterModel *)model completion:(void (^)(NSURLSessionDataTask *task , NSDictionary *model , NSError *error))completion
{

    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/user/updateUser",AppHost];
    
    EALoginUserInfoDataModel *user = [[TKAccountManager sharedInstance]loginUserInfo];

    if (!model.personId) {
        model.personId = user.personId;
    }
    if (!model.loginName) {
        model.loginName = user.loginName;
    }
    if (!model.mobile) {
        model.mobile = user.mobile;
    }
    if (!model.email) {
        model.email = user.email;
    }
    if (!model.name) {
        model.name = user.name;
    }
    
    NSDictionary *param = [model toDictionary];
    
    NSURLSessionDataTask *task =  [[TKRequestHandler sharedInstance] postRequestForPath:path param:param  finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, NSDictionary * _Nullable model, NSError * _Nullable error) {
        
        if (completion) {
            completion(sessionDataTask,model , error);
        }
        
    } ];
    
    return task;
}

-(NSURLSessionDataTask *)modifyPassword:(NSString *)newPwd oldPassword:(NSString *)oldPwd completion:(void (^)(NSURLSessionDataTask *task , BOOL success , NSError *error))completion
{
    NSDictionary *param = @{@"newPasswd":newPwd?:@"",@"oldPasswd":oldPwd?:@""};
    
    //
    NSString *path = [NSString stringWithFormat:@"%@/app/uas/open/personandusers/updatePassword",AppHost];
    
    NSURLSessionDataTask *task = [self postRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        if (completion) {
            BOOL success = false;
            if ([response[@"success"] boolValue]) {
                success = true;
            }
            completion(sessionDataTask,success,error);
        }
    }];
    return task;
}

@end
