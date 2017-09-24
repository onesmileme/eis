//
//  EASearchCondintionSelectControl.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASearchCondintionSelectControl.h"
#import "UIImage+Additions.h"

static const int kTagItem = 1000;

@implementation EASearchCondintionSelectControl {
    NSArray *_itemArray;
    UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSArray *)itemArray {
    self = [super initWithFrame:frame];
    if (self) {
        _selectedIndex = -1;
        _itemArray = itemArray;
        
        _titleLabel = TKTemplateLabel2([UIFont systemFontOfSize:14], HexColor(0x666666), title);
        _titleLabel.left = 15;
        [self addSubview:_titleLabel];
        if (_itemArray.count) {
            [self creatSubviews];
            [self selectedIndex:0];
        }
    }
    return self;
}

- (void)creatSubviews {
    float left = 15;
    float interval = 6;
    int columnPerRow = 4;
    float width = (self.width - left * 2 - interval * (columnPerRow - 1)) / columnPerRow;
    float top = _titleLabel.bottom + 6;
    float height = top;
    for (int i = 0; i < _itemArray.count; ++i) {
        int tag = kTagItem + i;
        UIButton *button = [self viewWithTag:tag];
        if (!button) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(left, top, width, 35)];
            button.tag = tag;
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [button setTitleColor:HexColor(0x444444) forState:UIControlStateNormal];
            [button setTitleColor:HexColor(0x28cfc1) forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"tag"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"tag_choose_s"] forState:UIControlStateSelected];
            [button setTitle:_itemArray[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        height = button.bottom;
        if ((i + 1) % columnPerRow) {
            left = button.right + interval;
        } else {
            left = 15;
            top = button.bottom + 10;
        }
    }
    
    self.height = height + 15;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - LINE_HEIGHT, self.width, LINE_HEIGHT)];
    line.backgroundColor = LINE_COLOR;
    [self addSubview:line];
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

- (void)reset {
    _selectedIndex = -1;
    [self selectedIndex:0];
}

@end
