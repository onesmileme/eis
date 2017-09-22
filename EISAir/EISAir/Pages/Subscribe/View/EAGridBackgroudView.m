//
//  EAGridBackgroudView.m
//  EISAir
//
//  Created by iwm on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAGridBackgroudView.h"

@implementation EAGridBackgroudView {
    UIColor *_lineColor;
    int _row;
    int _column;
    BOOL _isSquare;
}

- (instancetype)initWithFrame:(CGRect)frame
                    lineColor:(UIColor *)lineColor
                          row:(int)row {
    int column = (int)(frame.size.width / (frame.size.height / row));
    EAGridBackgroudView *view = [self initWithFrame:frame lineColor:lineColor row:row column:column];
    view->_isSquare = YES;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
                    lineColor:(UIColor *)lineColor
                          row:(int)row
                       column:(int)column {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _lineColor = lineColor;
        _row = row;
        _column = column;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_row <= 1 || _column <= 1) {
        return;
    }
    float lineHeight = LINE_HEIGHT;
    // Drawing code.
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条粗细宽度
    CGContextSetLineWidth(context, lineHeight);
    //设置颜色
    [_lineColor set];
    //开始一个起始路径
    CGContextBeginPath(context);
    //hua
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.width, 0);
    CGContextAddLineToPoint(context, self.width, self.height - lineHeight);
    CGContextAddLineToPoint(context, 0, self.height);
    CGContextAddLineToPoint(context, 0, 0);
    
    float x = lineHeight, y = lineHeight;
    float rowInterval = self.height / (_row);
    for (int i = 0; i < _row + 1; ++i) {
        if (i == _row) {
            y -= 2 * lineHeight;
        }
        CGContextMoveToPoint(context, 0, y);
        CGContextAddLineToPoint(context, self.width, y);
        y += rowInterval;
    }
    
    x = lineHeight;
    float columnInterval = self.width / (_column);
    if (_isSquare) {
        columnInterval = rowInterval;
    }
    for (int i = 0; i < _column + 1; ++i) {
        if (i == _column) {
            x -= 2 * lineHeight;
        }
        CGContextMoveToPoint(context, x, 0);
        CGContextAddLineToPoint(context, x, self.height);
        x += columnInterval;
    }
    
    //连接上面定义的坐标点
    CGFloat arr[] = {1,1};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
