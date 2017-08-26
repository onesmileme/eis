//
//  EAMsgSearchFilterHeaderView.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgSearchFilterHeaderView.h"

@interface EAMsgSearchFilterHeaderView ()

@property(nonatomic , strong) UIImageView *checkView;
@property(nonatomic , strong) UILabel *titleLabel;

@end

@implementation EAMsgSearchFilterHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *nimg = SYS_IMG(@"message_select");
        UIImage *simg = SYS_IMG(@"message_select_pre");
        _checkView = [[UIImageView alloc]initWithImage:nimg highlightedImage:simg];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)];
        [_checkView addGestureRecognizer:gesture];
        _checkView.userInteractionEnabled = true;
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SYS_FONT(13);
        _titleLabel.textColor = HexColor(0x666666);
        _titleLabel.text = @"全选";
        [_titleLabel sizeToFit];
        gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)];
        [_titleLabel addGestureRecognizer:gesture];

        
        [self addSubview:_checkView];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)onTapAction:(UITapGestureRecognizer *)gesture
{
    _checkView.highlighted = !_checkView.highlighted;
    if (_checkBlock) {
        _checkBlock(_checkView.highlighted);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _checkView.frame = CGRectMake(12, (self.height - 15)/2, 15, 15);
    
    _titleLabel.left = 36;
    _titleLabel.centerY = _checkView.centerY;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
