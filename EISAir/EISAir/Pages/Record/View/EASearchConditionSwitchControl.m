//
//  EASearchConditionSwitchControl.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASearchConditionSwitchControl.h"

static const int kTagItem = 1000;

@implementation EASearchConditionSwitchControl {
    NSArray *_itemArray;
    int _selectedIndex;
    UIView *_selectedTagLine;
}

- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)itemArray {
    self = [super initWithFrame:frame];
    if (self) {
        _selectedIndex = -1;
        _itemArray = itemArray;
        if (_itemArray.count) {
            [self creatSubviews];
            [self selectedIndex:0];
        }
    }
    return self;
}

- (int)selectedIndex {
    return _selectedIndex;
}

- (void)creatSubviews {
    float left = 0;
    float width = self.width / _itemArray.count;
    for (int i = 0; i < _itemArray.count; ++i) {
        int tag = kTagItem + i;
        UIButton *button = [self viewWithTag:tag];
        if (!button) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(left, 0, width, self.height)];
            button.tag = tag;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:HexColor(0x9b9b9b) forState:UIControlStateNormal];
            [button setTitleColor:HexColor(0x28cfc1) forState:UIControlStateHighlighted];
            [button setTitle:_itemArray[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - LINE_HEIGHT, self.width, LINE_HEIGHT)];
    line.backgroundColor = LINE_COLOR;
    [self addSubview:line];
    
    _selectedTagLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 2.5, self.width, 2.5)];
    _selectedTagLine.backgroundColor = HexColor(0x28cfc1);
    [self addSubview:_selectedTagLine];
}

- (void)itemClicked:(UIButton *)button {
    [self selectedIndex:(int)button.tag - kTagItem];
}

- (void)selectedIndex:(int)index {
    if (index < 0 || index > _itemArray.count - 1 || _selectedIndex == index) {
        return;
    }
    _selectedIndex = index;
    for (int i = 0; i < _itemArray.count; ++i) {
        int tag = kTagItem + i;
        UIButton *button = [self viewWithTag:tag];
        button.selected = _selectedIndex == i;
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
