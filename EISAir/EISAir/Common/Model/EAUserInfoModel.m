//
//  EAUserInfoModel.m
//  FunApp
//
//  Created by chunhui on 16/6/26.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EAUserInfoModel.h"

@implementation EAUserInfoModel

//+ (JSONKeyMapper*)keyMapper
//{
//    NSDictionary *dict = @{
//                           @"followNum" : @"follow_num",
//                           @"fansNum" : @"fans_num",
//                           @"followType" : @"follow_type",
//                           @"verifyStatus":@"verify_status"};
//    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:dict];
//}

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return true;
}
@end
