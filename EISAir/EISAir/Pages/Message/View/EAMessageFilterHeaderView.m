//
//  EAMessageFilterHeaderView.m
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageFilterHeaderView.h"

@interface EAMessageFilterHeaderView()

@property(nonatomic , strong) UIView *topLine;
@property(nonatomic , strong) UILabel *titleLabel;

@end

@implementation EAMessageFilterHeaderView

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SYS_FONT(14);
        _titleLabel.textColor = HexColor(0x666666);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _topLine.backgroundColor = HexColor(0xf5f5f5);
        [self addSubview:_topLine];
    }
    return _topLine;
}

-(void)updateTitle:(NSString *)title showTopLine:(BOOL)showTopline
{
    self.titleLabel.text = title;
    [_titleLabel sizeToFit];
    self.topLine.hidden = !showTopline;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.left = 16;
    _titleLabel.bottom = self.height - 2;
    _topLine.width = self.width;
}

@end
