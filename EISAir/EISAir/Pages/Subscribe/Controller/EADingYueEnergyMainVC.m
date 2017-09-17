//
//  EADingYueEnergyMainVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EADingYueEnergyMainVC.h"
#import "EASubscribeHeaderView.h"
#import "EATabSwitchContainer.h"
#import "EAEnergyTableView.h"
#import "EADianFeiVC.h"
#import "EADingYueEnergyChartVC.h"

@interface EADingYueEnergyMainVC () <EATabSwitchContainerProtocol> {
    EASubscribeHeaderView *_headerView;
    EATabSwitchContainer *_tabSwitchContainer;
    
    NSArray *_contents;
    NSArray *_datas;
}

@end

@implementation EADingYueEnergyMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"能耗追踪";
    self.view.backgroundColor = [UIColor themeGrayColor];
    
    [self initDatas];
    
    _headerView = [[EASubscribeHeaderView alloc] initWithIcon:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504329930636&di=31c2f68226b75ce1f5db43f3ecfd6659&imgtype=0&src=http%3A%2F%2Fa1.att.hudong.com%2F41%2F79%2F19300001290790131174792213082.jpg" subscribeCount:20 subscribed:YES];
    weakify(self);
    _headerView.subscribeClickBlock = ^{
        strongify(self);
    };
    _headerView.subscriberClickBlock = ^{
        strongify(self);
    };
    [self.view addSubview:_headerView];
    
    NSMutableArray *views = [NSMutableArray array];
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabSwtichControlHeight - NAVIGATION_BAR_HEIGHT - _headerView.bottom);
    for (int i = 0; i < _datas.count; ++i) {
        EAEnergyTableView *container = [[EAEnergyTableView alloc] initWithFrame:frame];
        [views addObject:container];
        container.clickBlock = ^ (NSInteger index) {
            strongify(self);
            [self clickedWithTab:i index:index];
        };
        [container updateData:_datas[i]];
    }
    _contents = views;
    
    _tabSwitchContainer = [[EATabSwitchContainer alloc] initWithFrame:CGRectMake(0, _headerView.bottom, SCREEN_WIDTH, frame.size.height + kTabSwtichControlHeight)];
    _tabSwitchContainer.delegate = self;
    [self.view addSubview:_tabSwitchContainer];
    _tabSwitchContainer.backgroundColor = self.view.backgroundColor;
}

- (void)initDatas {
    _datas = @[
               @[
                   @{
                       @"text": @"用电消耗追踪",
                       @"pic": @"dingyue_pic4_1",
                       },
                   @{
                       @"text": @"用水消耗追踪",
                       @"pic": @"dingyue_pic4_2",
                       },
                   @{
                       @"text": @"冷量消耗追踪",
                       @"pic": @"dingyue_pic4_3",
                       },
                   @{
                       @"text": @"热水消耗追踪",
                       @"pic": @"dingyue_pic4_4",
                       },
                   ],
               @[
                   @{
                       @"text": @"用电费用追踪",
                       @"pic": @"dingyue_pic5_1",
                       },
                   @{
                       @"text": @"用水费用追踪",
                       @"pic": @"dingyue_pic5_2",
                       },
                   @{
                       @"text": @"冷量费用追踪",
                       @"pic": @"dingyue_pic5_3",
                       },
                   @{
                       @"text": @"热水费用追踪",
                       @"pic": @"dingyue_pic5_4",
                       },
                   ],
               ];
}

- (void)clickedWithTab:(NSInteger)tab index:(NSInteger)index {
    if (0 == tab) {
        EADingYueEnergyChartVC *vc = [[EADingYueEnergyChartVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        EADianFeiVC *vc = [[EADianFeiVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - EATabSwitchContainerProtocol
// data source
- (NSArray<NSString *> *)tabSwitchContainerHeaderTitles:(EATabSwitchContainer *)container {
    return @[@"能源消耗", @"能源费用"];
}

- (UIView *)tabSwitchContainer:(EATabSwitchContainer *)container viewForIndex:(NSUInteger)index {
    if (index < _contents.count) {
        return _contents[index];
    }
    return nil;
}

- (NSDictionary *)tabSwitchContainerHeaderConfig:(EATabSwitchContainer *)container {
    return @{ @"lineColor": HexColor(0x28cfc1), };
}

// actions
- (void)tabSwitchContainer:(EATabSwitchContainer *)container selectedIndex:(NSUInteger)index {
    
}

@end
