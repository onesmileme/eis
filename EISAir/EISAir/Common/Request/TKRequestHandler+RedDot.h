//
//  TKRequestHandler+RedDot.h
//  FunApp
//
//  Created by chunhui on 2016/10/26.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EARedDotModel.h"
@interface TKRequestHandler (RedDot)

-(NSURLSessionDataTask *)syncRedDotLastMomentTime:(NSTimeInterval)momentTime tweetTime:(NSTimeInterval)tweetTime completion:(void(^)(NSURLSessionDataTask *task , EARedDotModel *model , NSError *error))completion;

@end
