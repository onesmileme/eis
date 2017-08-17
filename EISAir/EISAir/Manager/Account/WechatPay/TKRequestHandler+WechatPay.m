//
//  TKRequestHandler+WechatPay.m
//  FunApp
//
//  Created by wangyan on 16/10/11.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler+WechatPay.h"
#import "EANetworkManager.h"
#import "TKAccountManager.h"

@implementation TKRequestHandler (WechatPay)
- (NSURLSessionDataTask *)payInfoWithamount:(CGFloat)amount
                                complete:(void(^)(FAPayInfoModel *model , NSError *error))complete
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSString *path = [NSString stringWithFormat:@"%@/pay/unifiedorder",AppHost];
    param[@"amount"] = [NSString stringWithFormat:@"%.0f", amount];
    param[@"uid"] = MYUID;
    return [self postRequestForPath:path param:param jsonName:@"FAPayInfoModel" finish:^(NSURLSessionDataTask *sessionDataTask,JSONModel *model, NSError *error) {
        if (complete) {
            complete((FAPayInfoModel *)model,error);
        }
    }];
}

@end
