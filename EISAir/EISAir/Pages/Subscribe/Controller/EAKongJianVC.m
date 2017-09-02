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

@interface EAKongJianVC () <EATabSwitchContainerProtocol>

@end

@implementation EAKongJianVC {
    EATabSwitchContainer *_tabSwitchContainer;
    
    NSArray *_datas;
    NSArray *_contents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"空间追踪";
    
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
    NSMutableArray *views = [NSMutableArray array];
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabSwtichControlHeight - NAVIGATION_BAR_HEIGHT);
    for (int i = 0; i < _datas.count; ++i) {
        EADingYueGridContentView *container = [[EADingYueGridContentView alloc] initWithFrame:frame datas:_datas[i]];
        [views addObject:container];
    }
    _contents = views;
    
    _tabSwitchContainer = [[EATabSwitchContainer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
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
