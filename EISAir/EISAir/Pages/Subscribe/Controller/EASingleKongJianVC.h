//
//  EASingleKongJianVC.h
//  EISAir
//
//  Created by iwm on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"
#import "EADingYueDefines.h"

@class EASpaceRoomlistModel;
@interface EASingleKongJianVC : EABaseViewController

@property (nonatomic, assign) EAKongJianVCType type;
@property (nonatomic, strong) EASpaceRoomlistModel *rModel;

@end
