//
//  EANetworkmanager.h
//  FunApp
//
//  Created by chunhui on 16/6/1.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppHost  [EANetworkManager appHost]

@interface EANetworkManager : NSObject

DEF_SINGLETON;

/**
 *  应用主的host
 *
 *  @return
 */
+(NSString *)appHost;

/**
 *  设备cuid
 *
 *  @return
 */
-(NSString *)cuid;

@end
