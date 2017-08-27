//
//  EATaskActionSheet.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskActionSheet.h"

@interface EATaskActionSheet()

@property(nonatomic , strong) UIView *panel;
@property(nonatomic , strong) UILabel *titleLabel;
@property(nonatomic , strong) UIButton *confirmButton;
@property(nonatomic , strong) UIButton *cancelButton;

@end

@implementation EATaskActionSheet

-(instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.panel];
        self.backgroundColor = RGBA(0x4a, 0x4a, 0x4a, 0.6);
    }
    return self;
}

-(UIView *)panel
{
    if (!_panel) {
        _panel = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 204)];
        _panel.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SYS_FONT(15);
        _titleLabel.textColor = HexColor(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"确定拒绝任务?";
        
        [_titleLabel sizeToFit];
        _titleLabel.center = CGPointMake(self.width/2, 20+_titleLabel.height/2);
        
        UIImage *img = SYS_IMG(@"task_btn_1");
        _confirmButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundImage:img forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(10, _titleLabel.bottom+20, _panel.width - 20, 50);
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        img = SYS_IMG(@"task_btn_2");
        [_cancelButton setBackgroundImage:img forState:UIControlStateNormal];
        _cancelButton.frame = CGRectMake(10, _confirmButton.bottom+12, _panel.width-20, 50);
        
        [_panel addSubview:_titleLabel];
        [_panel addSubview:_confirmButton];
        [_panel addSubview:_cancelButton];
        
    }
    return _panel;
}

-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    [window addSubview:self];
    
    _panel.top = self.height;
    [UIView animateWithDuration:0.3 animations:^{
        _panel.bottom = self.height;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _panel.top = self.height;
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)confirmAction:(id)sender
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self hide];
}

-(void)cancelAction:(id)sender
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self hide];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
