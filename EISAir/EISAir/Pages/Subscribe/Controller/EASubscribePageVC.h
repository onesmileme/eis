//
//  EASubscribePageVC.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

typedef NS_ENUM(NSUInteger, EASubscribePageType) {
    EASubscribePageTypeMe,
    EASubscribePageTypeAll,
};

@interface EASubscribePageVC : EABaseViewController

- (instancetype)initWithType:(EASubscribePageType)type;
@property (nonatomic, assign, readonly) EASubscribePageType type;

@end
