//
//  EAChooseObjVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAChooseObjVC.h"
#import "EATabSwitchControl.h"
#import "EARecordObjVC.h"
#import "EAScanViewController.h"
#import "EAMessageFilterResultViewController.h"

@interface EAChooseObjVC () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UITextFieldDelegate> {
    UIPageViewController *_pageViewController;
    EATabSwitchControl *_tabSwtichControl;
    NSMutableArray *_viewControllers;
    NSInteger _currentIndex;
    UITextField *_searchBar;
    
    UIButton *_resetButton;
    UIButton *_confirmButton;
}

@end

@implementation EAChooseObjVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavbar];
    NSArray *items = @[@"空间", @"设备", @"点", ];
    _tabSwtichControl = [[EATabSwitchControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)
                                                        itemArray:items
                                                        titleFont:[UIFont systemFontOfSize:14]
                                                        lineWidth:SCREEN_WIDTH / 3
                                                        lineColor:HexColor(0x28cfc1)];
    [_tabSwtichControl addTarget:self action:@selector(tabSwitched) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_tabSwtichControl];
    
    float width = (SCREEN_WIDTH - 30 - 50) / 2;
    float top = SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 60;
    _resetButton = [self bottomButtonWithText:@"重置" frame:CGRectMake(25, top, width, 36) isLeft:YES];
    _confirmButton = [self bottomButtonWithText:@"确认" frame:CGRectMake(_resetButton.right + 30, top, width, 36) isLeft:NO];

    _viewControllers = [NSMutableArray array];
    for (int i = 0; i < items.count; ++i) {
        EARecordObjVC *vc = [[EARecordObjVC alloc] initWithType:i];
        [_viewControllers addObject:vc];
    }
    
    [self addPageViewController];
    _pageViewController.view.frame = CGRectMake(0, _tabSwtichControl.bottom, SCREEN_WIDTH, _confirmButton.top - 10 - _tabSwtichControl.height);
    
    [_pageViewController setViewControllers:@[_viewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pageViewController.view.frame = CGRectMake(0, _tabSwtichControl.bottom, SCREEN_WIDTH, _confirmButton.top - 10 - _tabSwtichControl.height);
}

- (UIButton *)bottomButtonWithText:(NSString *)text frame:(CGRect)frame isLeft:(BOOL)left {
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:(left ? HexColor(0x666666) : [UIColor whiteColor]) forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(bottomClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 2;
    button.clipsToBounds = YES;
    button.layer.borderWidth = LINE_HEIGHT;
    button.layer.borderColor = HexColor(0xb0b0b0).CGColor;
    button.backgroundColor = left ? [UIColor whiteColor] : HexColor(0x28cfc1);
    [self.view addSubview:button];
    return button;
}

- (void)initNavbar {
    _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 33)];
    _searchBar.borderStyle = UITextBorderStyleNone;
    _searchBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    _searchBar.layer.cornerRadius = 4;
    _searchBar.layer.masksToBounds = true;
    _searchBar.delegate = self;
    
    //left view
    //search
    UIImageView *searchView =  [[UIImageView alloc]initWithImage:SYS_IMG(@"seach_icon1")];
    searchView.contentMode = UIViewContentModeCenter;
    searchView.frame = CGRectMake(0, 0, 35, 33);
    _searchBar.leftView = searchView;
    
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.titleView = _searchBar;
    
    _searchBar.font = SYS_FONT(14);
    
    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"请输入名称描述" attributes:@{NSFontAttributeName:SYS_FONT(14),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _searchBar.attributedPlaceholder = placeholder;
    
    UIImage *img = SYS_IMG(@"scan") ;
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(scanAction:)];
    self.navigationItem.rightBarButtonItem = scanItem;
}


- (void)addPageViewController {
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
}

#pragma mark - Actions
- (void)tabSwitched {
    if (_tabSwtichControl.selectedIndex >= _viewControllers.count) {
        return;
    }
    UIViewController *vc = [_viewControllers objectAtIndex:_tabSwtichControl.selectedIndex];
    if (_tabSwtichControl.selectedIndex > _currentIndex) {
        [_pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    } else {
        [_pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
        }];
    }
    _currentIndex = _tabSwtichControl.selectedIndex;
}

- (void)scanAction:(id)sender {
    EAScanViewController *controller = [EAScanViewController scanController];
    __weak typeof(self) wself = self;
    controller.doneBlock = ^(NSString *urlcode) {
        //TODO dosearch
        [wself.navigationController popViewControllerAnimated:true];
    };
    [self.navigationController pushViewController:controller animated:true];
}

- (void)bottomClicked:(UIButton *)btn {
    if (btn == _resetButton) {
        EARecordObjVC *vc = _viewControllers[_currentIndex];
        [vc resetCondition];
    } else {
        // TODO
    }
}

#pragma mark - Page Delegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [_viewControllers indexOfObject:viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    return [_viewControllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [_viewControllers indexOfObject:viewController];
    if (index >= _viewControllers.count - 1) {
        return nil;
    }
    return [_viewControllers objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [_viewControllers indexOfObject:nextVC];
    _currentIndex = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        _tabSwtichControl.selectedIndex = _currentIndex ;
    }
}

@end
