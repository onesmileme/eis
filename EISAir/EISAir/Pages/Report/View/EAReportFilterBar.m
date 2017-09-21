//
//  EAReportFilterBar.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportFilterBar.h"

static const int kTag = 1000;

@implementation EAReportFilterBar {
    NSArray *_model;
    NSInteger _selectedIndex;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _selectedIndex = -1;
    }
    return self;
}

- (void)setModel:(NSArray *)model {
    if (!model.count) {
        return;
    }
    _model = model;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float interval = self.width / model.count;
    float left = 0;
    for (int i = 0; i < model.count; ++i) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(left, 0, interval, self.height)];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:HexColor(0x666666) forState:UIControlStateNormal];
        [button setTitleColor:HexColor(0x14b5f1) forState:UIControlStateHighlighted];
        [button setTitleColor:HexColor(0x14b5f1) forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"set_arrow_down"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"set_arrow_up"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"set_arrow_up"] forState:UIControlStateSelected];
        [button setTitle:model[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = kTag + i;
        [button.titleLabel sizeToFit];
        float labelWidth = button.titleLabel.width + 2;
        button.imageEdgeInsets = UIEdgeInsetsMake(0,0 + labelWidth,0,0 - labelWidth);
        float imageWidth = [button imageForState:UIControlStateNormal].size.width + 2;
        button.titleEdgeInsets = UIEdgeInsetsMake(0,0 - imageWidth,0,0 + imageWidth);
        [self addSubview:button];
        
        if (i) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(button.left, 7, LINE_HEIGHT, self.height - 14)];
            line.backgroundColor = LINE_COLOR;
            [self addSubview:line];
        }
        
        left = button.right;
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - LINE_HEIGHT, self.width, LINE_HEIGHT)];
    line.backgroundColor = LINE_COLOR;
    [self addSubview:line];
}

- (void)buttonClicked:(UIButton *)btn {
    NSInteger clickedIndex = btn.tag - kTag;
    if (_selectedIndex == -1 || _selectedIndex != clickedIndex) {
        _selectedIndex = clickedIndex;
    } else {
        _selectedIndex = -1;
    }
    [self updateButtonState];
    if (self.clickedBlock) {
        self.clickedBlock(_selectedIndex);
    }
}

- (void)updateButtonState {
    for (int i = 0; i < _model.count; ++i) {
        UIButton *button = (UIButton *)[self viewWithTag:kTag + i];
        button.selected = button.tag == (kTag + _selectedIndex);
    }
}

- (void)selectedNone {
    _selectedIndex = -1;
    [self updateButtonState];
}

@end
