//
//  FASystemMsgModel.m
//  FunApp
//
//  Created by chunhui on 2016/8/10.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EARedDotModel.h"

@implementation  EARedDotModel

+ (JSONKeyMapper*)keyMapper
{
    /*
     NSDictionary *dict = @{
     @"followNum" : @"follow_num",
     @"fansNum" : @"fans_num",
     @"followType" : @"follow_type",
     @"verifyStatus":@"verify_status"};
     */
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"dErrno":@"errno"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  EARedDotDataModel

+ (JSONKeyMapper*)keyMapper
{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"sys_num": @"sysNum",
                                                        @"new_fans_num": @"fansNum",
                                                        @"mine_num":@"mineNum",
                                                        @"moments_num":@"momentsNum",
                                                        @"tweet_num":@"tweetNum",
                                                        }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


