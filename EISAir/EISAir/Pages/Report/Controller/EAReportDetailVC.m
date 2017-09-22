//
//  EAReportDetailVC.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportDetailVC.h"
#import "EAReportColumnChart.h"
#import "EAReportDetailExcel.h"

@interface EAReportDetailVC () {
    EAReportColumnChart *_topChart;
    UIScrollView *_contentView;
    EAReportDetailExcel *_excel;
}

@end

@implementation EAReportDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    NSString *text = @"度量：空调温度C座";
    UILabel *duLabel = TKTemplateLabel2([UIFont systemFontOfSize:13], HexColor(0x1c1c1c), text);
    duLabel.left = 15;
    duLabel.top = 16;
    [_contentView addSubview:duLabel];
    
    text = @"时间：2016/12/01 ~ 2017/12/01";
    UILabel *timeLabel = TKTemplateLabel2([UIFont systemFontOfSize:13], HexColor(0x1c1c1c), text);
    timeLabel.left = duLabel.left;
    timeLabel.top = duLabel.bottom + 12;
    [_contentView addSubview:timeLabel];
    
    _topChart = [[EAReportColumnChart alloc] initWithFrame:CGRectMake(0, timeLabel.bottom + 32, SCREEN_WIDTH, 0) datas:[self chartData]];
    [_contentView addSubview:_topChart];
    
    _excel = [[EAReportDetailExcel alloc] initWithData:[self excelData] title:@"视图信息"];
    _excel.top = _topChart.bottom + 54;
    [_contentView addSubview:_excel];
    _contentView.contentSize = CGSizeMake(_contentView.width, MAX(_contentView.height, _excel.bottom + 10));
}

- (NSArray *)chartData {
    return @[
             @[@(10), @(8)],
             @[@(12), @(35)],
             @[@(15), @(8)],
             @[@(30), @(8)],
             @[@(32), @(18)],
             
             @[@(22), @(8)],
             @[@(19), @(8)],
             @[@(10), @(8)],
             @[@(19), @(18)],
             ];
}

- (NSArray *)excelData {
    return @[
             @{
                 @"title": @"日期时间",
                 @"values": @[
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         ],
                 },
             @{
                 @"title": @"对象",
                 @"values": @[
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         ],
                 },
             @{
                 @"title": @"标签",
                 @"values": @[
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         ],
                 },
             @{
                 @"title": @"来源",
                 @"values": @[
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         @"2016/12/12",
                         ],
                 },
             ];
}

@end
