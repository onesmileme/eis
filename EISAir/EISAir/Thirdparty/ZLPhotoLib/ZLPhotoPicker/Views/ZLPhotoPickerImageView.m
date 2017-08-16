//
//  PickerImageView.m
//  相机
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoPickerImageView.h"

@interface ZLPhotoPickerImageView ()

@property (nonatomic , weak) UIView *maskView;
@property (nonatomic , weak) UIImageView *tickImageView;
@property (nonatomic , weak) UIImageView *videoView;

@end

@implementation ZLPhotoPickerImageView

+(UIImage *)checkedImage
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"photo_picker_checked"];;
    }
    return image;
}

+(UIImage *)uncheckedImage
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"photo_picker_unchecked"];;
    }
    return image;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (UIView *)maskView
{
    if (!_maskView) {
        UIView *maskView = [[UIView alloc] init];
        maskView.frame = self.bounds;
        maskView.backgroundColor = [UIColor whiteColor];
        maskView.alpha = 0.5;
        maskView.hidden = YES;
        [self addSubview:maskView];
        self.maskView = maskView;
    }
    return _maskView;
}

- (UIImageView *)videoView
{
    if (!_videoView) {
        UIImageView *videoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height - 40, 30, 30)];
        videoView.image = [UIImage imageNamed:@"video"];
        videoView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:videoView];
        self.videoView = videoView;
    }
    return _videoView;
}

- (UIImageView *)tickImageView
{
    if (!_tickImageView) {
        UIImageView *tickImageView = [[UIImageView alloc] init];
        tickImageView.frame = CGRectMake(self.bounds.size.width - 30, 0, 30, 30);
        tickImageView.image = [ZLPhotoPickerImageView uncheckedImage];
        tickImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:tickImageView];
        self.tickImageView = tickImageView;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCheckAction:)];
        [tickImageView addGestureRecognizer:gesture];
        tickImageView.userInteractionEnabled = true;
        
    }
    return _tickImageView;
}

- (void)setIsVideoType:(BOOL)isVideoType
{
    _isVideoType = isVideoType;
    
    self.videoView.hidden = !(isVideoType);
}

- (void)setMaskViewFlag:(BOOL)maskViewFlag
{
    _maskViewFlag = maskViewFlag;
    
    self.maskView.hidden = !maskViewFlag;
    self.animationRightTick = maskViewFlag;
}

- (void)setMaskViewColor:(UIColor *)maskViewColor
{
    _maskViewColor = maskViewColor;
    
    self.maskView.backgroundColor = maskViewColor;
}

- (void)setMaskViewAlpha:(CGFloat)maskViewAlpha
{
    _maskViewAlpha = maskViewAlpha;    
    self.maskView.alpha = maskViewAlpha;
}

- (void)setAnimationRightTick:(BOOL)animationRightTick
{
    _animationRightTick = animationRightTick;
    self.tickImageView.image = animationRightTick ? [[self class]checkedImage] : [[self class] uncheckedImage];
}


-(void)tapCheckAction:(UITapGestureRecognizer *)gesture
{
    if (_changeSelectBlock) {
        _changeSelectBlock();
    }
}

@end
