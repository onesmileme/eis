//
//  EAAddRecordVC.h
//  EISAir
//
//  Created by DoubleHH on 2017/8/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

typedef enum : NSUInteger {
    EAAddRecordTypeText,
    EAAddRecordTypeNumber,
    EAAddRecordTypeRelation,
} EAAddRecordType;

@interface EAAddRecordVC : EABaseViewController

- (instancetype)initWithType:(EAAddRecordType)type;

@end
