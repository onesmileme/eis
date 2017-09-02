//
//  TKRequestHandler+Message.m
//  EISAir
//
//  Created by chunhui on 2017/8/31.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Message.h"
#import "TKAccountManager.h"
@implementation TKRequestHandler (Message)

-(NSURLSessionDataTask *)loadMyMessageFilterParam:(NSDictionary *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
    NSString *personId = [TKAccountManager sharedInstance].loginUserInfo.personId;
    if (personId.length == 0) {
        return nil;
    }
    
    return [self loadMessageByPerson:personId filterParam:fparam completion:completion];
}

-(NSURLSessionDataTask *)loadMessageByPerson:(NSString *)personId filterParam:(NSDictionary *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findEisMessageByPerson",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:fparam];
    param[@"personId"] = personId;
    
    return [self postRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMessageModel *)model , error);
        }
    }];
}

-(NSURLSessionDataTask *)findMessageDataFilterParam:(NSDictionary *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findEisMessageData",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:fparam];
    
    return [self getRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMessageModel *)model , error);
        }
    }];
}

@end
