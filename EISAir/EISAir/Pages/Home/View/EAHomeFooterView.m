//
//  EAHomeFooterView.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAHomeFooterView.h"

#define kHorPadding 15

@interface EAHomeFooterView ()

@property(nonatomic , strong) UILabel *tipLabel;
@property(nonatomic , strong) UIImageView *eamImageView;
@property(nonatomic , strong) UILabel *eamLabel;
@property(nonatomic , strong) UIImageView *xingyunImageView;
@property(nonatomic , strong) UILabel *xingyunLabel;
@property(nonatomic , strong) UIButton *eamButton;
@property(nonatomic , strong) UIButton *xingyunButton;

@end

@implementation EAHomeFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _tipLabel.font = SYS_FONT(14);
        _tipLabel.textColor = HexColor(0x4a4a4a);
        _tipLabel.text = @"相关产品";
        [_tipLabel sizeToFit];
        
        _eamImageView = [self icon:@"set_eam_air"];
        _eamLabel = [self label:@"EAM Air"];
        
        _xingyunImageView = [self icon:@"set_xing_air"];
        _xingyunLabel = [self label:@"行云 Air"];
        
        
        [self addSubview:_tipLabel];
        
        self.eamButton = [self button];
        self.xingyunButton = [self button];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(UIImageView *)icon:(NSString  *)imgName
{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:SYS_IMG(imgName)];
    imgView.frame = CGRectMake(0, 0, 45, 45);
    [self addSubview:imgView];
    
    return imgView;
}

-(UILabel *)label:(NSString *)tip
{
    UILabel *l = [[UILabel alloc]init];
    l.textAlignment = NSTextAlignmentCenter;
    l.font = SYS_FONT(12);
    l.textColor = HexColor(0x999999);
    l.text = tip;
    [l sizeToFit];
    [self addSubview:l];
    
    return l;
}

-(UIButton *)button
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

-(void)onTapAction:(UIButton *)button
{
    NSString* appstoreUrlString = nil;
    if (button == _eamButton) {
            appstoreUrlString = @"itms-apps://itunes.apple.com/cn/app/id1129680275?mt=8";//
    }else{
            appstoreUrlString = @"itms-apps://itunes.apple.com/cn/app/id1195778908?mt=8";//
    }
    
    
    NSURL* url = [NSURL URLWithString:appstoreUrlString];
    
    if([[UIApplication sharedApplication]canOpenURL:url])
        
    {
        
        [[UIApplication sharedApplication]openURL:url];
        
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _tipLabel.left = kHorPadding;
    
    _eamImageView.left = kHorPadding;
    _eamImageView.top = _tipLabel.bottom + 18;
    
    _eamLabel.top = _eamImageView.bottom + 14;
    _eamLabel.centerX = _eamImageView.centerX;
    
    _xingyunImageView.left = _eamImageView.right + 21;
    _xingyunImageView.top = _eamImageView.top;
    
    _xingyunLabel.top = _eamLabel.top;
    _xingyunLabel.centerX = _xingyunImageView.centerX;
    
    _eamButton.frame = CGRectMake(kHorPadding, _eamImageView.top, _eamImageView.width, _eamLabel.bottom - _eamImageView.top);
    
    _xingyunButton.frame = CGRectMake(_xingyunImageView.left, _xingyunImageView.top, _xingyunImageView.width, _xingyunLabel.bottom - _xingyunImageView.top);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
