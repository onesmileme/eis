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
    NSString *path = [NSString stringWithFormat:@"%@/uaa/oauth/token",AppHost];
    NSDictionary *param = @{@"username":username,@"password":password,@"grant_type":@"password",@"prod":@"EIS"};
    return [[TKRequestHandler sharedInstance]postRequestForPath:path param:param jsonName:@"EAOauthModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error is: \n%@\n\n",error);
        }
        if (completion) {
            completion(sessionDataTask,(EAOauthModel *)model,error);
        }

    }];
}

@end
