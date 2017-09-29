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
#import "EALoginUserInfoModel.h"

#define MYUID  [[TKAccountManager sharedInstance] userId]

extern NSString *const kLogoutNotification;
extern NSString *const kLoginDoneNotification ;

@interface TKAccountManager : NSObject

@property(nonatomic , strong) TKUserInfo *userInfo;
@property(nonatomic , strong) EALoginUserInfoDataModel *loginUserInfo;

+ (TKAccountManager *)sharedInstance;

- (BOOL)isLogin;

- (NSString *)personId;

- (NSString *)userId;

- (NSString *)myName;

- (NSString *)avatar;

- (BOOL)needBind;

- (void)save;
- (void)logout;


@end
