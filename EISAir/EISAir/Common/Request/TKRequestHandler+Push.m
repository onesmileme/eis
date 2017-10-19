//
//  TKRequestHandler+Push.m
//  CaiLianShe
//
//  Created by chunhui on 16/3/12.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import "TKRequestHandler+Push.h"
#import "EANetworkManager.h"

@implementation TKRequestHandler (Push)

-(NSURLSessionDataTask *)bindPush:(BOOL)isBind uid:(NSString *)uid registerId:(NSString *)registerId completion:(void (^)(NSURLSessionDataTask *task , NSDictionary* data ))completion
{
    NSAssert(registerId.length > 0 , @"bind push device id and uid must valid");
    
    /*
     {
     "addTag": "string",
     "registrationId": "string",
     "removeTag": "string"
     }
     */
    
    NSDictionary *param = @{@"registrationId":registerId,@"uid":uid.length >0 ? uid: @""};//@"device_type":@"2"
    NSMutableDictionary *mparam = [[NSMutableDictionary alloc]init];
    mparam[@"registrationId"] = registerId;
    if (isBind) {
        mparam[@"addTag"] = uid;
    }else{
        mparam[@"removeTag"] = uid;
    }    
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/push/addAndRemovePersonTag",AppHost];

    
    return [self postRequestForPath:path param:param finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
        if (error) {
            NSLog(@"error is: %@",error);
            NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *info = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
            NSLog(@"info is: \n%@\n",info);
        }
        if (response) {
            NSLog(@"response is: %@",response);
        }
        completion(sessionDataTask,response);
    }];
    
}

-(NSURLSessionDataTask *)pushFeedbackMsgId:(NSString *)msgId timestamp:(NSTimeInterval)timestamp deviceToken:(NSString *)deviceToken completion:(void (^)(NSURLSessionDataTask *task , NSDictionary* data ))completion
{
    if (msgId.length == 0 || deviceToken.length == 0) {
        
        NSLog(@" msg id is nil or device token is: nil");
        return nil;
    }
    
    NSDictionary *param = @{@"device_token":deviceToken,@"msg_id":msgId , @"timestamp":[NSString stringWithFormat:@"%.0f",timestamp]};
    NSMutableDictionary *mparam = [[NSMutableDictionary alloc]init];
    [mparam addEntriesFromDictionary:param];
    
    NSString *path = [NSString stringWithFormat:@"%@/v1/push/statistics",AppHost];
    
    return [self postRequestForPath:path param:param finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
        //        NSLog(@"push feed back response is: %@ \n error is: %@\n\n\n",response,error);
        completion(sessionDataTask,response);
    }];
    
}

@end
