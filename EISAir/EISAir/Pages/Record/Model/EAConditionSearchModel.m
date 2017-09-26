//
//  EAConditionSearchModel.m
//  EISAir
//
//  Created by iwm on 2017/9/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAConditionSearchModel.h"

@implementation EAConditionSearchListModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"description": @"desc", }];
}
@end


@implementation EAConditionSearchDataModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


@implementation EAConditionSearchModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
