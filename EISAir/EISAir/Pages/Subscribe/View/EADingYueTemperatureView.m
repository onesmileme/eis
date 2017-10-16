//
//  EADingYueTemperatureView.m
//  EISAir
//
//  Created by DoubleHH on 2017/10/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EADingYueTemperatureView.h"

static const int kRowInterval = 22;
static const int kLineStart = 7;

@interface EADingYueTemperatureChartView : UIView

@end

@implementation EADingYueTemperatureChartView {
    int _maxTemper;
    int _minTemper;
    NSArray *_data;
    NSArray *_compareData;
}
- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)data compareData:(NSArray *)compareData {
    self = [super initWithFrame:frame];
    if (self) {
        _data = data;
        _compareData = compareData;
        self.backgroundColor = [UIColor whiteColor];
        float minTemper = INT_MAX;
        float maxTemper = INT_MIN;
        for (NSDictionary *info in data) {
            float temper = [info[@"temper"] floatValue];
            minTemper = MIN(temper, minTemper);
            maxTemper = MAX(maxTemper, temper);
        }
        for (NSDictionary *info in compareData) {
            float temper = [info[@"temper"] floatValue];
            minTemper = MIN(temper, minTemper);
            maxTemper = MAX(maxTemper, temper);
        }
        _minTemper = (((int)minTemper) / 5 - 1) * 5;
        _maxTemper = (((int)maxTemper) / 5 + 1) * 5;
        
        self.height = (_maxTemper - _minTemper) / 5 * kRowInterval + 24;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [HexColor(0x8ca0b3) set];
    CGContextSetLineWidth(context, LINE_HEIGHT);
    CGFloat arr[] = {1, 1};
    CGContextSetLineDash(context, 0, arr, 2);
    float top = 0;
    float left = 22;
    float width = self.width - left - 22;
    NSMutableDictionary *attrs = [self textAttrs];
    for (int temp = _maxTemper; temp >= _minTemper; temp = temp - 5) {
        NSString *tempString = @(temp).description;
        CGSize size = [tempString sizeWithAttributes:attrs];
        CGRect textRect = CGRectMake(0, top, size.width, size.height);
        [tempString drawInRect:textRect withAttributes:attrs];
        
        if (temp != _minTemper) {
            CGContextMoveToPoint(context, left, top + kLineStart);
            CGContextAddLineToPoint(context, width + left, top + kLineStart);
        }
        
        top += kRowInterval;
    }
    
    NSUInteger length = MAX(_data.count, _compareData.count);
    if (length > 12) {
        if (length % 2) {
            length = (length + 1) / 2;
        } else {
            length = length / 2 + 1;
        }
    }
    top = kLineStart;
    float interval = width / (length - 1);
    float x = left;
    float height = (_maxTemper - _minTemper) / 5 * kRowInterval;
    for (int i = 0; i < length; ++i) {
        int index = i * 2;
        if (i) {
            CGContextMoveToPoint(context, x, top);
            CGContextAddLineToPoint(context, x, top + height);
        }
        
        NSString *tempString = nil;
        if (index < _data.count) {
            tempString = _data[index][@"time"];
        } else if (index < _compareData.count) {
            tempString = _compareData[index][@"time"];
        }
        if (tempString.length) {
            CGSize size = [tempString sizeWithAttributes:attrs];
            CGRect textRect = CGRectMake(x - size.width * .5, top + height + 3, size.width, size.height);
            [tempString drawInRect:textRect withAttributes:attrs];
        }
        
        x += interval;
    }
    
    CGSize size = [@"时" sizeWithAttributes:attrs];
    CGRect textRect = CGRectMake(width + left + 12, top + height + 3, size.width, size.height);
    [@"时" drawInRect:textRect withAttributes:attrs];
    
    CGContextStrokePath(context);
    
    [HexColor(0x00b0ce) set];
    CGContextSetLineWidth(context, LINE_HEIGHT);
    CGContextSetLineDash(context, 0, NULL, 0);
    
    CGContextMoveToPoint(context, left, kLineStart);
    CGContextAddLineToPoint(context, left, height + kLineStart);
    CGContextMoveToPoint(context, left, height + kLineStart);
    CGContextAddLineToPoint(context, width + left, height + kLineStart);
    
    CGContextStrokePath(context);
    
    interval = interval * .5;
    [self addLineWithData:_data color:HexColor(0x268ef7) context:context left:left interval:interval height:height];
    [self addLineWithData:_compareData color:HexColor(0xff6663) context:context left:left interval:interval height:height];
}

- (void)addLineWithData:(NSArray *)data
                  color:(UIColor *)color
                context:(CGContextRef)context
                   left:(float)left
               interval:(float)interval
                 height:(float)height {
    [color set];
    CGContextSetLineWidth(context, 1);
    __block float maxTemp = INT_MIN;
    __block float index = -1;
    [data enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull info, NSUInteger idx, BOOL * _Nonnull stop) {
        float temp = [info[@"temper"] floatValue];
        if (maxTemp < temp) {
            maxTemp = temp;
            index = idx;
        }
    }];
    CGRect rects[2];
    int pointIndex = -1;
    for (int i = 0; i < data.count; ++i) {
        float value = [data[i][@"temper"] floatValue];
        float x = left + i * interval;
        float y = (_maxTemper - value) * height / (_maxTemper - _minTemper) + kLineStart;
        if (i == 0) {
            CGContextMoveToPoint(context, x, y);
        } else {
            CGContextAddLineToPoint(context, x, y);
        }
        
        if (i == 0 || index == i) {
            NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
            attrs[NSForegroundColorAttributeName] = color;
            attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
            NSString *tempString = [NSString stringWithFormat:@"%@℃", data[i][@"temper"]];
            CGSize size = [tempString sizeWithAttributes:attrs];
            CGRect textRect = CGRectMake(x + 3, MAX(y - (_data == data ? 7 : 0), 0), size.width, size.height);
            [tempString drawInRect:textRect withAttributes:attrs];
            pointIndex++;
            rects[pointIndex] = CGRectMake(x - 1, y - 1, 2, 2);
        }
    }
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 2);
    for (int i = 0; i <= pointIndex; i++) {
        CGContextAddEllipseInRect(context, rects[i]);
    }
    CGContextStrokePath(context);
}

- (NSMutableDictionary *)textAttrs {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HexColor(0xb0b0b0);
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    return attrs;
}

@end

@implementation EADingYueTemperatureView

- (instancetype)initWithData:(NSDictionary *)data {
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = TKTemplateLabel2(SYS_FONT(14), HexColor(0x4a4a4a), data[@"title"]);
        titleLabel.left = 30;
        [self addSubview:titleLabel];
        
        UIView *oneLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 1.5)];
        oneLine.backgroundColor = HexColor(0x268ef7);
        [self addSubview:oneLine];
        
        UIView *twoLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, oneLine.width, oneLine.height)];
        twoLine.backgroundColor = HexColor(0x268ef7);
        [self addSubview:twoLine];
        
        UILabel *oneLabel = TKTemplateLabel2(SYS_FONT(9), HexColor(0x4a4a4a), data[@"date"]);
        [self addSubview:oneLabel];
        
        UILabel *twoLabel = TKTemplateLabel2(SYS_FONT(9), HexColor(0x4a4a4a), data[@"compare_date"]);
        [self addSubview:twoLabel];
        
        twoLabel.right = self.width - 25;
        twoLine.right = twoLabel.left - 5;
        oneLabel.right = twoLine.left - 15;
        oneLine.right = oneLabel.left - 5;
        oneLabel.centerY = twoLabel.centerY = oneLine.centerY = twoLine.centerY = titleLabel.centerY;
        
        UILabel *temperLabel = TKTemplateLabel2(SYS_FONT(10), HexColor(0xb0b0b0), @"℃");
        temperLabel.top = titleLabel.bottom + 3;
        temperLabel.left = titleLabel.left + 3;
        [self addSubview:temperLabel];
        
        EADingYueTemperatureChartView *chartView = [[EADingYueTemperatureChartView alloc] initWithFrame:CGRectMake(titleLabel.left, temperLabel.bottom + 4, self.width - temperLabel.left * 2 + 6, 0) Data:data[@"data"] compareData:data[@"compare_data"]];
        [self addSubview:chartView];
        self.height = chartView.bottom;
    }
    return self;
}

@end
