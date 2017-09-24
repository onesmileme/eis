//
//  TKRequestHandler+User.h
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAUserModel.h"
#import "EALoginUserInfoModel.h"

@interface TKRequestHandler (User)

/*
 * 获取@用户的列表
 */
-(NSURLSessionDataTask *)findUsers:(NSInteger)pageNum completion:(void(^)(NSURLSessionDataTask *task , EAUserModel *model , NSError *error))completion;

/*
 * 获取登录用户信息
 */
-(NSURLSessionDataTask *)findLoginUserCompletion:(void(^)(NSURLSessionDataTask *task , EALoginUserInfoModel *model , NSError *error))completion;

-(NSURLSessionDataTask *)findCountByUserCompletion:(void(^)(NSURLSessionDataTask *task , NSInteger taskCount , NSInteger workRecordCount , NSInteger reportCount , NSError *error))completion;


@end
