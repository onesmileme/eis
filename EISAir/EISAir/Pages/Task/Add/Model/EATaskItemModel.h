//
//  EATaskItemModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>


typedef NS_ENUM(NSInteger,EATaskItemType) {
    EATaskItemTypeIndex = 0,
    EATaskItemTypeTableNum,
    EATaskItemTypeBeilv,
    EATaskItemTypeAmount,
    EATaskItemTypeLastAmount,
    EATaskItemTypeThisAmountDays,
    EATaskItemTypeLastAmountDays,
    EATaskItemTypeThisNum,
    EATaskItemTypeLastNum,
    EATaskItemTypeDate,
    EATaskItemTypeLastDate,
    EATaskItemTypeMonth
};

@protocol EATaskItemDataModel <NSObject>


@end

@interface EATaskItemDataModel : JSONModel

@property (nonatomic, copy , nullable) NSString *readCount;//本次读数
@property (nonatomic, copy , nullable) NSString *settlementMonth; //本次用量结算月份
@property (nonatomic, copy , nullable) NSString *lastConsumption;//上次用量
@property (nonatomic, copy , nullable) NSString *lastConsumptionDays;//上次用量日数
@property (nonatomic, copy , nullable) NSString *consumption;//用量
@property (nonatomic, copy , nullable) NSString *fillDate;//填报时间
@property (nonatomic, copy , nullable) NSString *timestamp;//時間毫秒
@property (nonatomic, copy , nullable) NSString *tagid; //序号
@property (nonatomic, copy , nullable) NSString *rate; //倍率
@property (nonatomic, copy , nullable) NSString *value;//上次读数
@property (nonatomic, copy , nullable) NSString *lastMeterDate;//上次抄表日期
@property (nonatomic, copy , nullable) NSString *objName;//对象名称
@property (nonatomic, copy , nullable) NSString *meterDate;//抄表日期
@property (nonatomic, copy , nullable) NSString *consumptionDays;//本次用量日数


@end

@interface  EATaskItemModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *errorCode;
@property (nonatomic, copy , nullable) NSString *msg;
@property (nonatomic, copy , nullable) NSString *detailMsg;
@property (nonatomic, strong , nullable) NSArray<EATaskItemDataModel> *data;
@property (nonatomic, assign) BOOL success;

@end
