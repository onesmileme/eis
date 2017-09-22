//
//  EAReportDetailVC.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportDetailVC.h"
#import "EAReportColumnChart.h"

@interface EAReportDetailVC () {
    EAReportColumnChart *_topChart;
}

@end

@implementation EAReportDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *text = @"度量：空调温度C座";
    UILabel *duLabel = TKTemplateLabel2([UIFont systemFontOfSize:13], HexColor(0x1c1c1c), text);
    duLabel.left = 15;
    duLabel.top = 16;
    [self.view addSubview:duLabel];
    
    text = @"时间：2016/12/01 ~ 2017/12/01";
    UILabel *timeLabel = TKTemplateLabel2([UIFont systemFontOfSize:13], HexColor(0x1c1c1c), text);
    timeLabel.left = duLabel.left;
    timeLabel.top = duLabel.bottom + 12;
    [self.view addSubview:timeLabel];
    
    _topChart = [[EAReportColumnChart alloc] initWithFrame:CGRectMake(0, timeLabel.bottom + 32, SCREEN_WIDTH, 0) datas:[self chartData]];
    [self.view addSubview:_topChart];
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

@end
