//
//  EAUserInfoFilterModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface  EAUserInfoFilterModel  : JSONModel

@property (nonatomic, strong , nullable) NSArray *siteIds;
@property (nonatomic, copy , nullable) NSString *loginName;
@property (nonatomic, copy , nullable) NSString *name;
@property (nonatomic, strong , nullable) NSArray *orgIds;
@property (nonatomic, copy , nullable) NSString *userType;
@property (nonatomic, copy , nullable) NSString *mobile;
@property (nonatomic, copy , nullable) NSString *gender;
@property (nonatomic, copy , nullable) NSString *userId;
@property (nonatomic, copy , nullable) NSString *personId;
@property (nonatomic, strong , nullable) NSArray *roleIds;
@property (nonatomic, copy , nullable) NSString *createUser;
@property (nonatomic, copy , nullable) NSString *department;
@property (nonatomic, copy , nullable) NSString *position;
@property (nonatomic, strong , nullable) NSArray *productIds;
@property (nonatomic, copy , nullable) NSString *email;
@property (nonatomic, copy , nullable) NSString *workgroup;

@end
