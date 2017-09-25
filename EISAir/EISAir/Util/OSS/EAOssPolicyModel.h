//
//  EAOssPlicyModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface  EAOssPolicyModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *accessid;
@property (nonatomic, copy , nullable) NSString *callback;
@property (nonatomic, copy , nullable) NSString *host;
@property (nonatomic, copy , nullable) NSString *expire;
@property (nonatomic, copy , nullable) NSString *signature;
@property (nonatomic, copy , nullable) NSString *policy;
@property (nonatomic, copy , nullable) NSString *dir;

@end

