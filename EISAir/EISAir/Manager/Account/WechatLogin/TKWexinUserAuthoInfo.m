//
//  TKWexinUserAuthoInfo.m
//  ToolKit
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKWexinUserAuthoInfo.h"

@implementation TKWexinUserAuthoInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"access_token" : @"accessToken" , @"refresh_token":@"refreshToken" , @"expires_in":@"expiresIn"}];
}


+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
