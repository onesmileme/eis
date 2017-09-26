//
//  EARecordObjVC.h
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"
#import "EARecordDefines.h"

@class EARecordAttrDataModel;
@interface EARecordObjVC : EABaseViewController

- (instancetype)initWithType:(EARecordObjType)type;
@property (nonatomic, assign, readonly) EARecordObjType type;

- (void)resetCondition;
- (NSDictionary *)chooseConditions;

@end
