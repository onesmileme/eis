//
//  EAPickerView.m
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAPickerView.h"

@interface EAPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation EAPickerView {
    UIPickerView *_pickerView;
    UIView *_topView;
    NSArray *_datas;
}

- (instancetype)initWithDatas:(NSArray *)datas
{
    self = [super init];
    if (self) {
        _datas = datas;
        [self initViews];
    }
    return self;
}

- (void)initViews {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self addSubview:_pickerView];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    _topView.backgroundColor = HexColor(0xf0f1f2);
    [self addSubview:_topView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(_topView.width - 60, 0, 60, _topView.height)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:HexColor(0x007aff) forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    _pickerView.top = _topView.bottom;
    self.height = _pickerView.bottom;
}

- (void)itemClicked:(id)sender {
    if (!self.doneBlock) {
        return;
    }
    self.doneBlock(@([_pickerView selectedRowInComponent:0]));
}

#pragma mark - Animate
- (void)animateIsShow:(BOOL)show fromView:(UIView *)view {
    self.top = show ? view.height : (view.height - self.height);
    if (show) {
        [view addSubview:self];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.top = show ? (view.height - self.height) : view.height;
    } completion:^(BOOL finished) {
        if (!show) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Picker delegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _datas.count;
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component  {
    return 33;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _datas[row];
}

@end
