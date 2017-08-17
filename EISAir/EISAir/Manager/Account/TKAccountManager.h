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
//@property(nonatomic , strong) TKWexinUserInfo *wxUserInfo;

+ (TKAccountManager *)sharedInstance;

- (BOOL)isLogin;

- (NSString *)uid;

- (NSString *)myName;

- (NSString *)avatar;

- (BOOL)needBind;
/*
 * 是否是默认用户 审核时用
 */
- (BOOL)isDefaultUser;

- (void)wxlogin:(void(^)(bool success))completion;

-(void)syncLogin;
-(void)syncLogin:(void(^)(BOOL success))done;

- (void)save;
- (void)logout;

/*
 * 拉取默认用户信息
 */
-(void)loadDefaultInfo;

@end
