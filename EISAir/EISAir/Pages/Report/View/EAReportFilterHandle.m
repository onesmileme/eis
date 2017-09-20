//
//  EAReportFilterHandle.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportFilterHandle.h"
#import "EAReportFilterBar.h"

@implementation EAReportFilterHandle {
    EAReportFilterBar *_filterBar;
    NSArray *_data;
}

- (instancetype)initWithData:(NSArray *)data {
    self = [super init];
    if (self) {
        _data = data;
    }
    return self;
}

- (UIView *)filterBar {
    if (!_filterBar) {
        _filterBar = [[EAReportFilterBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_filterBar setModel:self.filterBarData];
        weakify(self);
        _filterBar.clickedBlock = ^ (NSUInteger index) {
            strongify(self);
            [self clickedFilterBar:index];
        };
    }
    return _filterBar;
}

- (NSArray *)filterBarData {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in _data) {
        [array addObject:dic[@"category"] ?: @""];
    }
    return array;
}

- (void)clickedFilterBar:(NSUInteger)index {
    
}

@end
