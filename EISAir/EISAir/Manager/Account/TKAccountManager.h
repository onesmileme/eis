//
//  MYAccountManager.h
//  ToolKit
//
//  Created by chunhui on 15/4/25.
//  Copyright (c) 2015年 chunhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKUserInfo.h"
#import "TKUserInfo+QQ.h"

#define MYUID  [[TKAccountManager sharedInstance] uid]

extern NSString *const kLogoutNotification;
extern NSString *const kLoginDoneNotification ;

@interface TKAccountManager : NSObject

@property(nonatomic , strong) TKUserInfo *userInfo;

+ (TKAccountManager *)sharedInstance;

- (BOOL)isLogin;

- (NSString *)uid;

- (NSString *)myName;

- (NSString *)avatar;

- (BOOL)needBind;

- (void)save;
- (void)logout;


@end
