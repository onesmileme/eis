//
//  EAOauthModel.m
//  EISAir
//
//  Created by chunhui on 2017/8/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAOauthModel.h"

@implementation  EAOauthModel

+ (JSONKeyMapper*)keyMapper
{
    NSDictionary *dict = @{
                           @"accessToken": @"access_token",
                           @"tokenType": @"token_type",
                           @"expiresIn": @"expires_in",
                           @"refreshToken": @"refresh_token",
                           @"errorDescription":@"error_description",
                           };
    return [[JSONKeyMapper alloc]initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return dict[keyName]?:keyName;
    }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
