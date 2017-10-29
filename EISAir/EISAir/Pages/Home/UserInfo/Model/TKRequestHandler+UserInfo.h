//
//  TKRequestHandler+UserInfo.h
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAUserInfoFilterModel.h"
#import "EALoginUserInfoModel.h"

@interface TKRequestHandler (UserInfo)

/*
 * 更新用户信息
 */
-(NSURLSessionDataTask *)updateUserInfo:(EAUserInfoFilterModel *)model completion:(void (^)(NSURLSessionDataTask *task , NSDictionary *model , NSError *error))completion;

/*
 * 更改密码
 */
-(NSURLSessionDataTask *)modifyPassword:(NSString *)newPwd oldPassword:(NSString *)oldPwd completion:(void (^)(NSURLSessionDataTask *task , BOOL success , NSError *error))completion;

@end
