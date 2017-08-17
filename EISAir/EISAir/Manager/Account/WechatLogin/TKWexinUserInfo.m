//
//  TKWexinUserInfo.m
//  ToolKit
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKWexinUserInfo.h"

@implementation TKWexinUserInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"access_token" : @"accessToken" , @"refresh_token" : @"refreshToken" ,  @"expires_in" : @"expiresIn"}];
}


+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

