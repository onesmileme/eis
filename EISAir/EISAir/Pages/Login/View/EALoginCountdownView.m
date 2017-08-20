//
//  EALoginCountdownView.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EALoginCountdownView.h"

@interface EALoginCountdownView ()

@property(nonatomic , strong) UILabel *countDownlabel;
@property(nonatomic , weak) NSTimer *timer;
@property(nonatomic , assign) NSInteger count;
@end

@implementation EALoginCountdownView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _countDownlabel = [[UILabel alloc]initWithFrame:self.bounds];
        _countDownlabel.font = SYS_FONT(12);
        _countDownlabel.textColor = [UIColor whiteColor];
        _countDownlabel.textAlignment = NSTextAlignmentCenter;
        
        self.backgroundColor = HexColor(0xe9e9e9);
        [self addSubview:_countDownlabel];
    }
    return self;
}

-(void)startCount
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _count = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:true];
    _countDownlabel.text = [NSString stringWithFormat:@"%ldS",_count];
}

-(void)onTimer:(NSTimer *)t
{
    _count--;
    if (_count <= 0 ) {
        if (_countdownBlock) {
            _countdownBlock();
        }
        return;
    }
    _countDownlabel.text = [NSString stringWithFormat:@"%ldS",_count];
}

-(void)stop
{
    [_timer invalidate];
    _timer = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
