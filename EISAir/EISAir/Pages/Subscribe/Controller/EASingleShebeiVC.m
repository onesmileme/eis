//
//  EASingleShebeiVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/10/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASingleShebeiVC.h"
#import "EASheBeiHeader.h"
#import "EATabSwitchControl.h"
#import "EAPageVCHandler.h"
#import "EAFilterView.h"
#import "EAKongJianChartVC.h"
#import "EAKongJianEventVC.h"

@interface EASingleShebeiVC () <EAPageVCHandlerDelegate> {
    EASheBeiHeader *_header;
    EATabSwitchControl *_tabSwitchControl;
    EAPageVCHandler *_pageHandler;
}

@end

@implementation EASingleShebeiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavbar];
    NSArray *data = @[
                      @"100",
                      @"10",
                      @"1000",
                      ];
    _header = [[EASheBeiHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [_header updateModel:data];
    [self.view addSubview:_header];
    
    // tab
    _tabSwitchControl = [[EATabSwitchControl alloc] initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, 40)
                                                        itemArray:@[@"视图", @"事件"]
                                                        titleFont:[UIFont systemFontOfSize:15]
                                                        lineWidth:FlexibleWithTo6(115)
                                                        lineColor:HexColor((0x28cfc1))];
    [_tabSwitchControl addTarget:self action:@selector(tabSwitched:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_tabSwitchControl];
    
    _pageHandler = [[EAPageVCHandler alloc] init];
    _pageHandler.delegate = self;
    [self addChildViewController:_pageHandler.pageVC];
    [self.view addSubview:_pageHandler.pageVC.view];
    [_pageHandler moveToIndex:0 animated:NO];
}

- (void)initNavbar {
    // 设置右边的搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 40, 40);
    UIImage *img = [UIImage imageNamed:@"common_filter"];
    [searchButton setImage:img forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(filterAction) forControlEvents:UIControlEventTouchUpInside];
    [searchButton sizeToFit];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pageHandler.pageVC.view.frame = CGRectMake(0, _tabSwitchControl.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _tabSwitchControl.height - NAVIGATION_BAR_HEIGHT - _header.bottom);
}

- (void)filterAction {
    EAFilterView *v = [[EAFilterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    v.confirmBlock = ^(NSString *item, NSInteger index, NSDate *startDate, NSDate *endDate) {
        if (!(item || (startDate && endDate))) {
            return ;
        }
        if (startDate && endDate) {
            
        }
    };
    [v updateWithTags:nil hasDate:YES showIndicator:NO];
    [self.view.window addSubview:v];
}

- (void)tabSwitched:(id)sender {
    [_pageHandler moveToIndex:_tabSwitchControl.selectedIndex animated:YES];
}

#pragma mark - EAPageVCHandlerDelegate
- (NSUInteger)countOfViewControllersPageHandler:(EAPageVCHandler *)handler {
    return 2;
}

- (UIViewController *)pageHandler:(EAPageVCHandler *)handler viewControllerWithIndex:(NSUInteger)index {
    if (0 == index) {
        EAKongJianChartVC *vc = [[EAKongJianChartVC alloc] init];
        vc.type = EAKongJianVCTypeSheBei;
        vc.spaceId = self.spaceId;
        vc.deviceId = self.shebeiId;
        return vc;
    } else if (1 == index) {
        EAKongJianEventVC *vc = [[EAKongJianEventVC alloc] init];
        vc.type = EAKongJianVCTypeSheBei;
        vc.spaceId = self.spaceId;
        vc.deviceId = self.shebeiId;
        return vc;
    }
    return nil;
}

- (void)pageHandler:(EAPageVCHandler *)handler didMoveToIndex:(NSUInteger)index {
    _tabSwitchControl.selectedIndex = index;
}


@end
