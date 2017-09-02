//
//  TKRequestHandler+Message.h
//  EISAir
//
//  Created by chunhui on 2017/8/31.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAMessageModel.h"

@interface TKRequestHandler (Message)

-(NSURLSessionDataTask *)loadMyMessageFilterParam:(NSDictionary *)param completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion;

-(NSURLSessionDataTask *)loadMessageByPerson:(NSString *)personId filterParam:(NSDictionary *)param completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion;

-(NSURLSessionDataTask *)findMessageDataFilterParam:(NSDictionary *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion;

@end
