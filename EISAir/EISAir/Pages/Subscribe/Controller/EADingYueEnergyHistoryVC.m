//
//  EADingYueEnergyHistoryVC.m
//  EISAir
//
//  Created by iwm on 2017/9/18.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EADingYueEnergyHistoryVC.h"
#include "EAHorColumnChartView.h"

@interface EADingYueEnergyHistoryVC () {
    UIScrollView *_contentView;
    EAHorColumnChartView *_horChartView;
    
    NSArray *_dataArray;
}

@end

@implementation EADingYueEnergyHistoryVC

- (void)initData {
    [super initData];
    
    _dataArray =
    @[
      @{
          @"name": @"电表1",
          @"value": @(11000),
          },
      @{
          @"name": @"电表2",
          @"value": @(9200),
          },
      @{
          @"name": @"电表3",
          @"value": @(8100),
          },
      @{
          @"name": @"电表4",
          @"value": @(7000),
          },
      @{
          @"name": @"电表5",
          @"value": @(6000),
          },
      @{
          @"name": @"电表6",
          @"value": @(5000),
          },
      ];
}

- (void)initView {
    [super initView];
    self.title = @"支路用电历史查询";
    self.view.backgroundColor = [UIColor themeGrayColor];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    _horChartView = [[EAHorColumnChartView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 0) dataArray:_dataArray];
    [_contentView addSubview:_horChartView];
    
    UIView *intervalView = [[UIView alloc] initWithFrame:CGRectMake(0, _horChartView.bottom + 12, SCREEN_WIDTH, 10)];
    intervalView.backgroundColor = [UIColor themeGrayColor];
    [_contentView addSubview:intervalView];
    
    
}

@end
