//
//  EASearchConditionSwitchControl.h
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EATabSwitchControl : UIControl

- (instancetype)initWithFrame:(CGRect)frame
                    itemArray:(NSArray *)itemArray
                    titleFont:(UIFont *)titleFont
                    lineWidth:(float)lineWidth
                    lineColor:(UIColor *)lineColor;
// 默认0
@property (nonatomic, assign) NSUInteger selectedIndex;

@end
