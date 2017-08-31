//
//  TKRequestHandler+Login.m
//  EISAir
//
//  Created by chunhui on 2017/8/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Login.h"


@implementation TKRequestHandler (Login)

-(NSURLSessionDataTask *)loginWithUserName:(NSString *)username password:(NSString *)password completion:(void(^)(NSURLSessionDataTask *task , EAOauthModel *model , NSError * error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/uaa/oauth/token",[EANetworkManager loginAppHost]];
    NSDictionary *param = @{@"username":username,@"password":password,@"grant_type":@"password",@"prod":@"EIS"};
    [[EANetworkManager sharedInstance] setRequestSerializer:false];
    return [[TKRequestHandler sharedInstance]postRequestForPath:path param:param jsonName:@"EAOauthModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error is: \n%@\n\n",error);
        }
        if (completion) {
            [[EANetworkManager sharedInstance] setRequestSerializer:true];
            completion(sessionDataTask,(EAOauthModel *)model,error);
        }

    }];
}

-(NSURLSessionDataTask *)sendMessageCompletion:(void(^)(NSURLSessionDataTask *task , NSDictionary *model , NSError * error))completion
{
    //GET /uas/open/message/send
    NSString *path = [NSString stringWithFormat:@"%@/uas/open/message/send",AppHost];
    return [self getRequestForPath:path param:nil finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        
        if (response) {
            NSLog(@"response is: \n%@\n\n",response);
        }
        if (error) {
            NSLog(@"error is: \n%@\n\n",error);
        }
        
    }];
    
    
}

@end
