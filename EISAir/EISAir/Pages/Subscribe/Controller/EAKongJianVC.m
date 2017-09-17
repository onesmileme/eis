//
//  EAKongJianVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAKongJianVC.h"
#import "EATabSwitchContainer.h"
#import "EADingYueGridContentView.h"
#import "EASubscribeHeaderView.h"

@interface EAKongJianVC () <EATabSwitchContainerProtocol>

@end

@implementation EAKongJianVC {
    EASubscribeHeaderView *_headerView;
    EATabSwitchContainer *_tabSwitchContainer;
    
    NSArray *_datas;
    NSArray *_contents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.type == EAKongJianVCTypeSheBei ? @"设置追踪" : @"空间追踪";
    
    _datas =
    @[
      @[
          @{
              @"title": @"F1",
              @"items": @[@"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(0),
              },
          @{
              @"title": @"F2",
              @"items": @[@"计算单位1计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(1),
              },
          @{
              @"title": @"F3",
              @"items": @[@"计算单位1计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(0),
              },
          ],
      @[
          @{
              @"title": @"K1",
              @"items": @[@"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(0),
              },
          @{
              @"title": @"K2",
              @"items": @[@"计算单位1计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(1),
              },
          @{
              @"title": @"K3",
              @"items": @[@"计算单位1计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(0),
              },
          ],
      @[
          @{
              @"title": @"U1",
              @"items": @[@"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(0),
              },
          @{
              @"title": @"I2",
              @"items": @[@"计算单位1计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(1),
              },
          @{
              @"title": @"HJKL3",
              @"items": @[@"计算单位1计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                          @"计算单位1",@"计算单位1",],
              @"subscribed": @(0),
              },
          ],
      ];
    [self createSubviews];
}

- (void)createSubviews {
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
        EADingYueGridContentView *container = [[EADingYueGridContentView alloc] initWithFrame:frame datas:_datas[i]];
        [views addObject:container];
    }
    _contents = views;
    
    _tabSwitchContainer = [[EATabSwitchContainer alloc] initWithFrame:CGRectMake(0, _headerView.bottom, SCREEN_WIDTH, frame.size.height + kTabSwtichControlHeight)];
    _tabSwitchContainer.delegate = self;
    [self.view addSubview:_tabSwitchContainer];
}

#pragma mark - EATabSwitchContainerProtocol
// data source
- (NSArray<NSString *> *)tabSwitchContainerHeaderTitles:(EATabSwitchContainer *)container {
    return @[@"建筑A", @"建筑B", @"建筑C"];
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
