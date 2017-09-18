//
//  EALoginUserInfoModel.m
//  EISAir
//
//  Created by chunhui on 2017/8/30.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EALoginUserInfoModel.h"


@implementation  EALoginUserInfoDataOrgsProductsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"description":@"desc",@"id":@"pid"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}


@end


@implementation  EALoginUserInfoDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  EALoginUserInfoModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  EALoginUserInfoDataOrgsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"description":@"desc",@"id":@"oid"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}

@end


@implementation  EALoginUserInfoDataSitesModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"description":@"desc",@"id":@"sid"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}

@end


@implementation  EALoginUserInfoDataSitesProductsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"description":@"desc",@"id":@"pid"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}


@end

