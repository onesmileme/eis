//
//  EAUserInfoModel.h
//  FunApp
//
//  Created by chunhui on 16/6/26.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "JSONModel.h"

#define kMale   1
#define kFemale   2

typedef NS_ENUM(NSInteger , EAUserVerifyStatus) {
    EAUserVerifyStatusUnVerify = 0,
    EAUserVerifyStatusWating = 1,
    EAUserVerifyStatusReject = 2,
    EAUserVerifyStatusVerified = 3,
};

@interface EAUserInfoModel : JSONModel

@property(nonatomic , copy) NSString *uid;
@property(nonatomic , copy) NSString *token;
@property(nonatomic , copy) NSString *nickname;
@property(nonatomic , copy) NSString *headimgurl;
@property(nonatomic , strong) NSNumber *role; //1 红V  2  蓝V
@property(nonatomic , strong) NSNumber *sex;
@property(nonatomic , copy) NSString *autograph;
@property(nonatomic , copy) NSString *city;
@property(nonatomic , copy) NSString *province;
@property(nonatomic , assign) NSTimeInterval birthday; //生日时间戳

@property(nonatomic , copy) NSString *company;
@property(nonatomic , copy) NSString *post;

@property(nonatomic , assign) NSInteger verifyStatus; //审核状态  0:未认证 1:待审核 2:审核拒绝 3:审核通过

@property(nonatomic , strong) NSNumber *followNum;
@property(nonatomic , strong) NSNumber *fansNum;
@property(nonatomic , strong) NSNumber *followType;
@property(nonatomic , copy)   NSString *shield;// -1 自己  1 已经屏蔽 0 未屏蔽

@end
