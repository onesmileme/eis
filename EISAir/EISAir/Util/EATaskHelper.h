//
//  EATaskHelper.h
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EATaskHelper : NSObject

DEF_SINGLETON;

-(NSString *)valueForStatus:(NSString *)key;

-(NSString *)valueForExecuteStatus:(NSString *)key;

@end
