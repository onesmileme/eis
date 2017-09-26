//
//  EAConditionSearchVC.h
//  EISAir
//
//  Created by iwm on 2017/9/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"
#import "EARecordDefines.h"

@class EAConditionSearchListModel;
@interface EAConditionSearchVC : EABaseViewController
- (instancetype)initWithType:(EARecordObjType)type conditions:(NSDictionary *)conditions;
@property (nonatomic, copy) void (^doneBlock)(EAConditionSearchListModel *model);
@end
