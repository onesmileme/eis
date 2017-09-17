//
//  EAEnergyCell.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAEnergyCell.h"

@implementation EAEnergyCell {
    UIView *_bgView;
    UIImageView *_imageView;
    UILabel *_titleLabel;
}

+ (CGFloat)cellHeightWithModel:(id)model {
    return 80;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 82, 50)];
        _imageView.centerY = _bgView.height * .5;
        [_bgView addSubview:_imageView];
        
        _titleLabel = TKTemplateLabel([UIFont systemFontOfSize:16], HexColor(0x333333));
        [_bgView addSubview:_titleLabel];
        
        _titleLabel.frame = CGRectMake(_imageView.right + 20, 0, _bgView.width - _imageView.right - 30, 20);
        _titleLabel.centerY = _imageView.centerY;
    }
    return self;
}

- (void)setModel:(id)aModel {
    _titleLabel.text = aModel[@"text"];
    _imageView.image = [UIImage imageNamed:aModel[@"pic"]];
}

@end
