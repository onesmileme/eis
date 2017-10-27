//
//  EAShareView.m
//  EISAir
//
//  Created by DoubleHH on 2017/10/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAShareReportView.h"
#import "UIImage+Additions.h"
#import <TKShareTools.h>

@interface EAShareReportView ()
@property (nonatomic, strong) NSString *url;
@property (nonatomic, weak) UIViewController *vc;
@end

@implementation EAShareReportView {
    UIView *_holderView;
}

+ (void)showWithUrl:(NSString *)url fromVC:(UIViewController *)vc {
    UIWindow *window = [UIApplication sharedApplication].delegate.window ?: [UIApplication sharedApplication].keyWindow;
    EAShareReportView *view = [[EAShareReportView alloc] initWithFrame:window.bounds];
    view.url = url;
    view.vc = vc;
    [window addSubview:view];
    [view animateWithIsShow:YES];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        UIView *holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 198)];
        holderView.top = self.height - holderView.height;
        [self addSubview:holderView];
        
        CGRect btnFrame = CGRectMake(9, holderView.height - 68, holderView.width - 18, 58);
        UIButton *button = [[UIButton alloc] initWithFrame:btnFrame];
        [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:HexColor(0x007aff) forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:HexColor(0xeeeeee)] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 7.0;
        [holderView addSubview:button];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(9, 0, self.width - 18, 120)];
        topView.clipsToBounds = YES;
        topView.backgroundColor = HexColor(0xeeeeee);
        topView.layer.cornerRadius = button.layer.cornerRadius;
        [holderView addSubview:topView];
        
        NSArray *images = @[@"复制链接", @"微信", @"朋友圈", @"QQ"];
        NSArray *titles = @[@"复制链接", @"微信", @"朋友圈", @"QQ"];
        __block float x = 12;
        float width = 58;
        float interval = (topView.width - 2 * x - 4 * width) / 3;
        [images enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect btnFrame = CGRectMake(x, 21, width, 78);
            UIButton *button = [[UIButton alloc] initWithFrame:btnFrame];
            [button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            [topView addSubview:button];
            button.tag = 1000 + idx;
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:obj]];
            imageView.frame = CGRectMake(0, 0, width, width);
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius = 9;
            [button addSubview:imageView];
            
            UILabel *label = TKTemplateLabel2(SYS_FONT(9), [UIColor blackColor], titles[idx]);
            label.centerX = imageView.centerX;
            label.top = imageView.bottom + 7;
            [button addSubview:label];
            
            x = button.right + interval;
        }];
    }
    return self;
}

- (void)share:(UIButton *)btn {
    NSInteger tag = btn.tag - 1000;
    if (0 == tag) {
        [TKCommonTools showToast:@"复制成功!"];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.url;
    } else {
        TkShareData *data = [[TkShareData alloc] init];
        data.url = self.url;
        data.shareType = TKShareTypeWeb;
        TKSharePlatform platform = TKSharePlatformWXSession;
        if (1 == tag) {
            platform = TKSharePlatformWXSession;
        } else if (2 == tag) {
            platform = TKSharePlatformWXTimeline;
        } else if (3 == tag) {
            platform = TKSharePlatformQQ;
        }
        [[TKShareTools sharedInstance] sendShareTo:platform shareData:data presentedController:self.vc responce:^(TKShareResult *result) {
            [TKCommonTools showToast:result.success ? @"分享成功!" : @"分享失败"];
        }];
    }
    [self animateWithIsShow:NO];
}

- (void)cancel {
    [self animateWithIsShow:NO];
}

- (void)animateWithIsShow:(BOOL)isShow {
    if (isShow) {
        self.alpha = 0;
        _holderView.top = self.height;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = isShow ? 1 : 0;
        if (isShow) {
            _holderView.bottom = self.height - 10;
        }
    } completion:^(BOOL finished) {
        if (!isShow) {
            [self removeFromSuperview];
        }
    }];
}

@end
