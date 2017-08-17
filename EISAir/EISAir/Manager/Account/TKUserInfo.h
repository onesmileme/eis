//
//  TKUserInfo.h
//  ToolKit
//
//  Created by chunhui on 16/2/27.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKWexinUserInfo.h"

typedef NS_ENUM(NSInteger , TKUserInfoType) {
    TKUserInfoTypeWeixin = 0 ,
    TKUserInfoTypeQQ = 1,
    TKUserInfoTypeWeibo = 2,
};

/*
  follow_type: -1表示不用展示关注相关的按钮; 0显示+关注 按钮; 1显示 已关注 按钮; 2 显示 互相关注 按钮
 */

@interface TKUserInfo : TKWexinUserInfo

@property(nonatomic , strong) NSString *uid;   //系统分配用户uid
@property(nonatomic , strong) NSString *token;   //系统分配用户token
@property(nonatomic , strong) NSString *avatar; //自定义头像
@property(nonatomic , strong) NSString *userNickName; //自定义的昵称
@property(nonatomic , assign) TKUserInfoType type;
@property(nonatomic , strong) NSString *role;
@property (nonatomic, assign) BOOL needBind;

@property(nonatomic , strong) NSNumber *followNum;
@property(nonatomic , strong) NSNumber *fansNum;
@property(nonatomic , strong) NSNumber *followType;

@property(nonatomic , assign) BOOL isDefaultUser;//审核时使用

@end
