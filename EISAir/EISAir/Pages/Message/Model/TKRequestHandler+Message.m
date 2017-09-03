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

-(NSURLSessionDataTask *)loadMyMessageFilterParam:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
    NSString *personId = [TKAccountManager sharedInstance].loginUserInfo.personId;
    if (personId.length == 0) {
        return nil;
    }
    return [self loadMessageByPerson:personId filterParam:fparam completion:completion];
}

-(NSURLSessionDataTask *)loadMessageByPerson:(NSString *)personId filterParam:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findEisMessageByPerson",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"personId"] = personId;
    if (fparam) {
        NSDictionary *dict = [fparam toDictionary];
        [param addEntriesFromDictionary:dict];
    }
        
    return [self postRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMessageModel *)model , error);
        }
    }];
}

-(NSURLSessionDataTask *)findMessageDataFilterParam:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findEisMessageData",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if (fparam) {
        NSString *filter = [fparam toJSONString];
        if (filter.length > 0) {
            param[@"filter"] = filter;
        }
    }
    
    return [self getRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMessageModel *)model , error);
        }
    }];
}

/*
 * 加载筛选数据
 */
-(NSURLSessionDataTask *)loadMsgFilterData:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , JSONModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findEisMessageData",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if (fparam) {
        NSString *filter = [fparam toJSONString];
        if (filter.length > 0) {
            param[@"filter"] = filter;
        }
    }
    
    return [self postRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMessageModel *)model , error);
        }
    }];
}


@end
