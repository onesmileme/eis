//
//  EABaseViewController+Stack.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

@implementation EABaseViewController (Stack)

+ (UINavigationController *)currentNavigationController {
    UINavigationController *navi = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    return [(UITabBarController *)navi.topViewController selectedViewController];
}

+ (UINavigationController *)rootNavigationController {
    return (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
}

@end
