//
//  EAConfigModel.m
//  FunApp
//
//  Created by chunhui on 2016/8/24.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EAConfigModel.h"

@implementation  EAConfigModel

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"errno": @"dErrno",
                                                        }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  EAConfigDataModel

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"open_jubao": @"openJubao",
                                                        @"open_shield": @"openShield",
                                                        @"open_register": @"openRegister",
                                                        @"need_live_gift":@"needLiveGift",
                                                        @"need_group":@"needGroup",
                                                        @"need_live":@"needLive",
                                                        }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
