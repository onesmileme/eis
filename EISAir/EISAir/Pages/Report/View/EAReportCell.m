//
//  EAReportCell.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportCell.h"

@implementation EAReportCell {
    UIImageView *_imageView;
    UIView *_redPointView;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UIView *_line;
}

+ (CGFloat)cellHeightWithModel:(id)model {
    return 66;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 27, 35)];
        _imageView.image = [UIImage imageNamed:@"report_icon4"];
        _imageView.centerY = [self.class cellHeightWithModel:nil] * .5;
        [self addSubview:_imageView];
        
        _redPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _redPointView.layer.cornerRadius = _redPointView.height * .5;
        _redPointView.clipsToBounds = YES;
        _redPointView.left = _imageView.right - 5;
        _redPointView.bottom = _imageView.top + 5;
        _redPointView.backgroundColor = HexColor(0xff5500);
        [self addSubview:_redPointView];
        
        _titleLabel = TKTemplateLabel([UIFont systemFontOfSize:14], HexColor(0x333333));
        [self addSubview:_titleLabel];
        
        _timeLabel = TKTemplateLabel([UIFont systemFontOfSize:12], HexColor(0xb0b0b0));
        [self addSubview:_timeLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, [self.class cellHeightWithModel:nil] - LINE_HEIGHT, SCREEN_WIDTH, LINE_HEIGHT)];
        _line.backgroundColor = LINE_COLOR;
        [self addSubview:_line];
    }
    return self;
}

- (void)setModel:(NSDictionary *)aModel {
    _titleLabel.text = aModel[@"text"];
    _timeLabel.text = aModel[@"time"];
    _redPointView.hidden = ![aModel[@"red"] boolValue];
    
    [_timeLabel sizeToFit];
    [_timeLabel sizeToFit];
    
    _timeLabel.right = self.width - 12;
    _titleLabel.left = _imageView.right + 16;
    _titleLabel.centerY = _timeLabel.centerY = _imageView.centerY;
    [_titleLabel setMaxRight:(_timeLabel.left - 10)];
}

@end
