//
//  EAKongJianPageVC.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

@class EASpaceModel;
@interface EAKongJianPageVC : EABaseViewController

@property (nonatomic, copy) NSString *buildId;
@property (nonatomic, copy) void (^requestSuccessBlock)(EASpaceModel *model);

@end
