//
//  EARecordFilterCell.m
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EARecordFilterCell.h"

@implementation EARecordFilterCell {
    UILabel *_titleLabel;
    UILabel *_descLabel;
    UILabel *_noteLabel;
}

+ (CGFloat)cellHeightWithModel:(id)model {
    return 70;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _titleLabel = TKTemplateLabel(SYS_FONT(15), HexColor(0x333333));
        [self addSubview:_titleLabel];
        _descLabel = TKTemplateLabel(SYS_FONT(13), HexColor(0x666666));
        [self addSubview:_descLabel];
        _noteLabel = TKTemplateLabel(SYS_FONT(13), HexColor(0x666666));
        [self addSubview:_noteLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, [self.class cellHeightWithModel:nil] - LINE_HEIGHT, SCREEN_WIDTH, LINE_HEIGHT)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
    }
    return self;
}

- (void)setModel:(id)aModel {
    NSDictionary *dict = aModel;
    _titleLabel.text = dict[@"title"];
    _descLabel.text = dict[@"desc"];
    _noteLabel.text = dict[@"label"];
    
    [_titleLabel sizeToFit];
    [_descLabel sizeToFit];
    [_noteLabel sizeToFit];
    
    _titleLabel.left = 15;
    [_titleLabel setMaxRight:(SCREEN_WIDTH - 60)];
    _titleLabel.top = 15;
    _noteLabel.left = _titleLabel.right + 25;
    _noteLabel.centerY = _titleLabel.centerY;
    _descLabel.left = _titleLabel.left;
    _descLabel.top = _titleLabel.bottom + 5;
 
    [_noteLabel setMaxRight:(SCREEN_WIDTH)];
    [_descLabel setMaxRight:(SCREEN_WIDTH - 10)];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.backgroundColor = highlighted ? HexColor(0x28cfc1) : HexColor(0xffffff);
}

@end
