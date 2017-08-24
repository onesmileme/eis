//
//  EAVCView.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAVCView.h"

@implementation EAVCView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitTestView = [super hitTest:point withEvent:event];
    if (![hitTestView isKindOfClass:[UITextField class]] && ![hitTestView isKindOfClass:[UITextView class]]) {
        [self endEditing:YES];
    }
    return hitTestView;
}

@end
