//
//  FAPayInfoModel.m
//  FunApp
//
//  Created by wangyan on 16/10/11.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "FAPayInfoModel.h"

//for implementation
@implementation  FAPayInfoDataContentModel

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"trade_type": @"tradeType",
                                                        @"prepay_id": @"prepayId",
                                                        @"nonce_str": @"nonceStr",
                                                        @"return_code": @"returnCode",
                                                        @"return_msg": @"returnMsg",
                                                        @"mch_id": @"mchId",
                                                        @"out_trade_no": @"outTradeNo",
                                                        @"result_code": @"resultCode",
                                                        }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  FAPayInfoDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation  FAPayInfoModel

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"errno": @"dErrno",
                                                        }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


