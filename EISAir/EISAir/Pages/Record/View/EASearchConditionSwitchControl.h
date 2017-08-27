//
//  EASearchConditionSwitchControl.h
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EASearchConditionSwitchControl : UIControl

- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)itemArray;
- (int)selectedIndex;

@end
