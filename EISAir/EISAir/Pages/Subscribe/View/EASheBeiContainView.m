//
//  EASheBeiContainView.m
//  EISAir
//
//  Created by DoubleHH on 2017/10/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASheBeiContainView.h"
#import "EADingYueDefines.h"

@interface EASheBeiContainItemView : UIControl

@end

@implementation EASheBeiContainItemView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text state:(EASheBeiState)state {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4;
        UIColor *color = HexColor(0x28cfc1);
        UIColor *bgcolor = [HexColor(0x28cfc1) colorWithAlphaComponent:0.2];
        if (EASheBeiStateClose == state) {
            color = HexColor(0x333333);
            bgcolor = HexColor(0xececec);
        } else if (EASheBeiStateBug == state) {
            color = HexColor(0xff6663);
            bgcolor = [color colorWithAlphaComponent:0.2];
        }
        self.backgroundColor = bgcolor;
        UILabel *label = TKTemplateLabel2(SYS_FONT(12), color, text);
        if (label.width > self.width) {
            label.width = self.width;
        }
        label.center = CGPointMake(self.width * .5, self.height * .5);
    }
    return self;
}

@end

@implementation EASheBeiContainView {
    NSArray *_items;
}

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items {
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    self = [super initWithFrame:frame];
    if (self) {
        _items = items;
        
        UILabel *titleLabel = TKTemplateLabel2(SYS_FONT(15), HexColor(0x333333), title);
        titleLabel.left = 15;
        [self addSubview:titleLabel];
        
        __block float top = titleLabel.bottom + 12;
        float width = (self.width - 45) * .5;
        __block height = top;
        [items enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            float x = idx % 2 ? (width + 30) : 15;
            EASheBeiContainItemView *itemView = [[EASheBeiContainItemView alloc] initWithFrame:CGRectMake(x, top, width, 32)
                                                                                          text:obj[@"text"]
                                                                                         state:[obj[@"state"] intValue]];
            itemView.tag = idx + 1000;
            [itemView addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:itemView];
            if (idx % 2) {
                top = itemView.bottom + 10;
            }
        }];
        self.height = top - 10;
    }
    return self;
}

- (void)itemClicked:(EASheBeiContainItemView *)view {
    NSInteger index = view.tag - 1000;
    if (index > _items.count - 1 || !self.clickedBlock) {
        return;
    }
    self.clickedBlock(_items[index]);
}

@end
