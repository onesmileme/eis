//
//  EAUploadPicModel.m
//  FunApp
//
//  Created by chunhui on 16/6/28.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EAUploadPicModel.h"

@implementation EAUploadPicDataModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"errno":@"dErrno" }];
}

@end

@implementation EAUploadPicModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return true;
}

@end
