//
//  EASearchConditionSwitchControl.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATabSwitchControl.h"

static const int kTagItem = 1000;

@implementation EATabSwitchControl {
    NSArray *_itemArray;
    UIView *_selectedTagLine;
    UIFont *_titleFont;
    float _lineWidth;
    UIColor *_lineColor;
}

- (instancetype)initWithFrame:(CGRect)frame
                    itemArray:(NSArray *)itemArray
                    titleFont:(UIFont *)titleFont
                    lineWidth:(float)lineWidth
                    lineColor:(UIColor *)lineColor {
    self = [super initWithFrame:frame];
    if (self) {
        _titleFont = titleFont;
        _lineWidth = lineWidth;
        _lineColor = lineColor;
        [self updateItemArray:itemArray];
    }
    return self;
}

- (void)updateItemArray:(NSArray *)itemArray {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _itemArray = itemArray;
    _selectedIndex = INT_MAX;
    self.backgroundColor = [UIColor whiteColor];
    if (_itemArray.count) {
        [self creatSubviewWithItemArray:itemArray titleFont:_titleFont lineWidth:_lineWidth lineColor:_lineColor];
        [self setSelectedIndex:0 shouldNotify:NO animate:NO];
    }
}

- (void)creatSubviewWithItemArray:(NSArray *)itemArray
                        titleFont:(UIFont *)titleFont
                        lineWidth:(float)lineWidth
                        lineColor:(UIColor *)lineColor {
    float left = 0;
    float width = self.width / _itemArray.count;
    for (int i = 0; i < _itemArray.count; ++i) {
        int tag = kTagItem + i;
        UIButton *button = [self viewWithTag:tag];
        if (!button) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(left, 0, width, self.height)];
            button.tag = tag;
            button.titleLabel.font = titleFont;
            [button setTitleColor:HexColor(0x9b9b9b) forState:UIControlStateNormal];
            [button setTitleColor:lineColor forState:UIControlStateHighlighted];
            [button setTitleColor:lineColor forState:UIControlStateSelected];
            [button setTitle:_itemArray[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        left = button.right;
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - LINE_HEIGHT, self.width, LINE_HEIGHT)];
    line.backgroundColor = LINE_COLOR;
    [self addSubview:line];
    
    _selectedTagLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 2.5, lineWidth, 2.5)];
    _selectedTagLine.backgroundColor = lineColor;
    [self addSubview:_selectedTagLine];
}

- (void)itemClicked:(UIButton *)button {
    [self setSelectedIndex:((int)button.tag - kTagItem) shouldNotify:YES animate:YES];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex shouldNotify:NO animate:YES];
}

- (void)setSelectedIndex:(NSUInteger)index shouldNotify:(BOOL)shouldNotify animate:(BOOL)animate {
    if (index > _itemArray.count - 1 || _selectedIndex == index) {
        return;
    }
    _selectedIndex = index;
    for (int i = 0; i < _itemArray.count; ++i) {
        int tag = kTagItem + i;
        UIButton *button = [self viewWithTag:tag];
        button.selected = _selectedIndex == i;
        if (button.selected) {
            if (animate) {
                [UIView animateWithDuration:0.2 animations:^{
                    _selectedTagLine.centerX = button.centerX;
                }];
            } else {
                _selectedTagLine.centerX = button.centerX;
            }
        }
    }
    if (shouldNotify) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
