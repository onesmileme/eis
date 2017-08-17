//
//  FAPayInfoModel.h
//  FunApp
//
//  Created by wangyan on 16/10/11.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface  FAPayInfoDataContentModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *tradeType;
@property (nonatomic, copy , nullable) NSString *package;
@property (nonatomic, copy , nullable) NSString *prepayId;
@property (nonatomic, copy , nullable) NSString *timeStamp;
@property (nonatomic, copy , nullable) NSString *nonceStr;
@property (nonatomic, copy , nullable) NSString *returnCode;
@property (nonatomic, copy , nullable) NSString *returnMsg;
@property (nonatomic, copy , nullable) NSString *sign;
@property (nonatomic, copy , nullable) NSString *mchId;
@property (nonatomic, copy , nullable) NSString *outTradeNo;
@property (nonatomic, copy , nullable) NSString *key;
@property (nonatomic, copy , nullable) NSString *appid;
@property (nonatomic, copy , nullable) NSString *resultCode;

@end


@interface  FAPayInfoDataModel  : JSONModel

@property (nonatomic, strong , nullable) FAPayInfoDataContentModel *content ;

@end


@interface  FAPayInfoModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *dErrno;
@property (nonatomic, strong , nullable) FAPayInfoDataModel *data ;
@property (nonatomic, copy , nullable) NSString *errmsg;

@end
