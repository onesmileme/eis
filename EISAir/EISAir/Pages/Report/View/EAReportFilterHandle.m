//
//  EAReportFilterHandle.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportFilterHandle.h"
#import "EAReportFilterBar.h"
#import "EAReportFilterContentView.h"

@implementation EAReportFilterHandle {
    EAReportFilterBar *_filterBar;
    NSArray *_data;
    EAReportFilterContentView *_showingContentView;
    NSInteger _showingIndex;
    NSMutableArray *_seletedArray;
}

- (instancetype)initWithData:(NSArray *)data {
    self = [super init];
    if (self) {
        _data = data;
        _seletedArray = [NSMutableArray arrayWithCapacity:_data.count];
        for (id obj in _data) {
            [_seletedArray addObject:@(0)];
        }
    }
    return self;
}

- (UIView *)filterBar {
    if (!_filterBar) {
        _filterBar = [[EAReportFilterBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_filterBar setModel:self.filterBarData];
        weakify(self);
        _filterBar.clickedBlock = ^ (NSInteger index) {
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

- (void)clickedFilterBar:(NSInteger)index {
    if (index < 0) {
        // hide
        [self updateContentViewIsShow:NO];
    } else {
        // show
        _showingIndex = index;
        [self updateContentViewIsShow:YES];
    }
}

- (void)updateContentViewIsShow:(BOOL)isShow {
    if (isShow) {
        BOOL animated = _showingContentView.superview == nil;
        if (_showingContentView.superview) {
            [_showingContentView removeFromSuperview];
        }
        _showingContentView = [[EAReportFilterContentView alloc] initWithData:_data[_showingIndex][@"values"] selectedIndex:[_seletedArray[_showingIndex] integerValue]];
        weakify(self);
        weakify(_showingContentView);
        _showingContentView.itemClickedBlock = ^ {
            strongify(self);
            [self contentClicked:weak_showingContentView];
        };
        _showingContentView.bgClickedBlock = ^ {
            strongify(self);
            [self updateContentViewIsShow:NO];
        };
        _showingContentView.top = self.filterBar.bottom;
        [self.filterBar.superview addSubview:_showingContentView];
        if (animated) {
            _showingContentView.alpha = 0;
            [UIView animateWithDuration:0.1 animations:^{
                weak_showingContentView.alpha = 1;
            }];
        }
    }
    else {
        if (_showingContentView) {
            weakify(_showingContentView);
            [UIView animateWithDuration:0.1 animations:^{
                weak_showingContentView.alpha = 0;
            } completion:^(BOOL finished) {
                [weak_showingContentView removeFromSuperview];
            }];
            [_filterBar selectedNone];
        }
    }
}

- (void)contentClicked:(EAReportFilterContentView *)contentView {
    _seletedArray[_showingIndex] = @(contentView.selectedIndex);
    [self updateContentViewIsShow:NO];
    if ([self.delegate respondsToSelector:@selector(filterHandle:clickedInCategory:rowIndex:)]) {
        [self.delegate filterHandle:self clickedInCategory:_showingIndex rowIndex:([_seletedArray[_showingIndex] integerValue])];
    }
}

@end
