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
    [[EANetworkManager sharedInstance] setRequestSerializer:false resetAuthorization:true];
    return [[TKRequestHandler sharedInstance]postRequestForPath:path param:param jsonName:@"EAOauthModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error is: \n%@\n\n",error);
        }
        if (completion) {
            [[EANetworkManager sharedInstance] setRequestSerializer:true resetAuthorization:false];
            completion(sessionDataTask,(EAOauthModel *)model,error);
        }

    }];
}

-(NSURLSessionDataTask *)sendMessage:(NSString *)phone completion:(void(^)(NSURLSessionDataTask *task , NSDictionary *model , NSError * error))completion
{
    //GET /uas/open/message/send
    NSDictionary *param = @{@"mobile":phone?:@"",@"type":@"findPasswd"};
    NSString *path = [NSString stringWithFormat:@"%@/uas/open/message/send?mobile=%@&type=findPasswd",AppHost, phone?:@""];
//    NSString *path = [NSString stringWithFormat:@"%@/uas/open/message/send",AppHost];
    return [self postRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        
        if (response) {
            NSLog(@"response is: \n%@\n\n",response);
        }
        if (error) {
            NSLog(@"error is: \n%@\n\n",error);
            NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *info = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
            NSLog(@"info is: \n%@\n",info);
        }
        if (completion) {
            completion(sessionDataTask,response,error);
        }
    }];
    
    
}

-(NSURLSessionDataTask *)findPassword:(NSString *)phone captcha:(NSString *)captcha password:(NSString *)password completion:(void (^)(NSURLSessionDataTask* task , NSDictionary * response , NSError *error))completion
{
    /*
     http://218.247.171.92:8090/app/uas/open/ users/resetPasswdByMobile params:code=154090&passwd=123456&repeatPasswd=123456&mobile=15101076951
     */
    NSString *path = [NSString stringWithFormat:@"%@/uas/open/users/resetPasswdByMobile&code=%@&password=%@&repeatPasswd=%@&mobile=%@",AppHost,captcha,password,password,phone];
    NSDictionary *param = @{@"code":captcha?:@"",
                            @"password" :password?:@"",
                            @"repeatPasswd":password?:@"",
                            @"mobile":phone?:@""
                            };
    return [self postRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        
        if (response) {
            NSLog(@"response is: \n%@\n\n",response);
            
        }
        if (error) {
            NSLog(@"error is: \n%@\n\n",error);
            NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *info = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
            NSLog(@"info is: \n%@\n",info);
        }
       
        if (completion) {
            completion(sessionDataTask,response,error);
        }
    }];
}


-(NSURLSessionDataTask *)logoutCompletion:(void(^)(NSURLSessionDataTask *task , BOOL success , NSError * error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/uaa/leave",[EANetworkManager loginAppHost]];
    
    return [self postRequestForPath:path param:nil finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        
    }];
}

@end
