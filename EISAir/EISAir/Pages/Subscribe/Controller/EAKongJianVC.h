//
//  EAKongJianVC.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

typedef enum : int {
    EAKongJianVCTypeKongJian,
    EAKongJianVCTypeSheBei,
} EAKongJianVCType;

@interface EAKongJianVC : EABaseViewController

@property (nonatomic, assign) EAKongJianVCType type;

@end
