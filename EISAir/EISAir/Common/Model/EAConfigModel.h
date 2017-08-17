//
//  EAConfigModel.h
//  FunApp
//
//  Created by chunhui on 2016/8/24.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "JSONModel.h"

@interface  EAConfigDataModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *openJubao;
@property (nonatomic, copy , nullable) NSString *openShield;
@property (nonatomic, copy , nullable) NSString *openRegister;
@property (nonatomic, copy , nullable) NSString *needLiveGift;
@property (nonatomic, copy , nullable) NSString *needGroup;
@property (nonatomic, copy , nullable) NSString *needLive;

@end


@interface  EAConfigModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *dErrno;
@property (nonatomic, strong , nullable) EAConfigDataModel *data ;
@property (nonatomic, copy , nullable) NSString *errmsg;

@end

