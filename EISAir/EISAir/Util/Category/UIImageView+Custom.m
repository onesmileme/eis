//
//  UIImageView+Custom.m
//  HunWaterPlatform
//
//  Created by DoubleHH on 15/11/9.
//  Copyright © 2015年 LJ. All rights reserved.
//

#import "UIImageView+Custom.h"

@implementation UIImageView (Custom)

+ (UIImageView *)roundPhotoWithFrame:(CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius = frame.size.width * .5;
    imageView.clipsToBounds = YES;
    return imageView;
}

+ (UIImageView *)photoWithFrame:(CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

+ (UIImageView *)photoWithFrame:(CGRect)frame radius:(float)radius {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    if (radius > 0) {
        imageView.layer.cornerRadius = radius;
    }
    imageView.clipsToBounds = YES;
    return imageView;
}

@end
