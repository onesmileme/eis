//
//  EAKongJianHeader.m
//  EISAir
//
//  Created by iwm on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAKongJianHeader.h"

@implementation EAKongJianHeader {
    UIButton *_subscribeBtn;
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data subscribed:(BOOL)subscribed
{
    self = [super initWithFrame:frame];
    if (self) {
        __block float top = 15;
        [data enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *view = [self viewWithDic:obj];
            [self addSubview:view];
            view.top = top;
            top = view.bottom;
        }];
        
        self.height = top + 10;
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgImageView.image = [UIImage imageNamed:@"dingyue_bg_s"];
        bgImageView.frame = self.bounds;
        [self addSubview:bgImageView];
        [self insertSubview:bgImageView atIndex:0];
        
        _subscribeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 15, 55, 21)];
        _subscribeBtn.right = self.width - 25;
        [_subscribeBtn addTarget:self action:@selector(subscribeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_subscribeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_subscribeBtn setTitle:(subscribed ? @"已订阅" : @"订阅") forState:UIControlStateNormal];
        _subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _subscribeBtn.clipsToBounds = YES;
        _subscribeBtn.layer.cornerRadius = 2.0;
        _subscribeBtn.backgroundColor = HexColor(0xffb549);
        [self addSubview:_subscribeBtn];
    }
    return self;
}

- (UIView *)viewWithDic:(NSArray *)array {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(45, 0, SCREEN_WIDTH - 125, 20)];
    UILabel *kLabel = TKTemplateLabel2(SYS_FONT(12), [UIColor whiteColor], array.firstObject);
    UILabel *vLabel = TKTemplateLabel2(SYS_FONT(14), [UIColor whiteColor], array.lastObject);
    [view addSubview:kLabel];
    [view addSubview:vLabel];
    kLabel.centerY = vLabel.centerY = view.height * .5;
    vLabel.left = kLabel.right + 14;
    [vLabel setMaxRight:view.width];
    return view;
}

- (void)subscribeBtnClick {
//    if (self.subscribeClickBlock) {
//        self.subscribeClickBlock();
//    }
}

@end
