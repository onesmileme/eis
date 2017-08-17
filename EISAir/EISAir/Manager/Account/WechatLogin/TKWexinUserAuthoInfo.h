//
//  TKWexinUserAuthoInfo.h
//  ToolKit
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "JSONModel.h"

@interface TKWexinUserAuthoInfo : JSONModel

@property(nonatomic , strong) NSString *accessToken;
@property(nonatomic , strong) NSString *openid;
@property(nonatomic , strong) NSNumber *expiresIn;
@property(nonatomic , strong) NSString *refreshToken;
@property(nonatomic , strong) NSString *scope;
@property(nonatomic , strong) NSString *unionid;
@property(nonatomic , strong) NSNumber *refreshTimestamp;

@end
