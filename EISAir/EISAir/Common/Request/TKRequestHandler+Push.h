//
//  TKRequestHandler+Push.h
//  CaiLianShe
//
//  Created by chunhui on 16/3/12.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import "TKRequestHandler.h"

@interface TKRequestHandler (Push)

/**
 *  绑定或者取消绑定
 *
 *  @param isBind     yes 绑定 no 取消绑定
 *  @param registerId   设备id
 *  @param uid        用户uid
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *)bindPush:(BOOL)isBind uid:(NSString *)uid registerId:(NSString *)registerId completion:(void (^)(NSURLSessionDataTask *task , NSDictionary* data ))completion;

/**
 *  推送反馈
 *
 *  @param msgId       push id
 *  @param deviceToken 设备token
 *  @param completion
 *
 *  @return
 */
-(NSURLSessionDataTask *)pushFeedbackMsgId:(NSString *)msgId timestamp:(NSTimeInterval)timestamp deviceToken:(NSString *)deviceToken completion:(void (^)(NSURLSessionDataTask *task , NSDictionary* data ))completion;

@end
