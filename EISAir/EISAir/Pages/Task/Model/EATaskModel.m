//
//  EATaskModel.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskModel.h"

@implementation  EATaskDataListModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"id":@"tid"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}

@end


@implementation  EATaskModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  EATaskDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end



