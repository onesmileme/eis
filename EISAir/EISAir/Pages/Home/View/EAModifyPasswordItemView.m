//
//  EAModifyPasswordItemView.m
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAModifyPasswordItemView.h"

@implementation EAModifyPasswordItemView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    _tipLabel = [[UILabel alloc]init];
    _titleLabel = [[UILabel alloc]init];
    
    _tipLabel.textColor = HexColor(0xff6663);
    _titleLabel.textColor = HexColor(0x9b9b9b);
    
    _titleLabel.font = SYS_FONT(14);
    _tipLabel.font = SYS_FONT(14);
    
    _textField = [[UITextField alloc]init];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.secureTextEntry = true;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.backgroundColor = [UIColor whiteColor];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    leftView.backgroundColor = [UIColor clearColor];
    _textField.leftView = leftView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    
    [self addSubview:_titleLabel];
    [self addSubview:_tipLabel];
    [self addSubview:_textField];
    
    self.backgroundColor = [UIColor clearColor];
}

-(void)showSecure:(BOOL)secure
{
    _textField.secureTextEntry = secure;
}

-(void)updateTitle:(NSString *)title
{
    self.titleLabel.text = title;
    [_titleLabel sizeToFit];
    [self setNeedsLayout];
}
-(void)updateTip:(NSString *)tip
{
    self.tipLabel.text = tip;
    [_tipLabel sizeToFit];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _textField.frame = CGRectMake(0, self.height-50, self.width, 50);
    
    _titleLabel.left = 15;
    _titleLabel.bottom = _textField.top -9;
    
    
    _tipLabel.right = self.width - 10;
    _tipLabel.centerY = _titleLabel.centerY;
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
