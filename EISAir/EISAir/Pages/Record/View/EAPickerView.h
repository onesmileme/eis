//
//  EAPickerView.h
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAPickerView : UIView

@property (nonatomic, copy) void (^doneBlock)(id data);
- (instancetype)initWithDatas:(NSArray *)datas;
- (void)animateIsShow:(BOOL)show fromView:(UIView *)view;

@end
