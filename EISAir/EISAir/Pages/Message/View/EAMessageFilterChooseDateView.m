//
//  EAMessageFilterChooseDateView.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageFilterChooseDateView.h"
#import "TKCommonTools.h"

@interface EAMessageFilterChooseDateView ()

@property(nonatomic , strong)UIView *splitLine;

@end

@implementation EAMessageFilterChooseDateView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HexColor(0xf7f7f7);
        _splitLine = [[UIView alloc]initWithFrame:CGRectMake((self.width - 40)/2, self.height/2, self.width*0.074, 2)];
        
        [self addSubview:_splitLine];
        
        self.fromDateField = [self textfield];
        self.toDateField = [self textfield];
        
        
    }
    return self;
}

-(UITextField *)textfield
{
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 22.5)];
    field.borderStyle = UITextBorderStyleNone;
    field.textAlignment = NSTextAlignmentCenter;
    field.placeholder = @"请选择";
    field.font = SYS_FONT(24);
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.date = [NSDate date];
    
    field.inputView = picker;
    
    UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    bar.backgroundColor = HexColor(0xf0f1f2);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textColor = HexColor(0x007aff);
    button.titleLabel.font  = SYS_FONT(15);
    button.frame = CGRectMake(bar.width - 50, 0, 50, bar.height);
    [bar addSubview:button];
    
    field.inputAccessoryView = bar;
    
    return field;
}

-(void)doneAction:(id)sender
{
    if ([self.fromDateField isFirstResponder]) {
        UIDatePicker *picker = (UIDatePicker *)[self.fromDateField inputView];
        self.fromDate = [picker date];
        self.fromDateField.text = [TKCommonTools dateStringWithFormat:TKDateFormatChineseShortYMD date:[picker date]];;
        [self.fromDateField resignFirstResponder];
    }else{
        UIDatePicker *picker = (UIDatePicker *)[self.toDateField inputView];
        self.toDate = [picker date];
        self.toDateField.text = [TKCommonTools dateStringWithFormat:TKDateFormatChineseShortYMD date:[picker date]];;
        [self.toDateField resignFirstResponder];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.fromDateField.width = self.width*0.39;
    self.fromDateField.centerY = self.height/2;
    self.fromDateField.left = 5;
    self.toDateField.width = self.fromDateField.width;
    self.toDateField.centerY = self.fromDateField.centerY;
    self.toDateField.right = self.width - 5;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
