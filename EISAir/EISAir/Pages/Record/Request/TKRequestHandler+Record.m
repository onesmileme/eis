//
//  TKRequestHandler+Record.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/1.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Record.h"

@implementation TKRequestHandler (Record)

- (NSURLSessionDataTask *)loadRecord:(int)page completion:(void (^)(NSURLSessionDataTask *task , NSDictionary *model , NSError *error))completion {
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/object/findAssets",AppHost];
#else
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/object/findAssets",AppHost];    
#endif
    NSDictionary *param = @{
                            @"page": @(page).description,
                            };
    return [self getRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            
        }
    }];
}

@end
