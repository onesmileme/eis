//
//  TKRequestHandler+RedDot.m
//  FunApp
//
//  Created by chunhui on 2016/10/26.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler+RedDot.h"
#import "EANetworkManager.h"

@implementation TKRequestHandler (RedDot)

-(NSURLSessionDataTask *)syncRedDotLastMomentTime:(NSTimeInterval)momentTime tweetTime:(NSTimeInterval)tweetTime completion:(void(^)(NSURLSessionDataTask *task , EARedDotModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/system_message/new_msg_num",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    param[@"last_moments_time"] = @(momentTime);
    param[@"last_tweet_time"] = @(tweetTime);
    
    return [self getRequestForPath:path param:param jsonName:@"EARedDotModel" finish:^(NSURLSessionDataTask *sessionDataTask, JSONModel *model, NSError *error) {
        
        
        
        if (completion) {
            completion(sessionDataTask,(EARedDotModel *)model,error);
        }
        
    }];
}

@end
