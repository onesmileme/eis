//
//  TKRequestHandler+Record.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/1.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"

@interface TKRequestHandler (Record)

- (NSURLSessionDataTask *)loadRecord:(int)page completion:(void (^)(NSURLSessionDataTask *task , NSDictionary *model , NSError *error))completion;

@end
