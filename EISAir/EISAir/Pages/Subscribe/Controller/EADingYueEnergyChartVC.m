//
//  EADingYueEnergyChartVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EADingYueEnergyChartVC.h"
#import "EAEnergyCountControl.h"
#import "EADingYueEnergyHistoryVC.h"

@interface EADingYueEnergyChartVC () {
    UIScrollView *_contentView;
    UIView *_headerView;
    UIView *_detailView;
    PYEchartsView *_echartsView;
    
    NSArray *_dataArray;
}

@end

@implementation EADingYueEnergyChartVC

- (void)initData {
    [super initData];
    float totalWidth = SCREEN_WIDTH * 0.55;
    float max = 3000;
    _dataArray =
    @[
      @{
          @"title": @"高压进线段一",
          @"detail": @"3000kwh",
          @"count":@(3000),
          @"width": @((int)(3000.0 / max * totalWidth)),
          @"color": HexColor(0x28cfc1),
          },
      @{
          @"title": @"高压进线段2",
          @"detail": @"3000kwh",
          @"count": @(2100),
          @"width": @((int)(2100.0 / max * totalWidth)),
          @"color": [HexColor(0x28cfc1) colorWithAlphaComponent:0.8],
          },
      @{
          @"title": @"高压进线段3",
          @"detail": @"3000kwh",
          @"count":@(3000),
          @"width": @((int)(1500.0 / max * totalWidth)),
          @"color": [HexColor(0x28cfc1) colorWithAlphaComponent:0.7],
          },
      @{
          @"title": @"高压进线段4",
          @"detail": @"1000kwh",
          @"count": @(1000),
          @"width": @((int)(1000.0 / max * totalWidth)),
          @"color": [HexColor(0x28cfc1) colorWithAlphaComponent:0.5],
          },
      ];
}

- (void)initView {
    [super initView];
    self.title = @"支路用电";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    [self addHeader];
    UIView *intervalView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, SCREEN_WIDTH, 10)];
    intervalView.backgroundColor = [UIColor themeGrayColor];
    [_contentView addSubview:intervalView];
    [self addDetail];
}

- (void)addHeader {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, FlexibleHeightTo6(240) + 62)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:_headerView];
    
    UILabel *titleLabel = TKTemplateLabel2([UIFont systemFontOfSize:15], HexColor(0x444444), @"一级");
    titleLabel.left = 15;
    titleLabel.top = 20;
    [_headerView addSubview:titleLabel];
    
    UILabel *detailLabel = TKTemplateLabel2([UIFont systemFontOfSize:15], HexColor(0x9b9b9b), @"查看详情");
    detailLabel.right = SCREEN_WIDTH - 15;
    detailLabel.centerY = titleLabel.centerY;
    [_headerView addSubview:detailLabel];
    
    UIControl *detailControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
    [detailControl addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:detailControl];
    
    _echartsView = [[PYEchartsView alloc] initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH - 30, FlexibleHeightTo6(240))];
    [_echartsView setOption:[self echartData]];
    [_echartsView loadEcharts];
    [_headerView addSubview:_echartsView];
}

- (PYOption *)echartData {
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in _dataArray) {
        [dataArray addObject:[PYTreeSeriesData initPYTreeSeriesDataWithBlock:^(PYTreeSeriesData *data) {
            data
            .nameEqual(dict[@"title"])
            .valueEqual(dict[@"count"])
            .itemStyleEqual([PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
                itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *normal) {
                    normal.colorEqual([[PYColor alloc] initWithColor:dict[@"color"]])
                    .labelEqual([PYLabel initPYLabelWithBlock:^(PYLabel *label) {
                        label.showEqual(NO);
                    }])
                    .borderWidthEqual(@4)
                    .borderColorEqual(PYRGBA(255, 255, 255, 1))
                    ;
                }]);
            }]);
        }]];
    }
    return [PYOption initPYOptionWithBlock:^(PYOption *option) {
        option.tooltipEqual([PYTooltip initPYTooltipWithBlock:^(PYTooltip *tooltip) {
            tooltip.triggerEqual(PYTooltipTriggerItem)
            .formatterEqual(@"{b}: {c}");
        }])
        .calculableEqual(NO)
        .addSeries([PYTreeMapSeries initPYTreeMapSeriesWithBlock:^(PYTreeMapSeries *series) {
            series
            .sizeEqual(@[@"100%", @"100%"])
            .nameEqual(@"")
            .typeEqual(PYSeriesTypeTreemap)
            .addDataArr(dataArray);
        }]);
    }];
}

- (void)addDetail {
    _detailView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.bottom + 10, SCREEN_WIDTH, 0)];
    _detailView.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:_detailView];
    
    float top = 0;
    NSArray *datas = _dataArray;
    for (int i = 0; i < datas.count; ++i) {
        NSDictionary *dict = datas[i];
        EAEnergyCountControl *control = [[EAEnergyCountControl alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 50)];
        [control updateModel:dict];;
        [_detailView addSubview:control];
        top = control.bottom;
    }
    _detailView.height = top;
    
    _contentView.contentSize = CGSizeMake(SCREEN_WIDTH, MAX(_contentView.height, _detailView.bottom));
}

- (void)detailClick {
    EADingYueEnergyHistoryVC *vc = [[EADingYueEnergyHistoryVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
