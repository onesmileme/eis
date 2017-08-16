//
//  FABrowserTranistion.m
//  CaiLianShe
//
//  Created by chunhui on 2016/8/2.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import "FABrowserTranistion.h"

#define FAAnimatedTransitionDuration 0.3

@implementation FABrowserTranistion

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    BOOL doReverse = self.reverse || fromViewController == self.browserViewController;
    
    if (doReverse) {
        [container insertSubview:toViewController.view belowSubview:fromViewController.view];
    } else {
        CGRect frame = toViewController.view.frame;
        frame.origin.x = CGRectGetWidth(frame);
        toViewController.view.frame = frame;
        [container addSubview:toViewController.view];
    }
    
    NSTimeInterval duration = self.duration;
    if (duration < 0.01) {
        duration = FAAnimatedTransitionDuration;
    }
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
        if (doReverse) {
            CGRect frame = fromViewController.view.frame;
            frame.origin.x = CGRectGetWidth(frame);
            fromViewController.view.frame = frame;
        }else{
            CGRect frame = toViewController.view.frame;
            frame.origin.x = 0;
            toViewController.view.frame = frame;
//            frame.origin.x = -CGRectGetWidth(frame);
//            fromViewController.view.frame = frame;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSTimeInterval duration = self.duration;
    if (duration < 0.01) {
        duration = FAAnimatedTransitionDuration;
    }
    return duration;
}


@end
