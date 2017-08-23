//
//  EAAddRecordView.m
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAddRecordView.h"
#import "NSDate+Category.h"
#import "UIButton+EdgeInsets.h"
#import "EAAddRecordVC.h"

static const int kTagOfRecord = 178939;

@implementation EAAddRecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.97];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    // date
    NSDate *currentDate = [NSDate date];
    
    UILabel *dayLabel = TKTemplateLabel2([UIFont systemFontOfSize:50], HexColor(0x666666), @([currentDate day]).description);
    dayLabel.left = 30;
    dayLabel.top = 80;
    [self addSubview:dayLabel];
    
    UILabel *weakLabel = TKTemplateLabel2([UIFont systemFontOfSize:18], dayLabel.textColor, [TKCommonTools weekOfDate:currentDate WithType:TKDateThreeWorldsLength]);
    weakLabel.left = dayLabel.right + 10;
    weakLabel.top = dayLabel.top + 9;
    [self addSubview:weakLabel];
    
    UILabel *ymLabel = TKTemplateLabel2([UIFont systemFontOfSize:14], dayLabel.textColor, [TKCommonTools dateStringWithFormat:@"MM/YYYY" date:currentDate]);
    ymLabel.left = weakLabel.left;
    ymLabel.top = weakLabel.bottom + 4;
    [self addSubview:ymLabel];
    
    // record btns
    float side = 30;
    float width = 75;
    float interval = (SCREEN_WIDTH - side * 2 - width * 3) * .5;
    NSArray *btns = @[
                      @[@"add_icon1", @"文本记录"],
                      @[@"add_icon2", @"数值记录"],
                      @[@"add_icon3", @"关系记录"],
                      ];
    float left = side;
    for (int i = 0; i < btns.count; i++) {
        NSArray *btnInfo = btns[i];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(left, self.height - 220, width, 100)];
        [btn setImage:[UIImage imageNamed:[btnInfo firstObject]] forState:UIControlStateNormal];
        UILabel *label = TKTemplateLabel2([UIFont systemFontOfSize:14], HexColor(0x666666), [btnInfo lastObject]);
        label.bottom = btn.height - 2;
        label.centerX = btn.width * .5;
        [btn addSubview:label];
        [self addSubview:btn];
        btn.tag = i + 1000;
        btn.imageEdgeInsets = UIEdgeInsetsMake(-15, 0, 15, 0);
        [btn addTarget:self action:@selector(recordPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        left = btn.right + interval;
    }
    
    // add_close
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
    [closeBtn setImage:[UIImage imageNamed:@"add_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.bottom = self.height - 10;
    closeBtn.centerX = self.width * .5;
    [self addSubview:closeBtn];
}

- (void)recordPressed:(UIButton *)btn {
    NSInteger index = btn.tag - 1000;
    UIViewController *vc = [[EAAddRecordVC alloc] initWithType:index];
    vc.hidesBottomBarWhenPushed = YES;
    [[EABaseViewController currentNavigationController] pushViewController:vc animated:YES];
    [self close];
}

- (void)close {
    [UIView animateWithDuration:.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show {
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

+ (void)show {
    UIView *superview = [UIApplication sharedApplication].delegate.window;
    EAAddRecordView *view = [superview viewWithTag:kTagOfRecord];
    if (!view) {
        view = [[EAAddRecordView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.tag = kTagOfRecord;
        [superview addSubview:view];
        [view show];
    }
}

+ (void)close {
    UIView *superview = [UIApplication sharedApplication].delegate.window;
    EAAddRecordView *view = [superview viewWithTag:kTagOfRecord];
    [view close];
}

@end
