//
//  EAMsgSearchTipModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol EAMsgSearchTipDataModel<NSObject>

@end


@interface  EAMsgSearchTipDataModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *objType;
@property (nonatomic, copy , nullable) NSString *objDesc;
@property (nonatomic, copy , nullable) NSString *objId;
@property (nonatomic, copy , nullable) NSString *objName;

@end


@interface  EAMsgSearchTipModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *errorCode;
@property (nonatomic, copy , nullable) NSString *msg;
@property (nonatomic, copy , nullable) NSString *detailMsg;
@property (nonatomic, strong , nullable) NSArray<EAMsgSearchTipDataModel> *data;
@property (nonatomic, assign) BOOL success;

@end
