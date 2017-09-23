//
//  EATaskUpdateModel.m
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskUpdateModel.h"

@implementation EATaskUpdateModel


+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"tid":@"id",@"anewStatus":@"anewStatus"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}

@end
