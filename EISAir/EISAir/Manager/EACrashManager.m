//
//  FACrashManager.m
//  FunApp
//
//  Created by chunhui on 16/6/7.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EACrashManager.h"
#import <Bugly/Bugly.h>//"Bugly.h"
//#import "FAConfigManager.h"

@interface EACrashManager()<BuglyDelegate>

@end

@implementation EACrashManager

IMP_SINGLETON

-(instancetype)init
{
    self = [super init];
    if (self) {
        
//        NSDictionary *buglyDict = [[FAConfigManager sharedInstance]buglyDict];
//        NSString *key = buglyDict[kBuglyKey];
        NSString *appId = @"";//buglyDict[kBuglyAppId];
        
        BuglyConfig *config = [[BuglyConfig alloc]init];
        config.delegate = self;
        
        config.channel = @"";//[[FAConfigManager sharedInstance]appKey];
        
#if DEBUG
        config.debugMode = true;
#endif
        [Bugly startWithAppId:appId config:config];
        
        
    }
    return self;
}

- (NSString * BLY_NULLABLE)attachmentForException:(NSException * BLY_NULLABLE)exception
{
    return @"";
    
//    return [[FAConfigManager sharedInstance]appKey];
}

@end


