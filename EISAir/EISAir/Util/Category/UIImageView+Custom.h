//
//  UIImageView+Custom.h
//  HunWaterPlatform
//
//  Created by DoubleHH on 15/11/9.
//  Copyright © 2015年 LJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Custom)

+ (UIImageView *)roundPhotoWithFrame:(CGRect)frame;
+ (UIImageView *)photoWithFrame:(CGRect)frame;
+ (UIImageView *)photoWithFrame:(CGRect)frame radius:(float)radius;

@end
