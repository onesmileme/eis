//
//  FABrowserTransitionDelegate.m
//  CaiLianShe
//
//  Created by chunhui on 2016/8/2.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import "FABrowserTransitionDelegate.h"
#import "FABrowserTranistion.h"


@implementation FABrowserTransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    FABrowserTranistion *transitioning = [FABrowserTranistion new];
    transitioning.duration = self.duration;
    if (source == self.browserController) {
        transitioning.reverse = true;
    }
    transitioning.browserViewController = self.browserController;
    
    return transitioning;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    FABrowserTranistion *transitioning = [FABrowserTranistion new];
    transitioning.duration = self.duration;
    if (dismissed == self.browserController) {
        transitioning.reverse = true;
    }
    transitioning.browserViewController = self.browserController;
    
    return transitioning;
}

@end
