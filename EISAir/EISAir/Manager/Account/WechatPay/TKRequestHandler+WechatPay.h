//
//  TKRequestHandler+WechatPay.h
//  FunApp
//
//  Created by wangyan on 16/10/11.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler.h"
#import "FAPayInfoModel.h"

@interface TKRequestHandler (WechatPay)
- (NSURLSessionDataTask *)payInfoWithamount:(CGFloat)amount
                                complete:(void(^)(FAPayInfoModel *model , NSError *error))complete;
@end
