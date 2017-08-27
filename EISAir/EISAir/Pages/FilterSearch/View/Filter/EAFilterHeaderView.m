//
//  EAFilterHeaderView.m
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAFilterHeaderView.h"

@interface EAFilterHeaderView()

@property(nonatomic , strong) UIView *topLine;
@property(nonatomic , strong) UILabel *titleLabel;

@property(nonatomic , strong) UIImageView *indicatorImageView;
@property(nonatomic , strong) UITapGestureRecognizer *gestureRecognizer;

@end

@implementation EAFilterHeaderView

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

-(UIImageView *)indicatorImageView
{
    if (!_indicatorImageView) {
        _indicatorImageView = [[UIImageView alloc]initWithImage:SYS_IMG(@"icon_arrow_r")];
        [self addSubview:_indicatorImageView];
    }
    return _indicatorImageView;
}

-(UITapGestureRecognizer *)gestureRecognizer
{
    if (!_gestureRecognizer) {
        _gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)];
        [self addGestureRecognizer:_gestureRecognizer];
    }
    return _gestureRecognizer;
}

-(void)onTapAction:(UITapGestureRecognizer *)gesture
{
    if (_tapBlock) {
        CGPoint location = [gesture locationInView:self];
        CGRect bound = CGRectMake(_titleLabel.left, _titleLabel.top, self.width, _titleLabel.height);
        if (CGRectContainsPoint(bound, location)) {
            _tapBlock(self);
        }
    }
}

-(void)updateTitle:(NSString *)title showTopLine:(BOOL)showTopline showIndicator:(BOOL)showIndicator
{
    self.titleLabel.text = title;
    [_titleLabel sizeToFit];
    self.topLine.hidden = !showTopline;
    
    if (showIndicator) {
        self.indicatorImageView.hidden = false;
        self.gestureRecognizer.enabled = true;
    }else{
        self.indicatorImageView.hidden = true;
        _gestureRecognizer.enabled = false;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.left = 16;
    _titleLabel.bottom = self.height - 2;
    _topLine.width = self.width;
    _indicatorImageView.right = self.width - 8;
    _indicatorImageView.centerY = _titleLabel.centerY;
}

@end
