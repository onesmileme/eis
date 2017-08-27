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

@interface EASearchCondintionSelectItemButton : UIButton

@end

@implementation EASearchCondintionSelectItemButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:HexColor(0x444444) forState:UIControlStateNormal];
        [self setTitleColor:HexColor(0x28cfc1) forState:UIControlStateHighlighted];
        [self setTitleColor:HexColor(0x28cfc1) forState:UIControlStateSelected];
        self.layer.cornerRadius = 2.0;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.backgroundColor = selected ? [HexColor(0x28cfc1) colorWithAlphaComponent:0.1] : HexColor(0xf7f7f7);
}

@end

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
    float left = 0;
    float width = self.width / _itemArray.count;
    float top = _titleLabel.bottom + 6;
    for (int i = 0; i < _itemArray.count; ++i) {
        int tag = kTagItem + i;
        UIButton *button = [self viewWithTag:tag];
        if (!button) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(left, top, width, self.height)];
            button.tag = tag;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:HexColor(0x9b9b9b) forState:UIControlStateNormal];
            [button setTitleColor:HexColor(0x28cfc1) forState:UIControlStateHighlighted];
            [button setTitleColor:HexColor(0x28cfc1) forState:UIControlStateSelected];
            [button setTitle:_itemArray[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    
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

@end
