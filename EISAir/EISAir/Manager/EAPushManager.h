//
//  FAPushManager.h
//  FunApp
//
//  Created by chunhui on 2016/8/8.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAPushManager : NSObject

DEF_SINGLETON


/**
 *  设置推送配置
 *
 *  @param launchOptions 加载参数
 */
-(void)registerPushConfigWithLauchOptions:(NSDictionary *)launchOptions;

-(void)handlePush:(NSDictionary *)info;

-(void)handleOpenUrl:(NSString *)openUrl;

-(void)registerDeviceToken:(NSData *)deviceToken;

/**
 *  获得url请求的 query
 *
 *  @param url url字符串
 *
 */
+(NSMutableDictionary *)processQuery:(NSString *)url;

+(NSString *)scheme;

@end
