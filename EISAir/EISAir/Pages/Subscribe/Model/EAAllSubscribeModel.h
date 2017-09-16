//
//  EAAllSubscribeModel.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EAAllSubscribeDataModel : JSONModel
@property (nonatomic, strong) NSString *subscribePersonCount;
@property (nonatomic, strong) NSString *modularName;
@property (nonatomic, strong) NSString *subscribePersonNames;
@property (nonatomic, strong) NSString *isSubscribe;
@property (nonatomic, strong) NSString *subscribePersonId;
@property (nonatomic, strong) NSString *id;
@end


@protocol EAAllSubscribeDataModel
@end
@interface EAAllSubscribeModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) NSArray<EAAllSubscribeDataModel> *data;
@property (nonatomic, assign) BOOL success;
@end
