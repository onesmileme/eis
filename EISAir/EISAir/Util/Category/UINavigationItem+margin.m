//
//  UINavigationItem+margin.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "UINavigationItem+margin.h"

@implementation UINavigationItem (margin)

- (void)setMarginLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{    
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -16;//此处修改到边界的距离，请自行测试
    
    if (_leftBarButtonItem)
    {
        [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
    }
    else
    {
        [self setLeftBarButtonItems:@[negativeSeperator]];
    }
}

- (void)setMarginRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -12;//此处修改到边界的距离，请自行测试
    
    if (_rightBarButtonItem)
    {
        [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
    }
    else
    {
        [self setRightBarButtonItems:@[negativeSeperator]];
    }
    
}


@end
