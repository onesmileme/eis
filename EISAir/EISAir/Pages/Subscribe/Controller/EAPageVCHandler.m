//
//  EAPageVCHandler.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAPageVCHandler.h"
#import <objc/runtime.h>

@interface UIViewController (EAIndex)
@property (nonatomic, assign) NSInteger ea_index;
@end

@implementation UIViewController (EAIndex)

- (NSInteger)ea_index {
    id obj = objc_getAssociatedObject(self, @selector(ea_index));
    if (obj) {
        return [obj integerValue];
    }
    return -1;
}

- (void)setEa_index:(NSInteger)ea_index {
    objc_setAssociatedObject(self, @selector(ea_index), @(ea_index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface EAPageVCHandler () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end


@implementation EAPageVCHandler {
    NSInteger _currentIndex;
    NSMapTable *_weakVCs;
    UIPageViewController *_pageVC;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentIndex = -1;
        _weakVCs = [NSMapTable strongToWeakObjectsMapTable];
        [self initPageVC];
    }
    return self;
}

- (UIViewController *)viewControllerWithIndex:(NSInteger)index {
    if (index < 0) {
        return nil;
    }
    UIViewController *vc = [_weakVCs objectForKey:@(index)];
    if (vc) {
        return vc;
    }
    if ([self.delegate respondsToSelector:@selector(pageHandler:viewControllerWithIndex:)]) {
        vc = [self.delegate pageHandler:self viewControllerWithIndex:index];
        vc.ea_index = index;
        [_weakVCs setObject:vc forKey:@(index)];
    }
    return vc;
}

- (void)initPageVC {
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
}

- (UIPageViewController *)pageVC {
    return _pageVC;
}

- (void)moveToIndex:(NSUInteger)index animated:(BOOL)animated {
    UIPageViewControllerNavigationDirection direction = _currentIndex < index ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [_pageVC setViewControllers:@[[self viewControllerWithIndex:index]] direction:(direction) animated:animated completion:nil];
}

#pragma mark - Page Delegate
// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *pageVC = [pendingViewControllers firstObject];
    _currentIndex = pageVC.ea_index;
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if ([self.delegate respondsToSelector:@selector(pageHandler:didMoveToIndex:)]) {
        [self.delegate pageHandler:self didMoveToIndex:_currentIndex];
    }
}

// In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
// Return 'nil' to indicate that no more progress can be made in the given direction.
// For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [self viewControllerWithIndex:_currentIndex - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [self viewControllerWithIndex:_currentIndex + 1];
}

@end

