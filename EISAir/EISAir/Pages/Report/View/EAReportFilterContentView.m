//
//  EAReportFilterContentView.m
//  EISAir
//
//  Created by iwm on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportFilterContentView.h"

@interface EAReportFilterContentItem : UIControl {
    UILabel *_titleLabel;
    UIImageView *_selectedIconIV;
}

@end

@implementation EAReportFilterContentItem

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = TKTemplateLabel2([UIFont systemFontOfSize:14], HexColor(0x0), text);
        _titleLabel.left = 28;
        _titleLabel.centerY = self.height * .5;
        _titleLabel.highlightedTextColor = HexColor(0x00afcf);
        [self addSubview:_titleLabel];
        
        _selectedIconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _selectedIconIV.centerY = self.height * .5;
        _selectedIconIV.right = self.width - 15;
        [self addSubview:_selectedIconIV];
        _selectedIconIV.hidden = YES;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - LINE_HEIGHT, self.width, LINE_HEIGHT)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    _titleLabel.highlighted = highlighted;
    _selectedIconIV.hidden = !highlighted;
}

@end

static const int kItemTag = 1000;

@implementation EAReportFilterContentView {
    NSArray *_datas;
    NSInteger _currentIndex;
}

- (instancetype)initWithData:(NSArray *)data selectedIndex:(NSInteger)selectedIndex {
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self = [super initWithFrame:frame];
    if (self) {
        _datas = data;
        _currentIndex = -1;
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgClicked:)];
        [bgView addGestureRecognizer:gesture];
        [self addSubview:bgView];
        
        [self initViews];
        [self setSelectedIndex:MAX(0, selectedIndex)];
    }
    return self;
}

- (void)initViews {
    float top = 0;
    int index = 0;
    for (NSString *title in _datas) {
        EAReportFilterContentItem *item = [[EAReportFilterContentItem alloc] initWithFrame:CGRectMake(0, top, self.width, 44) text:title];
        item.tag = kItemTag + index;
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        top = item.bottom;
        index++;
    }
}

- (void)itemClicked:(EAReportFilterContentItem *)item {
    BOOL result = [self setSelectedIndex:(item.tag - kItemTag)];
    if (result) {
        !self.itemClickedBlock ?: self.itemClickedBlock();
    }
}

- (void)bgClicked:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        !self.bgClickedBlock ?: self.bgClickedBlock();
    }
}

- (NSInteger)selectedIndex {
    return _currentIndex;
}

- (BOOL)setSelectedIndex:(NSInteger)index {
    if (_currentIndex == index) {
        return NO;
    }
    _currentIndex = index;
    for (int i = 0; i < _datas.count; ++i) {
        EAReportFilterContentItem *item = [self viewWithTag:(kItemTag + i)];
        item.highlighted = _currentIndex == i;
    }
    return YES;
}

@end
