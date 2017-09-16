//
//  TKRequestHandler+Subscribe.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAAllSubscribeModel.h"

@interface TKRequestHandler (Subscribe)

- (NSURLSessionDataTask *)fetchAllSubscribesCompletion:(void(^)(NSURLSessionDataTask *task , EAAllSubscribeModel *model , NSError *error))completion;

@end
