//
//  EAReportColumnChart.m
//  EISAir
//
//  Created by iwm on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportColumnChart.h"
#import "EAGridBackgroudView.h"

static const int kRowHeight = 24;

@implementation EAReportColumnChart {
    NSArray *_datas;
}

- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas {
    self = [super initWithFrame:frame];
    if (self) {
        _datas = datas;
        
        UILabel *danweiLabel = TKTemplateLabel2([UIFont systemFontOfSize:12], HexColor(0xb0b0b0), @"℃");
        danweiLabel.left = 7;
        danweiLabel.top = 0;
        [self addSubview:danweiLabel];
        
        CGFloat noteleft = [self addNote:@"设定平均值" x:(danweiLabel.right + 12) isLeft:YES];
        [self addNote:@"实际平均值" x:(noteleft + 14) isLeft:NO];
        
        int rows = [self maxRows];
        CGRect bgFrame = CGRectMake(26, danweiLabel.bottom + 10, self.width - 26, rows * kRowHeight);
        EAGridBackgroudView *bgView = [[EAGridBackgroudView alloc] initWithFrame:bgFrame lineColor:HexColor(0x8ca0b3) row:rows];
        [self addSubview:bgView];
        
        for (int i = 0; i <= rows; ++i) {
            int temperature = (rows - i) * 5;
            UILabel *label = TKTemplateLabel2([UIFont systemFontOfSize:10], HexColor(0xb0b0b0), @(temperature).description);
            label.right = 20;
            label.centerY = bgView.top + kRowHeight * i;
            [self addSubview:label];
            
            if (temperature == 25) {
                UIView *softView = [[UIView alloc] initWithFrame:CGRectMake(0, kRowHeight * i, bgView.width, kRowHeight)];
                softView.backgroundColor = [HexColor(0x28cfc1) colorWithAlphaComponent:0.2];
                [bgView addSubview:softView];
                
                UILabel *templabel = TKTemplateLabel2([UIFont systemFontOfSize:10], HexColor(0x28cfc1), @"温度舒适区间");
                templabel.left = 6;
                templabel.centerY = softView.height * .5;
                [softView addSubview:templabel];
            }
        }
        
        float left = 15;
        float interval = (bgFrame.size.width - left * 2.0) / (_datas.count - 1);
        float heightPerPix = bgFrame.size.height / (rows * 5);
        for (int i = 0; i < _datas.count; ++i) {
            NSString *text = [NSString stringWithFormat:@"F%d", i + 1];
            UILabel *label = TKTemplateLabel2([UIFont systemFontOfSize:10], HexColor(0xb0b0b0), text);
            label.centerX = bgView.left + left;
            label.top = bgView.bottom + 6;
            [self addSubview:label];
            
            float leftHeight = [[_datas[i] firstObject] floatValue] * heightPerPix;
            UIView *leftView = [self viewOfHeight:leftHeight isLeft:YES];
            leftView.right = label.centerX;
            leftView.bottom = bgView.bottom;
            [self addSubview:leftView];
            
            float rightHeight = [[_datas[i] lastObject] floatValue] * heightPerPix;
            UIView *rightView = [self viewOfHeight:rightHeight isLeft:NO];
            rightView.left = label.centerX;
            rightView.bottom = leftView.bottom;
            [self addSubview:rightView];
            
            left += interval;
        }
        
        self.height = bgView.bottom + 20;
    }
    return self;
}

- (float)addNote:(NSString *)note x:(float)x isLeft:(BOOL)isLeft {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 7, 7)];
    view.backgroundColor = isLeft ? [HexColor(0x00afcf) colorWithAlphaComponent:0.3] : HexColor(0x00afcf);
    view.layer.cornerRadius = view.height * .5;
    view.clipsToBounds = YES;
    [self addSubview:view];
    
    UILabel *textLabel = TKTemplateLabel2([UIFont systemFontOfSize:11], HexColor(0xbebebe), note);
    textLabel.left = view.right + 3;
    textLabel.top = 1;
    [self addSubview:textLabel];
    view.centerY = textLabel.centerY;
    return textLabel.right;
}

- (UIView *)viewOfHeight:(float)height isLeft:(BOOL)isLeft {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, height)];
    view.backgroundColor = isLeft ? [HexColor(0x00afcf) colorWithAlphaComponent:0.3] : HexColor(0x00afcf);
    view.layer.cornerRadius = 2.5;
    view.clipsToBounds = YES;
    return view;
}

- (int)maxRows {
    float maxTemp = 35;
    for (NSArray *item in _datas) {
        maxTemp = MAX(maxTemp, [[item firstObject] floatValue]);
        maxTemp = MAX(maxTemp, [[item lastObject] floatValue]);
    }
    int maxInt = (int)maxTemp;
    if (maxInt % 5) {
        return (maxInt / 5 + 1);
    } else {
        return maxInt / 5;
    }
}

@end
