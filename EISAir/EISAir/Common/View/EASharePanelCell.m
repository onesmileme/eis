//
//  EASharePanelCell.m
//  FunApp
//
//  Created by liuzhao on 2016/12/1.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EASharePanelCell.h"

@interface EASharePanelCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation EASharePanelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:13];
    _label.textColor = HexColor(0x666666);
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    
    [self.contentView addSubview:_label];
    [self.contentView addSubview:_imageView];
}

- (void)setCellWithTitle:(NSString *)title image:(UIImage *)image
{
    self.label.text = title;
    [self.label sizeToFit];
    
    self.imageView.image = image;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.centerX = self.contentView.centerX;
    self.imageView.top = 26;
    
    self.label.top = self.imageView.bottom + 5;
    self.label.centerX = self.imageView.centerX;
}
@end
