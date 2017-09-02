//
//  EADingYueRenVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EADingYueRenVC.h"

static const int kItemWidth = 40;
static const int kItemInterval = 15;

@interface EADingYueRenItem : UIControl

@end

@implementation EADingYueRenItem

- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon name:(NSString *)name {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemWidth)];
        imageView.layer.cornerRadius = imageView.height * .5;
        imageView.clipsToBounds = YES;
        imageView.centerX = self.width * .5;
        [imageView sd_setImageWithURL:[NSURL URLWithString:icon]];
        [self addSubview:imageView];
        
        UILabel *nameLabel = TKTemplateLabel2([UIFont systemFontOfSize:12], HexColor(0x4a4a4a), name);
        nameLabel.width = MAX(nameLabel.width, self.width);
        nameLabel.centerX = imageView.centerX;
        nameLabel.top = imageView.bottom + 3;
        [self addSubview:nameLabel];
    }
    return self;
}

@end

@interface EADingYueRenVC ()

@end

@implementation EADingYueRenVC {
    UIScrollView *_contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订阅人";
    self.view.backgroundColor = [UIColor themeGrayColor];
    
    NSArray *datas = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,
//                       @1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,
//                       @1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,
//                       @1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,
//                       @1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,
                       ];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 0)];
    _contentView.layer.cornerRadius = 2.0;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    NSString *text = [NSString stringWithFormat:@"共%d人", (int)datas.count];
    UILabel *totalLabel = TKTemplateLabel2([UIFont systemFontOfSize:15], HexColor(0x4a4a4a), text);
    totalLabel.origin = CGPointMake(20, 15);
    [_contentView addSubview:totalLabel];
    
    int count = (_contentView.width - kItemInterval) / (kItemWidth + kItemInterval);
    float interval = (_contentView.width - count * kItemWidth) / (count + 1);
    float left = interval;
    float top = totalLabel.bottom + 6;
    float height = 0;
    for (int i = 0; i < datas.count; i++) {
        EADingYueRenItem *item = [[EADingYueRenItem alloc] initWithFrame:CGRectMake(left, top, kItemWidth, 56)
                                                                    icon:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504329930636&di=31c2f68226b75ce1f5db43f3ecfd6659&imgtype=0&src=http%3A%2F%2Fa1.att.hudong.com%2F41%2F79%2F19300001290790131174792213082.jpg"
                                                                    name:@"李亚运"];
        [_contentView addSubview:item];
        
        if ((i + 1) % count) {
            left = item.right + interval;
        } else {
            left = interval;
            top = item.bottom + 8;
        }
        height = item.bottom + 12;
    }
    _contentView.height = MIN(SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 20, height);
    _contentView.contentSize = CGSizeMake(_contentView.width, MAX(_contentView.height, height));
}

@end
