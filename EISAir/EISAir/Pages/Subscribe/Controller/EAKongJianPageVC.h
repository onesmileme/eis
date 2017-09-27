//
//  EAKongJianPageVC.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"
#import "EADingYueDefines.h"

@class EASpaceModel;
@interface EAKongJianPageVC : EABaseViewController

@property (nonatomic, assign) EAKongJianVCType type;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) void (^requestSuccessBlock)(EASpaceModel *model);

@end
