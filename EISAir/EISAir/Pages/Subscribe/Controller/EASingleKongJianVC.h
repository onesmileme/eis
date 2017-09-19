//
//  EASingleKongJianVC.h
//  EISAir
//
//  Created by iwm on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

typedef NS_ENUM(NSUInteger, EASingleKongJianVCType) {
    EASingleKongJianVCTypeKongJian,
    EASingleKongJianVCTypeSheBei,
};

@interface EASingleKongJianVC : EABaseViewController

@property (nonatomic, assign) EASingleKongJianVCType type;

@end
