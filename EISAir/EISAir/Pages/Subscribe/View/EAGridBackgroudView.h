//
//  EAGridBackgroudView.h
//  EISAir
//
//  Created by iwm on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAGridBackgroudView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    lineColor:(UIColor *)lineColor
                          row:(int)row
                       column:(int)column;

@end
