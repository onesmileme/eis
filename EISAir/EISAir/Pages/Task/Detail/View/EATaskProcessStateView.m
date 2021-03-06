//
//  EATaskProcessStateView.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskProcessStateView.h"

#define kNormColor HexColor(0xb0b0b0)
#define kNowColor  HexColor(0x00b0ce)
#define kHorPadding 22
#define kCircelWidth 16

@interface EATaskProcessStateView()

@property(nonatomic , strong) UILabel *beginLabel;
@property(nonatomic , strong) UILabel *waitLabel;
@property(nonatomic , strong) UILabel *doingLabel;
@property(nonatomic , strong) UILabel *doneLabel;
@end

@implementation EATaskProcessStateView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupItems];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupItems];
    }
    return self;
}

-(void)setupItems
{
    _beginLabel = [self label];
    _waitLabel  = [self label];
    _doingLabel = [self label];
    _doneLabel  = [self label];
    
    _beginLabel.text = @"发出";
    _waitLabel.text = @"待执行";
    _doingLabel.text = @"执行中";
    _doneLabel.text = @"已执行";
    
    NSArray *labels = @[_beginLabel,_waitLabel,_doingLabel,_doneLabel];
    for (UILabel *l in labels) {
        [l sizeToFit];
        [self addSubview:l];
    }
}

-(UILabel *)label
{
    UILabel *label = [[UILabel alloc] init];
    label.font = SYS_FONT(13);
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_state == EATaskStatusInvalid) {
        NSArray *labels = @[_beginLabel,_waitLabel,_doingLabel];
        CGFloat perlength = (self.width - 2*kHorPadding-kCircelWidth)/3;
        for (int i = 0 ; i < labels.count; i++) {
            UILabel *l = labels[i];
            
            l.bottom = self.height;
            CGFloat centerX = kHorPadding+i*perlength+kCircelWidth/2;
            l.centerX = centerX;
        }
        _doingLabel.text = @"已失效";
        _doneLabel.hidden = true;
    }else{
        
        NSArray *labels = @[_beginLabel,_waitLabel,_doingLabel,_doneLabel];
        CGFloat perlength = (self.width - 2*kHorPadding-kCircelWidth)/3;
        for (int i = 0 ; i < labels.count; i++) {
            UILabel *l = labels[i];
            
            l.bottom = self.height;
            CGFloat centerX = kHorPadding+i*perlength+kCircelWidth/2;
            l.centerX = centerX;
        }
        _doingLabel.text = @"执行中";
        _doneLabel.hidden = false;
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *lineColor = RGBA(0x00, 0xb0, 0xce, 0.2);
    //draw line
        
    CGContextSetLineWidth(context, 0.5);
    CGFloat centerY = CGRectGetHeight(rect) - 40-kCircelWidth/3;
    CGFloat perlength = (CGRectGetWidth(rect) - 2*kHorPadding - kCircelWidth)/3;
    
    if (_state == EATaskStatusInvalid) {
        
        lineColor = HexColor(0xd8d8d8);
        CGContextMoveToPoint(context, kHorPadding, centerY);
        CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
        CGFloat now = perlength*(2)+kHorPadding;
        CGContextAddLineToPoint(context, now, centerY);
        CGContextStrokePath(context);
        //draw circle
        UIBezierPath *path = nil;
        if (_state >= EATaskStatusWait) {
            CGContextSetFillColorWithColor(context, [lineColor CGColor]);
            for (int i = 0 ; i <= 2; i++) {
                path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kHorPadding+i*perlength, centerY-8, kCircelWidth, kCircelWidth)];
                [path fill];
            }
        }        
    }else{
        
        CGContextMoveToPoint(context, kHorPadding, centerY);

        if (_state >= EATaskStatusWait) {
            CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
            CGFloat now = perlength*(_state+1)+kHorPadding;
            CGContextAddLineToPoint(context, now, centerY);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, now, centerY);
        }
        CGContextAddLineToPoint(context, CGRectGetWidth(rect)-kHorPadding, centerY);
        CGContextSetStrokeColorWithColor(context, [HexColor(0xd8d8d8) CGColor]);
        CGContextStrokePath(context);
        
        //draw circle
        UIBezierPath *path = nil;
        //issue state
        CGContextSetFillColorWithColor(context, [lineColor CGColor]);
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kHorPadding, centerY-8, kCircelWidth, kCircelWidth)];
        [path fill];

        
        //past        
        if (_state >= EATaskStatusWait) {
            CGContextSetFillColorWithColor(context, [lineColor CGColor]);
            for (int i = 0 ; i <= _state; i++) {
                path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kHorPadding+(i+1)*perlength, centerY-8, kCircelWidth, kCircelWidth)];
                [path fill];
            }
        }
        //now
        CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
        CGContextSetFillColorWithColor(context, [HexColor(0x00b0ce) CGColor]);
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kHorPadding+(_state+1)*perlength-(25-kCircelWidth)/2, centerY-12.5, 25, 25)];
        [path fill];
        path.lineWidth = 1;
        [path stroke];
        
        //future
        if (_state <= EATaskStatusInvalid) {
            CGContextSetFillColorWithColor(context, [HexColor(0xd8d8d8) CGColor]);
            for (int i = _state+2 ; i <= EATaskStatusInvalid; i++) {
                path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kHorPadding+i*perlength, centerY-8, 16, 16)];
                [path fill];
            }
        }
    }
}


@end
