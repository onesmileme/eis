//
//  TKRequestHandler+Config.m
//  EISAir
//
//  Created by chunhui on 2017/8/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Config.h"

@implementation TKRequestHandler (Config)

-(NSURLSessionDataTask *)loadHomeConfCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion
{
    return [self loadPath:@"/eis/open/constants/findHomeConfTypeList" completion:completion];
    
}

-(NSURLSessionDataTask *)loadDateConfCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion
{
    return [self loadPath:@"/eis/open/constants/findDateTypeList" completion:completion];
    
}

-(NSURLSessionDataTask *)loadMsgAbleListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion
{
    return [self loadPath:@"/eis/open/constants/findMessageAbleList" completion:completion];
}


-(NSURLSessionDataTask *)loadMsgTypeListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion
{

    return [self loadPath:@"/eis/open/constants/findMsgTypeList" completion:completion];
}


-(NSURLSessionDataTask *)loadReminderTimeListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion
{
    return [self loadPath:@"/eis/open/constants/findReminderTimeList" completion:completion];
    
}

-(NSURLSessionDataTask *)loadTaskStatusListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion
{
    return [self loadPath:@"/eis/open/constants/findTaskStatusList" completion:completion];
    
}

-(NSURLSessionDataTask *)loadTaskTypeListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion
{
    return [self loadPath:@"/eis/open/constants/findTaskTypeList" completion:completion];
    
}

-(NSURLSessionDataTask *)loadPath:(NSString *)path completion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@%@",AppHost,path];
    
    return [self getRequestForPath:url param:nil finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = nil;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dict = response[@"data"];
        }
        if (completion) {
            completion(sessionDataTask,dict,error);
        }
    }];
}

@end
