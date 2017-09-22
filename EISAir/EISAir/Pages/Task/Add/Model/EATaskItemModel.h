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

@interface EATaskItemModel : JSONModel

@property(nonatomic , copy) NSString *index;//序号
@property(nonatomic , copy) NSString *tableNum;//标号
@property(nonatomic , copy) NSString *beilv; //倍率
@property(nonatomic , copy) NSString *amount; //用量
@property(nonatomic , copy) NSString *lastAmount;//上次用量
@property(nonatomic , copy) NSString *thisAmountDays;//本次用量日数
@property(nonatomic , copy) NSString *lastAmountDays;//上次用量日数
@property(nonatomic , copy) NSString *thisNum;//本次读数
@property(nonatomic , copy) NSString *lastNum;//上次读数
@property(nonatomic , copy) NSString *date;//抄表日期
@property(nonatomic , copy) NSString *lastDate;//上次抄表日期
@property(nonatomic , copy) NSString *month;//本次用量结算月份
@end
