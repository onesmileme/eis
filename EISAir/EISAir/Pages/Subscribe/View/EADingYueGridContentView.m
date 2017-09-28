//
//  EADingYueGridContentView.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EADingYueGridContentView.h"
#import "EADingYueGridView.h"

static const int kTag = 1000;

@implementation EADingYueGridContentView

- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollsToTop = NO;
        self.backgroundColor = [UIColor whiteColor];
        float top = 12;
        for (int i = 0; i < datas.count; ++i) {
            NSDictionary *dic = datas[i];
            EADingYueGridView *view = [[EADingYueGridView alloc] initWithTitle:dic[@"title"]
                                                                         items:dic[@"items"]];
            view.subscribed = [dic[@"subscribed"] boolValue];
            view.top = top;
            view.tag = kTag + i;
            weakify(self);
            view.subscribeBlock = ^(EADingYueGridView *aview) {
                strongify(self);
                if (self.subscribeBlock) {
                    self.subscribeBlock(self, dic);
                }
            };
            view.itemPressedBlock = ^(EADingYueGridView *aview, NSUInteger index, NSDictionary *data) {
                strongify(self);
                if (self.itemPressedBlock) {
                    self.itemPressedBlock(self, data, i, index);
                }
            };
            [self addSubview:view];
            
            top = view.bottom + 12;
        }
        self.contentSize = CGSizeMake(self.width, MAX(self.height, top));
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.contentSize = CGSizeMake(self.width, MAX(self.height, self.contentSize.height));
}

@end
