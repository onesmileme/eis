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
    NSDictionary *dict = @{@"desc":@"description",@"pid":@"id"};
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
    NSDictionary *dict = @{@"desc":@"description",@"oid":@"id"};
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
    NSDictionary *dict = @{@"desc":@"description",@"sid":@"id"};
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
    NSDictionary *dict = @{@"desc":@"description",@"pid":@"id"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}


@end

