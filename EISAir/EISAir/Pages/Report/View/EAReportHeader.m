//
//  EAReportHeader.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportHeader.h"

@interface EAReportHeaderItem : UIControl {
    UIImageView *_iconIV;
    UILabel *_titleLb;
    UILabel *_detailLb;
}

@end

@implementation EAReportHeaderItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 55, 55)];
        _iconIV.centerX = self.width * .5;
        [self addSubview:_iconIV];
        
        _titleLb = TKTemplateLabel([UIFont systemFontOfSize:15], [UIColor blackColor]);
        _titleLb.frame = CGRectMake(0, _iconIV.bottom + 6, self.width, 22);
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLb];
        
        _detailLb = TKTemplateLabel([UIFont systemFontOfSize:11], HexColor(0x666666));
        _detailLb.frame = CGRectMake(0, _titleLb.bottom, self.width, 14);
        _detailLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_detailLb];
    }
    return self;
}

- (void)setModel:(NSDictionary *)model {
    _iconIV.image = [UIImage imageNamed:model[@"pic"]];
    _titleLb.text = model[@"title"];
    _detailLb.text = model[@"detail"];
}

@end

@implementation EAReportHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setModel:(NSArray *)model {
    float interval = self.width /  model.count;
    float left = 0;
    for (int i = 0; i < model.count; ++i) {
        int tag = 1000 + i;
        EAReportHeaderItem *item = [self viewWithTag:tag];
        if (!item) {
            item = [[EAReportHeaderItem alloc] initWithFrame:CGRectMake(left, 0, interval, self.height)];
            item.tag = tag;
            [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:item];
            if (i) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LINE_HEIGHT, self.height)];
                line.backgroundColor = LINE_COLOR;
                [item addSubview:line];
            }
        }
        [item setModel:model[i]];
        left = item.right;
    }
}

- (void)itemClicked:(EAReportHeaderItem *)item {
    if (self.clickedBlock) {
        self.clickedBlock(item.tag - 1000);
    }
}

@end
