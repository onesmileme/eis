//
//  EAKongJianChartVC.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"
#import "EADingYueDefines.h"

@interface EAKongJianChartVC : EABaseViewController
@property (nonatomic, assign) EAKongJianVCType type;
@property (nonatomic, strong) NSString *spaceId;
@property (nonatomic, strong) NSString *deviceId;
@end
