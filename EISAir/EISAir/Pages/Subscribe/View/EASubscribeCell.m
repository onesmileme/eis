//
//  EASubscribeCell.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASubscribeCell.h"

@implementation EASubscribeCell {
    UIView *_bgView;
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    UIButton *_subscribeBtn;
}

+ (CGFloat)cellHeightWithModel:(id)model {
    return 98;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 88)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 2.0;
        _bgView.clipsToBounds = YES;
        [self addSubview:_bgView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 80, 44)];
        _imageView.centerY = _bgView.height * .5;
        [_bgView addSubview:_imageView];
        
        _titleLabel = TKTemplateLabel([UIFont systemFontOfSize:16], HexColor(0x333333));
        [_bgView addSubview:_titleLabel];
        
        _detailLabel = TKTemplateLabel([UIFont systemFontOfSize:12], HexColor(0x858585));
        [_bgView addSubview:_detailLabel];
        
        _subscribeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 55, 21)];
        [_subscribeBtn addTarget:self action:@selector(subscribeClicked) forControlEvents:UIControlEventTouchUpInside];
        [_subscribeBtn setTitleColor:HexColor(0xa1a1a1) forState:UIControlStateNormal];
        [_subscribeBtn setTitleColor:HexColor(0xffb549) forState:UIControlStateHighlighted];
        [_subscribeBtn setTitleColor:HexColor(0xffb549) forState:UIControlStateSelected];
        [_subscribeBtn setTitle:@"订阅" forState:UIControlStateNormal];
        _subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _subscribeBtn.clipsToBounds = YES;
        _subscribeBtn.layer.cornerRadius = 2.0;
        _subscribeBtn.layer.borderColor = HexColor(0xa1a1a1).CGColor;
        _subscribeBtn.layer.borderWidth = LINE_HEIGHT;
        [_bgView addSubview:_subscribeBtn];
        _subscribeBtn.right = _bgView.width - 10;
    }
    return self;
}

- (void)setModel:(id)aModel {
    _titleLabel.text = aModel[@"name"];
    _detailLabel.text = aModel[@"desc"];
    _imageView.image = [UIImage imageNamed:aModel[@"pic"]];
    _subscribeBtn.selected = [aModel[@"subscribed"] boolValue];
 
    [_titleLabel sizeToFit];
    [_detailLabel sizeToFit];
    _titleLabel.origin = CGPointMake(_imageView.right + 20, _imageView.top + 7);
    _detailLabel.origin = CGPointMake(_titleLabel.left, _titleLabel.bottom + 4);
    [_titleLabel setMaxRight:_bgView.width];
    [_detailLabel setMaxRight:_bgView.width];
}

- (void)updateButtonState {
    
}

- (void)subscribeClicked {
    !self.subscribeClickBlock ?: self.subscribeClickBlock();
}

@end
