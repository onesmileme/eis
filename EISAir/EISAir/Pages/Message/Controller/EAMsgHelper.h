//
//  EAMsgHelper.h
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAMsgHelper : NSObject

+(UIColor *)colorForMsgType:(NSString *)msgtype;

+(NSString *)detailTagForMsgType:(NSString *)msgType;

@end
