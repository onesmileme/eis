//
//  EAShareView.m
//  FunApp
//
//  Created by liuzhao on 2016/12/1.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EAShareView.h"
#import "EASharePanelView.h"

#define kPanelViewHeight 155

@interface EAShareView ()

@property (nonatomic, strong) EASharePanelView *panel;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation EAShareView

- (instancetype)initWithTitles:(NSMutableArray *)titles images:(NSMutableArray *)images
{
    self = [super init];
    if (self) {
        _titles = titles ;
        _images = images;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    _panel = [[EASharePanelView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kPanelViewHeight, SCREEN_WIDTH, kPanelViewHeight)];
    __weak typeof (self) weakself = self;
    [_panel updateWithTitles:_titles images:_images];
    _panel.chooseItem = ^(NSInteger index){
        if (weakself.shareAction) {
            weakself.shareAction(index);
        }
        [weakself dismiss:true];
    };
    _panel.dismiss = ^{
        [weakself dismiss:true];
    };
    [self addSubview:_panel];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated
{
    if (view == nil) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    
    self.frame = view.bounds;
    
    CGRect frame = _panel.frame;
    frame.origin.y = CGRectGetHeight(self.bounds);
    _panel.frame = frame;
    
    [view addSubview:self];
    
    if (animated) {
        [UIView animateWithDuration:.3 animations:^{
            CGRect toFrame = _panel.frame;
            toFrame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(toFrame);
            _panel.frame = toFrame;
        }];
    } else {
        CGRect toFrame = _panel.frame;
        toFrame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(toFrame);
        _panel.frame = toFrame;
    }
    
}

- (void)dismiss:(BOOL)animated
{
    if (animated) {
        CGRect frame = self.panel.frame;
        frame.origin.y = self.bounds.size.height;
        __weak typeof (self) weakself = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakself.panel.frame = frame;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [self removeFromSuperview];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.panel.frame, touchLocation)) {
        [self dismiss:true];
    }
}
@end
