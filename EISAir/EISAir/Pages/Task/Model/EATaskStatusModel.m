//
//  EATaskStatusModel.m
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskStatusModel.h"

@implementation  EATaskStatusDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"id":@"tid",@"newStatus":@"anewStatus"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}

@end


@implementation  EATaskStatusModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
