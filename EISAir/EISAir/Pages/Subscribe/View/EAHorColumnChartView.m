//
//  EAHorColumnChartView.m
//  EISAir
//
//  Created by iwm on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAHorColumnChartView.h"
#import "EAGridBackgroudView.h"

@implementation EAHorColumnChartView {
    EAGridBackgroudView *_gridBgView;
    NSArray *_dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = dataArray;
        long long maxValue = [self computeredMaxValue];
        
        int row = (int)dataArray.count - 1;
        row = MAX(1, row);
        int column = 12;
        _gridBgView = [[EAGridBackgroudView alloc] initWithFrame:CGRectMake(60, 26, self.width - 85, 160)
                                                       lineColor:HexColor(0x8ca0b3)
                                                             row:row
                                                          column:column];
        [self addSubview:_gridBgView];
        
        float top = _gridBgView.top;
        float interval = _gridBgView.height / row;
        float height = 0;
        for (int i = 0; i < _dataArray.count; ++i) {
            // name
            UILabel *label = TKTemplateLabel2([UIFont systemFontOfSize:12], HexColor(0x444444), _dataArray[i][@"name"]);
            label.right = 50;
            label.top = top;
            [self addSubview:label];
            
            // value
            float width = _gridBgView.width * [_dataArray[i][@"value"] floatValue] / (float)maxValue;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_gridBgView.left, top, width, 12)];
            view.backgroundColor = HexColor(0x28cfc1);
            view.clipsToBounds = YES;
            view.layer.cornerRadius = 3;
            [self addSubview:view];
            height = view.bottom;
            
            top += interval;
        }
        
        long long average = maxValue / 6;
        long long value = 0;
        float centerX = _gridBgView.left;
        float horInterval = _gridBgView.width / 6;
        for (int i = 0; i < 7; ++i) {
            UILabel *label = TKTemplateLabel2([UIFont systemFontOfSize:10], HexColor(0x9b9b9b), [@(value) description]);
            label.centerX = centerX;
            label.top = 0;
            [self addSubview:label];
            centerX += horInterval;
            value += average;
        }
        
        self.height = height + 2;
    }
    return self;
}

- (long long)computeredMaxValue {
    long long max = 0;
    for (int i = 0; i < _dataArray.count; ++i) {
        max = MAX(max, [_dataArray[i][@"value"] longLongValue]);
    }
    long long average = max / 6;
    long long threshold = [self computeredThresholdWithValue:max];
    average = (average / threshold + 1) * threshold;
    max = average * 6;
    return max;
}

- (long long)computeredThresholdWithValue:(long long)value {
    long long threshold = 1;
    long long temp = value;
    while (temp) {
        temp = temp / 10;
        threshold *= 10;
    }
    threshold /= 10;
    threshold = MAX(1, threshold);
    if (threshold < 1000) {
        return threshold;
    }
    return threshold / 10;
}

@end
