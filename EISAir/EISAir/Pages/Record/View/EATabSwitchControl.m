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
}

- (instancetype)initWithFrame:(CGRect)frame
                    itemArray:(NSArray *)itemArray
                    titleFont:(UIFont *)titleFont
                    lineWidth:(float)lineWidth
                    lineColor:(UIColor *)lineColor {
    self = [super initWithFrame:frame];
    if (self) {
        _selectedIndex = INT_MAX;
        _itemArray = itemArray;
        self.backgroundColor = [UIColor whiteColor];
        if (_itemArray.count) {
            [self creatSubviewWithItemArray:itemArray titleFont:titleFont lineWidth:lineWidth lineColor:lineColor];
            self.selectedIndex = 0;
        }
    }
    return self;
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
    self.selectedIndex = (int)button.tag - kTagItem;
}

- (void)setSelectedIndex:(NSUInteger)index {
    if (index > _itemArray.count - 1 || _selectedIndex == index) {
        return;
    }
    _selectedIndex = index;
    for (int i = 0; i < _itemArray.count; ++i) {
        int tag = kTagItem + i;
        UIButton *button = [self viewWithTag:tag];
        button.selected = _selectedIndex == i;
        if (button.selected) {
            [UIView animateWithDuration:0.2 animations:^{
                _selectedTagLine.centerX = button.centerX;
            }];
        }
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
