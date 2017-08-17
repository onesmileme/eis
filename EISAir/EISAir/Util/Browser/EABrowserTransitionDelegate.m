//
//  EABrowserTransitionDelegate.m
//  CaiLianShe
//
//  Created by chunhui on 2016/8/2.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import "EABrowserTransitionDelegate.h"
#import "EABrowserTranistion.h"


@implementation EABrowserTransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    EABrowserTranistion *transitioning = [EABrowserTranistion new];
    transitioning.duration = self.duration;
    if (source == self.browserController) {
        transitioning.reverse = true;
    }
    transitioning.browserViewController = self.browserController;
    
    return transitioning;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    EABrowserTranistion *transitioning = [EABrowserTranistion new];
    transitioning.duration = self.duration;
    if (dismissed == self.browserController) {
        transitioning.reverse = true;
    }
    transitioning.browserViewController = self.browserController;
    
    return transitioning;
}

@end
