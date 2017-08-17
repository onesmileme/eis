//
//  EALoginTipAlertView.m
//  FunApp
//
//  Created by chunhui on 2016/8/12.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EALoginTipAlertView.h"

@interface EALoginTipAlertView ()

@property(nonatomic , strong) UIView *bgView;
@property(nonatomic , strong) UILabel *titleLabel;
@property(nonatomic , strong) UIImageView *checkImageView;
@property(nonatomic , strong) UILabel *protocolLabel;
@property(nonatomic , strong) UIButton *loginButton;

@property(nonatomic , strong) void (^loginBlock)();
@property(nonatomic , strong) void (^showProtocolBlock)();

@end

@implementation EALoginTipAlertView

+(instancetype)loginTipAlertView:(void(^)())loginBlock showProtocol:(void(^)())showProtocolBlock
{
    EALoginTipAlertView *view = [[EALoginTipAlertView alloc]initWithFrame:CGRectZero];
    view.loginBlock = loginBlock;
    view.showProtocolBlock = showProtocolBlock;
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    frame = [[UIScreen mainScreen]bounds];
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame) - 100, 180)];
        _bgView.backgroundColor = RGB(245, 245, 245);
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = true;
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SYS_FONT(17);
        _titleLabel.textColor = HexColor(0x030303);
        _titleLabel.text = @"微信登录";
        [_titleLabel sizeToFit];
        
        _titleLabel.centerX = _bgView.width/2;
        _titleLabel.top = 26;
        
        UIImage *image = [UIImage imageNamed:@"icon_checked"];
        UIImage *unimage = [UIImage imageNamed:@"icon_unchecked"];
        _checkImageView = [[UIImageView alloc]initWithImage:unimage highlightedImage:image];
        
        NSMutableAttributedString *protocol = [[NSMutableAttributedString alloc]initWithString:@"同意用户协议和隐私规范"];
        [protocol addAttributes:@{NSUnderlineColorAttributeName:[UIColor blueColor]} range:NSMakeRange(0, protocol.length)];
        _protocolLabel = [[UILabel alloc]init];
        _protocolLabel.font = SYS_FONT(13);
        _protocolLabel.textColor = _titleLabel.textColor;
        _protocolLabel.attributedText = protocol;
        [_protocolLabel sizeToFit];
        _protocolLabel.top = _titleLabel.bottom + 35;
        _protocolLabel.centerX = _titleLabel.centerX;
        UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(0, _protocolLabel.height - 0.5, _protocolLabel.width, 0.5)];
        underLine.backgroundColor = [UIColor blueColor];
        [_protocolLabel addSubview:underLine];
        
        _checkImageView.right = _protocolLabel.left - 20;
        _checkImageView.centerY = _protocolLabel.centerY;
        
        UIColor *color = HexColor(0x0076ff);
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.titleLabel.font = SYS_FONT(17);
        [cancelButton setTitleColor:color forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.frame = CGRectMake(0, _bgView.height - 43, _bgView.width/2, 43);
        [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.titleLabel.font = cancelButton.titleLabel.font;
        [loginButton setTitleColor:color forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton setTitle:@"登录" forState:UIControlStateDisabled];
        [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        loginButton.frame = CGRectMake(_bgView.width/2, _bgView.height - 43, _bgView.width/2, 43);
        
        UIView *horSplitLine = [[UIView alloc]initWithFrame:CGRectMake(0, cancelButton.top - 1 , _bgView.width , 1)];
        horSplitLine.backgroundColor = RGB(196, 196, 196);
        
        UIView *verSplitLine = [[UIView alloc]initWithFrame:CGRectMake(cancelButton.right, cancelButton.top, 1, cancelButton.height)];
        verSplitLine.backgroundColor = horSplitLine.backgroundColor;
        
        [_bgView addSubview:_titleLabel];
        [_bgView addSubview:_checkImageView];
        [_bgView addSubview:_protocolLabel];
        [_bgView addSubview:cancelButton];
        [_bgView addSubview:loginButton];
        
        [_bgView addSubview:verSplitLine];
        [_bgView addSubview:horSplitLine];
        
        self.loginButton = loginButton;
        
        UITapGestureRecognizer *gesuture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkTapAction:)];
        _checkImageView.userInteractionEnabled = true;
        [_checkImageView addGestureRecognizer:gesuture];
        _checkImageView.highlighted = true;
        
        gesuture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showProtocolAction:)];
        [_protocolLabel addGestureRecognizer:gesuture];
        _protocolLabel.userInteractionEnabled = true;
        
        [self addSubview:_bgView];
        _bgView.center = CGPointMake(self.width/2, self.height/2);
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }
    return self;
}

-(void)showIn:(UIView *)view
{
    if (!view) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    [view addSubview:self];
}

-(void)hide
{
    [self removeFromSuperview];
}

-(void)cancelAction:(id)sender
{
    [self hide];
}

-(void)loginAction:(id)sender
{
    if (_loginBlock) {
        _loginBlock();
    }
    [self hide];
}

-(void)checkTapAction:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        _checkImageView.highlighted = !_checkImageView.highlighted;
        _loginButton.enabled = _checkImageView.highlighted;
    }

}

-(void)showProtocolAction:(id)sender
{
    if (_showProtocolBlock) {
        _showProtocolBlock();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
