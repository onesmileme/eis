//
//  EAChooseObjVC.h
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

@class EAMsgSearchTipDataModel;
@interface EAChooseObjVC : EABaseViewController

@property (nonatomic, copy) void (^doneBlock)(EAMsgSearchTipDataModel *model);

@end
