//
//  TKRequestHandler+Message.h
//  EISAir
//
//  Created by chunhui on 2017/8/31.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAMessageModel.h"
#import "EAMsgFilterModel.h"
#import "EAMsgFilterTagModel.h"

@interface TKRequestHandler (Message)

-(NSURLSessionDataTask *)loadMyMessageFilterParam:(EAMsgFilterModel *)param completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion;

-(NSURLSessionDataTask *)loadMessageByPerson:(NSString *)personId filterParam:(EAMsgFilterModel *)param completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion;

-(NSURLSessionDataTask *)findMessageDataFilterParam:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion;

/*
 * 加载筛选数据
 */
-(NSURLSessionDataTask *)loadMsgFilterData:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , JSONModel *model , NSError *error))completion;

/*
 * 加载筛选项
 */
-(NSURLSessionDataTask *)loadMsgFilterTag:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMsgFilterTagModel *model , NSError *error))completion;

@end
