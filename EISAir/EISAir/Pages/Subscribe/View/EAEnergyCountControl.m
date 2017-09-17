//
//  EAEnergyCountControl.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAEnergyCountControl.h"

@implementation EAEnergyCountControl {
    UILabel *_titleLabel;
    UILabel *_countLabel;
    UIView *_countView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = TKTemplateLabel([UIFont systemFontOfSize:12], HexColor(0x444444));
        [self addSubview:_titleLabel];
        _countLabel = TKTemplateLabel([UIFont systemFontOfSize:12], HexColor(0x444444));
        [self addSubview:_countLabel];
        _countView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 12)];
        _countView.layer.cornerRadius = 4.0;
        _countView.clipsToBounds = YES;
        [self addSubview:_countView];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_r"]];
        [arrowView sizeToFit];
        arrowView.right = self.width - 15;
        arrowView.centerY = self.height * .5;
        [self addSubview:arrowView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - LINE_HEIGHT, self.width, LINE_HEIGHT)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
    }
    return self;
}

- (void)updateModel:(NSDictionary *)dict {
    _titleLabel.text = dict[@"title"];
    _countLabel.text = dict[@"detail"];
    _countView.width = [dict[@"width"] intValue];
    _countView.backgroundColor = dict[@"color"];
    
    [_titleLabel sizeToFit];
    [_countLabel sizeToFit];
    
    _titleLabel.left = _countView.left = 15;
    _titleLabel.top = 9;
    _countView.top = _titleLabel.bottom + 5;
    _countLabel.left = _countView.right + 15;
    _countLabel.centerY = _countView.centerY;
}

@end
