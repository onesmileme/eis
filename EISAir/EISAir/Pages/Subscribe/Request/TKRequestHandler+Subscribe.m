//
//  TKRequestHandler+Subscribe.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Subscribe.h"

@implementation TKRequestHandler (Subscribe)

- (NSURLSessionDataTask *)fetchAllSubscribesCompletion:(void(^)(NSURLSessionDataTask *task , EAAllSubscribeModel *model , NSError *error))completion {
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/subscribe/findAllEisSubscribe", AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    return [self postRequestForPath:path param:param jsonName:@"EAAllSubscribeModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask, model, error);
        }
    }];
}

@end
