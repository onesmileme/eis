//
//  EAProjectToolbar.m
//  EISAir
//
//  Created by chunhui on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAProjectToolbar.h"

@interface EAProjectToolbar ()

@property(nonatomic , strong) UIButton *preButton;
@property(nonatomic , strong) UIButton *nextButton;
@property(nonatomic , strong) UIButton *doneButton;

@end

@implementation EAProjectToolbar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    _preButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_preButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_preButton setImage:SYS_IMG(@"set_arrow_up") forState:UIControlStateNormal];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_nextButton setImage:SYS_IMG(@"set_arrow_down") forState:UIControlStateNormal];
    
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    _doneButton.titleLabel.font = SYS_FONT(15);
    [_doneButton setTitleColor:HexColor(0x007aff) forState:UIControlStateNormal];
    
    
    [self addSubview:_preButton];
    [self addSubview:_nextButton];
    [self addSubview:_doneButton];
    
    self.backgroundColor = HexColor(0xf0f1f2);
}


-(void)changeAction:(id)sender
{
    if (sender == _preButton) {
        self.preBlock();
    }else{
        self.nextBlock();
    }
}

-(void)doneAction:(id)sender
{
    self.doneBlock();
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _preButton.frame = CGRectMake(13, (self.height-20)/2, 30, 20);
    
    _nextButton.frame = CGRectMake(_preButton.right+10, _preButton.top, 30, 20);
    
    _doneButton.frame = CGRectMake(self.width - 50, (self.height - 20)/2, 40, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
