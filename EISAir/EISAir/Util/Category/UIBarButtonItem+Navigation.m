//
//  UIBarButtonItem+Navigation.m
//  CaiLianShe
//
//  Created by chunhui on 15/12/9.
//  Copyright © 2015年 chenny. All rights reserved.
//

#import "UIBarButtonItem+Navigation.h"

@implementation UIBarButtonItem (Navigation)

+(UIBarButtonItem *)defaultLeftItemWithTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"navi_back"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return item;
}

+(UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action Image:(UIImage*)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return item;
}

@end
