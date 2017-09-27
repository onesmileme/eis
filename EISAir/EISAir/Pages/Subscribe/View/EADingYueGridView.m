//
//  EADingYueGridView.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EADingYueGridView.h"

@implementation EADingYueGridView {
    UIButton *subscribeButton;
}

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items {
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = TKTemplateLabel2([UIFont systemFontOfSize:15], HexColor(0x4a4a4a), title);
        titleLabel.left = 15;
        [self addSubview:titleLabel];
        
        subscribeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 21)];
        [subscribeButton addTarget:self action:@selector(subscribe) forControlEvents:UIControlEventTouchUpInside];
        [subscribeButton setTitleColor:HexColor(0xa1a1a1) forState:UIControlStateNormal];
        [subscribeButton setTitleColor:HexColor(0xffb549) forState:UIControlStateHighlighted];
        [subscribeButton setTitleColor:HexColor(0xffb549) forState:UIControlStateSelected];
        [subscribeButton setTitle:@"订阅" forState:UIControlStateNormal];
        subscribeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        subscribeButton.clipsToBounds = YES;
        subscribeButton.layer.cornerRadius = 2.0;
        subscribeButton.layer.borderColor = HexColor(0xa1a1a1).CGColor;
        subscribeButton.layer.borderWidth = LINE_HEIGHT;
        [self addSubview:subscribeButton];
        subscribeButton.right = self.width - titleLabel.left;
        
        float left = titleLabel.left;
        float top = titleLabel.bottom + 10;
        float interval = 6;
        float width = (self.width - 2 * left - 3 * interval) / 4;
        float selfHeight = 0;
        for (int i = 0; i < items.count; ++i) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(left, top, width, 35)];
            [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:HexColor(0x444444) forState:UIControlStateNormal];
            [button setTitle:items[i][@"name"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.clipsToBounds = YES;
            button.layer.cornerRadius = 2.0;
            button.tag = 1000 + i;
            button.backgroundColor = HexColor(0xf7f7f7);
            [self addSubview:button];
            
            if ((i + 1) % 4) {
                left = button.right + interval;
            } else {
                left = titleLabel.left;
                top = button.bottom + interval;
            }
            selfHeight = MAX(selfHeight, button.bottom);
        }
        self.height = selfHeight;
    }
    return self;
}

- (void)setSubscribed:(BOOL)subscribed {
    _subscribed = subscribed;
    subscribeButton.selected = subscribed;
    [subscribeButton setTitle:subscribed ? @"已订阅" : @"订阅" forState:UIControlStateNormal];
    subscribeButton.layer.borderColor = HexColor(subscribed ? 0xffb549 : 0xa1a1a1).CGColor;
}

- (void)itemPressed:(UIButton *)btn {
    
}

- (void)subscribe {
    if (self.subscribeBlock) {
        self.subscribeBlock(self);
    }
}

@end
