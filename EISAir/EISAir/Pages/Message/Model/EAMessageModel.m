//
//  EAMessageModel.m
//  EISAir
//
//  Created by chunhui on 2017/8/31.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageModel.h"

@implementation  EAMessageDataListMessageFollowersModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  EAMessageModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  EAMessageDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  EAMessageDataListModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"id":@"mid"};
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:dict];
}

@end

