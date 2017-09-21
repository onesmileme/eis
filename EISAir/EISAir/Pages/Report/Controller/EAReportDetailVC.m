//
//  EAReportDetailVC.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportDetailVC.h"

@interface EAReportDetailVC ()

@end

@implementation EAReportDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)chartData {
    return @[
             @[@(10), @(8)],
             @[@(12), @(10)],
             @[@(15), @(8)],
             @[@(20), @(8)],
             @[@(5), @(18)],
             
             @[@(22), @(8)],
             @[@(19), @(8)],
             @[@(10), @(8)],
             @[@(19), @(18)],
             ];
}

@end
