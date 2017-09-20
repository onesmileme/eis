//
//  EAReportCell.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportCell.h"

@implementation EAReportCell {
    EAReportCellStyle _cellStyle;
    
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
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier cellStyle:EAReportCellStyleSingle];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellStyle:(EAReportCellStyle)cellStyle {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _cellStyle = cellStyle;
        CGRect frame = _cellStyle == EAReportCellStyleSingle ? CGRectMake(15, 0, 27, 35) : CGRectMake(15, 0, 32, 29);
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.image = [UIImage imageNamed:_cellStyle == EAReportCellStyleSingle ? @"report_icon4" : @"report_icon5"];
        _imageView.centerY = [self.class cellHeightWithModel:nil] * .5;
        [self addSubview:_imageView];
        
        _redPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _redPointView.layer.cornerRadius = _redPointView.height * .5;
        _redPointView.clipsToBounds = YES;
        _redPointView.left = _imageView.right - 5;
        _redPointView.bottom = _imageView.top + 5;
        _redPointView.backgroundColor = HexColor(0xff5500);
        [self addSubview:_redPointView];
        
        _titleLabel = TKTemplateLabel([UIFont systemFontOfSize:(_cellStyle == EAReportCellStyleSingle ? 14 : 15)], HexColor(0x333333));
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
    _titleLabel.text = aModel[@"title"];
    _timeLabel.text = aModel[@"time"];
    _redPointView.hidden = ![aModel[@"red"] boolValue];
    
    [_titleLabel sizeToFit];
    [_timeLabel sizeToFit];
    
    _titleLabel.left = _imageView.right + 16;
    if (_cellStyle == EAReportCellStyleSingle) {
        _timeLabel.right = SCREEN_WIDTH - 12;
        _titleLabel.centerY = _timeLabel.centerY = _imageView.centerY;
        [_titleLabel setMaxRight:(_timeLabel.left - 10)];
    } else {
        _titleLabel.top = _imageView.top - 2;
        _timeLabel.left = _titleLabel.left;
        _timeLabel.top = _titleLabel.bottom + 3;
        [_titleLabel setMaxRight:(SCREEN_WIDTH - 15)];
        [_timeLabel setMaxRight:(SCREEN_WIDTH - 15)];
    }
}

@end
