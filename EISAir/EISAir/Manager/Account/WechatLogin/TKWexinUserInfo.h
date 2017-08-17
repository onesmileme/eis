//
//  TKWexinUserInfo.h
//  ToolKit
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONMOdel.h"

@interface TKWexinUserInfo : JSONModel

@property(nonatomic , strong) NSString *accessToken;
@property(nonatomic , strong) NSString *openid;
@property(nonatomic , strong) NSString *expiresIn;
@property(nonatomic , strong) NSString *refreshToken;

@property(nonatomic , strong) NSString *nickname;
@property(nonatomic , strong) NSString *province;
@property(nonatomic , strong) NSNumber *sex;
@property(nonatomic , strong) NSString *language;
@property(nonatomic , strong) NSString *city;
@property(nonatomic , strong) NSString *country;
@property(nonatomic , strong) NSString *headimgurl;
@property(nonatomic , strong) NSArray  *privilege;
@property(nonatomic , strong) NSString *unionid;

@property(nonatomic , strong) NSString *birthday;
@property(nonatomic , strong) NSString *autograph;

@end
