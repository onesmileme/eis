//
//  TKRequestHandler+Simple.h
//  EISAir
//
//  Created by iwm on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAPostBasicModel.h"

FOUNDATION_EXPORT const int kEISRequestPageSize;

@interface TKRequestHandler (Simple)

+ (NSURLSessionDataTask *)postWithPath:(NSString *)path
                                params:(NSDictionary *)params
                        jsonModelClass:(Class)jsonModelClass
                            completion:(void(^)(id model , NSError *error))completion;

+ (NSURLSessionDataTask *)getWithPath:(NSString *)path
                               params:(NSDictionary *)params
                       jsonModelClass:(Class)jsonModelClass
                           completion:(void(^)(id model , NSError *error))completion;

@end
