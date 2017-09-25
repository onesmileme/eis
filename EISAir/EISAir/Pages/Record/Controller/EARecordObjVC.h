//
//  EARecordObjVC.h
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

typedef NS_ENUM(NSUInteger, EARecordObjType) {
    EARecordObjTypeKongJian,
    EARecordObjTypeSheBei,
    EARecordObjTypeDian,
};

@class EARecordAttrDataModel;
@interface EARecordObjVC : EABaseViewController

- (instancetype)initWithType:(EARecordObjType)type;
@property (nonatomic, assign, readonly) EARecordObjType type;

- (void)resetCondition;
- (NSDictionary *)chooseConditions;

@end
