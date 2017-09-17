//
//  TKRequestHandler+User.h
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAUserModel.h"

@interface TKRequestHandler (User)

/*
 * 获取@用户的列表
 */
-(NSURLSessionDataTask *)findUsersCompletion:(void(^)(NSURLSessionDataTask *task , EAUserModel *model , NSError *error))completion;

@end
