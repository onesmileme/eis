//
//  TKRequestHandler+OAuth.h
//  EISAir
//
//  Created by chunhui on 2017/8/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAOauthModel.h"

@interface TKRequestHandler (Login)

-(NSURLSessionDataTask *)loginWithUserName:(NSString *)username password:(NSString *)password completion:(void(^)(NSURLSessionDataTask *task , EAOauthModel *model , NSError * error))completion;

-(NSURLSessionDataTask *)sendMessage:(NSString *)phone completion:(void(^)(NSURLSessionDataTask *task , NSDictionary *model , NSError * error))completion;

-(NSURLSessionDataTask *)findPassword:(NSString *)phone captcha:(NSString *)captcha password:(NSString *)password completion:(void (^)(NSURLSessionDataTask* task , NSDictionary *response , NSError *error))completion;

@end
