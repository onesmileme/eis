//
//  TKUserInfo.h
//  ToolKit
//
//  Created by chunhui on 16/2/27.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "JSONModel.h"

/*
  follow_type: -1表示不用展示关注相关的按钮; 0显示+关注 按钮; 1显示 已关注 按钮; 2 显示 互相关注 按钮
 */

@interface TKUserInfo : JSONModel

@property(nonatomic , strong,nullable) NSString * username;
@property(nonatomic , strong,nullable) NSString *password;
@property(nonatomic , strong,nullable) NSString *uid;   //系统分配用户uid
//@property(nonatomic , strong) NSString *token;   //系统分配用户token
@property(nonatomic , strong,nullable) NSString *avatar; //自定义头像
//@property(nonatomic , strong) NSString *userNickName; //自定义的昵称
//@property(nonatomic , strong) NSString *role;
@property (nonatomic, assign) BOOL needBind;

@property (nonatomic, copy , nullable) NSString *accessToken;
@property (nonatomic, copy , nullable) NSString *tokenType;
@property (nonatomic, copy , nullable) NSString *expiresIn;
@property (nonatomic, copy , nullable) NSString *refreshToken;
@property (nonatomic, copy , nullable) NSString *scope;



@end
