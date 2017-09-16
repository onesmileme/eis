//
//  EASubscribeHeaderView.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASubscribeHeaderView.h"
#import "UIImageView+Custom.h"
#import "UIImageView+WebCache.h"

@implementation EASubscribeHeaderView {
    UIImageView *_iconImageView;
    UIButton *_subscribeBtn;
    UIButton *_countBtn;
}

- (instancetype)initWithIcon:(NSString *)icon
              subscribeCount:(NSUInteger)subscribeCount
                  subscribed:(BOOL)subscribed {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 142)];
    if (self) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgImageView.image = [UIImage imageNamed:@"dingyue_bg_s"];
        [self addSubview:bgImageView];
        
        _iconImageView = [UIImageView roundPhotoWithFrame:CGRectMake(0, 0, 70, 70)];
        _iconImageView.centerX = self.width * .5;
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:icon]];
        [self addSubview:_iconImageView];
        
        _subscribeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _iconImageView.bottom + 12, 55, 21)];
        _subscribeBtn.centerX = _iconImageView.centerX;
        [_subscribeBtn addTarget:self action:@selector(subscribeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_subscribeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_subscribeBtn setTitle:(subscribed ? @"已订阅" : @"订阅") forState:UIControlStateNormal];
        _subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _subscribeBtn.clipsToBounds = YES;
        _subscribeBtn.layer.cornerRadius = 2.0;
        _subscribeBtn.backgroundColor = HexColor(0xffb549);
        [self addSubview:_subscribeBtn];
        
        NSString *countString = [NSString stringWithFormat:@"已有%d人订阅此栏目", (int)subscribeCount];
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _subscribeBtn.bottom + 7, self.width, 18)];
        [_countBtn addTarget:self action:@selector(countBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_countBtn setTitle:countString forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_countBtn.titleLabel sizeToFit];
        [self addSubview:_countBtn];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_arrow"]];
        arrowImageView.left = (_countBtn.titleLabel.width + _countBtn.width) * .5 + 5;
        arrowImageView.centerY = _countBtn.height * .5;
        [_countBtn addSubview:arrowImageView];
    }
    return self;
}

- (void)subscribeBtnClick {
    if (self.subscribeClickBlock) {
        self.subscribeClickBlock();
    }
}

- (void)countBtnClick {
    if (self.subscriberClickBlock) {
        self.subscriberClickBlock();
    }
}

@end
