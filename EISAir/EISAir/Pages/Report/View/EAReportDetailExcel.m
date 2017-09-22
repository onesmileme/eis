//
//  EAReportDetailExcel.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportDetailExcel.h"

@implementation EAReportDetailExcel {
    NSArray *_datas;
}

- (instancetype)initWithData:(NSArray *)data title:(NSString *)title
{
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    self = [super initWithFrame:frame];
    if (self) {
        _datas = data;
        
        UILabel *titleLb = TKTemplateLabel2([UIFont boldSystemFontOfSize:13], HexColor(0x333333), title);
        titleLb.left = 14;
        [self addSubview:titleLb];
        
        int rowCount = (int)[_datas.firstObject[@"values"] count] + 1;
        float startX = titleLb.left;
        float startY = titleLb.bottom + 10;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(startX, startY, self.width, 20)];
        bgView.backgroundColor = RGB(247, 247, 247);
        [self addSubview:bgView];
        
        float left = startX;
        float top = startY;
        float height = titleLb.bottom;
        for (int i = 0; i < rowCount + 1; ++i) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(left, top, self.width - left * 2.0, LINE_HEIGHT)];
            line.backgroundColor = HexColor(0xe9e9e9);
            [self addSubview:line];
            top += i ? 40 : 20;
            height = line.bottom;
        }
        self.height = height;
        
        left = startX;
        top = startY;
        float interval = (self.width - left * 2.0) / _datas.count;
        for (int i = 0; i < _datas.count + 1; ++i) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(left, top, LINE_HEIGHT, self.height)];
            line.backgroundColor = HexColor(0xe9e9e9);
            [self addSubview:line];
            
            if (i < _datas.count) {
                UILabel *categoryLb = TKTemplateLabel2([UIFont boldSystemFontOfSize:13], HexColor(0x666666), _datas[i][@"title"]);
                categoryLb.centerX = left + interval * .5;
                categoryLb.centerY = startY + 10;
                [self addSubview:categoryLb];
            }
            left += interval;
        }
        
        left = startX;
        for (int i = 0; i < _datas.count; ++i) {
            top = startY + 20;
            NSArray *values = _datas[i][@"values"];
            for (int j = 0; j < values.count; ++j) {
                UILabel *valueLb = TKTemplateLabel2([UIFont boldSystemFontOfSize:12], HexColor(0x666666), values[j]);
                valueLb.centerX = left + interval * .5;
                valueLb.centerY = top + 20;
                [self addSubview:valueLb];
                top += 40;
            }
            left += interval;
        }
    }
    return self;
}

@end
