//
//  EADianFeiVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EADianFeiVC.h"
#import "EADingYueGridContentView.h"

@interface EADianFeiVC ()

@end

@implementation EADianFeiVC {
    EADingYueGridContentView *_contentView;
    
    NSArray *_datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电费追踪";
    self.tabBarItem.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _datas =
    @[
      @{
          @"title": @"办公租户",
          @"items": @[@"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",],
          @"subscribed": @(0),
          },
      @{
          @"title": @"商业租户",
          @"items": @[@"计算单位1计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",],
          @"subscribed": @(1),
          },
      @{
          @"title": @"其他租户",
          @"items": @[@"计算单位1计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",
                      @"计算单位1",@"计算单位1",@"计算单位1",@"计算单位1",],
          @"subscribed": @(0),
          },
      ];
    
    [self createSubviews];
}

- (void)createSubviews {
    _contentView = [[EADingYueGridContentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) datas:_datas];
    [self.view addSubview:_contentView];
}

@end
