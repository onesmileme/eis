//
//  EASubscribeViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASubscribeViewController.h"
#import "EATabSwitchControl.h"
#import "EASubscribeCell.h"
#import "EADingYueRenVC.h"
#import "EADingYueEnergyMainVC.h"
#import "EAKongJianVC.h"
#import "EAAllSubscribeModel.h"
#import "EASubscribePageVC.h"

@interface EASubscribeViewController () <UITableViewDelegate, UITableViewDataSource, UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    EATabSwitchControl *_tabSwitchControl;
    UIPageViewController *_pageVC;
    NSInteger _currentPage;
    NSMutableDictionary *_pages;
}

@end

@implementation EASubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订阅";
    self.tabBarItem.title = @"";
    self.view.backgroundColor = [UIColor themeGrayColor];
    [self initNavbar];
    
    _pages = [NSMutableDictionary dictionary];
    
    // tab
    _tabSwitchControl = [[EATabSwitchControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)
                                                        itemArray:@[@"我的", @"全部"]
                                                        titleFont:[UIFont systemFontOfSize:15]
                                                        lineWidth:FlexibleWithTo6(115)
                                                        lineColor:HexColor(0x058497)];
    [_tabSwitchControl addTarget:self action:@selector(tabSwitched:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_tabSwitchControl];
    
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    [_pageVC setViewControllers:@[[self vcWithIndex:EASubscribePageTypeMe]] direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pageVC.view.frame = CGRectMake(0, _tabSwitchControl.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - _tabSwitchControl.height);
}

- (EASubscribePageVC *)vcWithIndex:(EASubscribePageType)index {
    EASubscribePageVC *vc = _pages[@(index)];
    if (!vc) {
        vc = [[EASubscribePageVC alloc] initWithType:index];
        _pages[@(index)] = vc;
    }
    return vc;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initNavbar {
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(0, 0, 40, 40);
    [menuButton setImage:SYS_IMG(@"common_menu") forState:UIControlStateNormal];
    [menuButton sizeToFit];
    [menuButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItems = @[menuItem];
}

#pragma mark - Actions
- (void)menuAction {
    [[EAPushManager sharedInstance] handleOpenUrl:@"eis://show_home"];
}

- (void)tabSwitched:(EATabSwitchControl *)control {
    if (_tabSwitchControl.selectedIndex > 1) {
        return;
    }
    EASubscribePageVC *vc = [self vcWithIndex:_tabSwitchControl.selectedIndex];
    UIPageViewControllerNavigationDirection direction = _tabSwitchControl.selectedIndex < _currentPage ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
    [_pageVC setViewControllers:@[vc] direction:(direction) animated:YES completion:nil];
    _currentPage = _tabSwitchControl.selectedIndex;
}

#pragma mark - Page Delegate
// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    EASubscribePageVC *pageVC = (EASubscribePageVC *)[pendingViewControllers firstObject];
    if (pageVC.type == EASubscribePageTypeMe) {
        _currentPage = 0;
    } else {
        _currentPage = 1;
    }
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        _tabSwitchControl.selectedIndex = _currentPage;
    }
}

// In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
// Return 'nil' to indicate that no more progress can be made in the given direction.
// For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (_currentPage <= 0) {
        return nil;
    }
    return [self vcWithIndex:EASubscribePageTypeMe];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (_currentPage >= 1) {
        return nil;
    }
    return [self vcWithIndex:EASubscribePageTypeAll];
}

@end
