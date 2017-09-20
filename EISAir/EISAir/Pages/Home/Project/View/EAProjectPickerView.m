//
//  EAProjectPickerView.m
//  EISAir
//
//  Created by chunhui on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAProjectPickerView.h"
#import "EAProjectToolbar.h"

@interface EAProjectPickerView()

@property(nonatomic , strong) EAProjectToolbar *toolbar;

@end

@implementation EAProjectPickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self  = [super initWithFrame:frame];
    if (self) {
        
        UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.width, 216)];
        picker.delegate = self;
        picker.dataSource = self;
        
        picker.backgroundColor = HexColor(0xd8d8d8);
        
        picker.bottom = self.height;
        [self addSubview:picker];
        self.picker = picker;
        
        __weak typeof(self) wself = self;
        _toolbar = [[EAProjectToolbar alloc]initWithFrame:CGRectMake(0, 0, self.width, 45)];
        _toolbar.doneBlock = ^{
            wself.chooseBlock([wself.picker selectedRowInComponent:0]);
            [wself hide];
        };
        _toolbar.bottom = picker.top;
        [self addSubview:_toolbar];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.frame = window.bounds;
    self.picker.bottom = self.height;
    self.toolbar.bottom = self.picker.top;
    [window addSubview:self];
}
-(void)hide
{
    [self removeFromSuperview];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _items.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _items[row];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
