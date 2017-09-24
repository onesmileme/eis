//
//  TKRequestHandler+Simple.m
//  EISAir
//
//  Created by iwm on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#define URLWithPath(path) [NSString stringWithFormat:@"%@%@", AppHost, path]

const int kEISRequestPageSize = 20;

#import "TKRequestHandler+Simple.h"
#import "TKAccountManager.h"

@implementation TKRequestHandler (Simple)

+ (NSDictionary *)commonParams {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
    param[@"siteId"] = dinfo.siteId;
    param[@"orgId"] = dinfo.orgId;
    return param;
}

+ (NSDictionary *)allParamsWithParams:(NSDictionary *)params {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[self commonParams]];
    [allParams addEntriesFromDictionary:params];
    return allParams;
}

+ (NSURLSessionDataTask *)postWithPath:(NSString *)path
                                params:(NSDictionary *)params
                        jsonModelClass:(Class)jsonModelClass
                            completion:(void(^)(id model , NSError *error))completion {
    NSDictionary *allParams = [self allParamsWithParams:params];
    return [[TKRequestHandler sharedInstance] postRequestForPath:URLWithPath(path) param:allParams jsonName:NSStringFromClass(jsonModelClass) finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(model, error);
        }
    }];
}

+ (NSURLSessionDataTask *)getWithPath:(NSString *)path
                               params:(NSDictionary *)params
                       jsonModelClass:(Class)jsonModelClass
                           completion:(void(^)(id model , NSError *error))completion {
    NSDictionary *allParams = [self allParamsWithParams:params];
    return [[TKRequestHandler sharedInstance] getRequestForPath:URLWithPath(path) param:allParams jsonName:NSStringFromClass(jsonModelClass) finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(model, error);
        }
    }];
}

@end
