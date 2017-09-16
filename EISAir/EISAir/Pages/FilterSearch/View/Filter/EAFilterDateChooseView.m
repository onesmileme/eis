//
//  EAFilterDateChooseView.m
//  EISAir
//
//  Created by chunhui on 2017/9/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAFilterDateChooseView.h"
#import "TKCommonTools.h"

@interface EAFilterDateChooseView ()<UITextFieldDelegate>

@property(nonatomic , strong)UIView *bgView;
@property(nonatomic , strong)UIView *splitLine;

@property(nonatomic , strong)UIDatePicker *datePicker;
@property(nonatomic , strong)UIView *accessView;

@end

@implementation EAFilterDateChooseView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0 ,self.width, 30)];
        _bgView.backgroundColor = HexColor(0xf7f7f7);
        
        _splitLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width/12, 2)];
        _splitLine.backgroundColor = HexColor(0xcccccc);
        
        self.startDateField = [self textfield];
        self.toDateField = [self textfield];
     
        [self.bgView addSubview:_startDateField];
        [self.bgView addSubview:_toDateField];
        [self.bgView addSubview:_splitLine];
        [self addSubview:_bgView];
        
    }
    return self;
}

-(UITextField *)textfield
{
    UITextField *field = [[UITextField alloc]init];
    field.borderStyle = UITextBorderStyleNone;
    field.textAlignment = NSTextAlignmentCenter;
    field.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请选择" attributes:@{NSFontAttributeName:SYS_FONT(12),NSForegroundColorAttributeName:HexColor(0xd8d8d8)}];
    field.font = SYS_FONT(12);
    field.textColor = HexColor(0x444444);
    field.backgroundColor = [UIColor whiteColor];
    field.inputView = self.datePicker;
    field.inputAccessoryView = self.accessView;
    field.delegate = self;
    return field;
}

-(UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

-(UIView *)accessView
{
    if (!_accessView) {
        _accessView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmButton.frame = CGRectMake(SCREEN_WIDTH-100, 0, 100, 45);
        [confirmButton setTitle:@"完成" forState:UIControlStateNormal];
        confirmButton.titleLabel.font = SYS_FONT(15);
        [confirmButton setTitleColor:HexColor(0x007aff) forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [_accessView addSubview:confirmButton];
        _accessView.backgroundColor = HexColor(0xf0f1f2);
    }
    return _accessView;
}

-(void)doneAction:(id)sender
{
    NSDate *date = [_datePicker date];
    NSString *dateStr = [TKCommonTools dateStringWithFormat:TKDateFormatChineseShortYMD date:date];
    if ([_startDateField isFirstResponder]) {
        _startDate = date;
        _startDateField.text = dateStr;
        [_startDateField resignFirstResponder];
    }else{
        _toDate = date;
        _toDateField.text = dateStr;
        [_toDateField resignFirstResponder];
    }
}

-(void)clearDate
{
    _startDate = nil;
    _toDate =nil;
    _startDateField.text = nil;
    _toDateField.text = nil;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = self.bounds;
    self.splitLine.center = CGPointMake(self.width/2, self.height/2);
    
    _startDateField.frame = CGRectMake(5, (_bgView.height-24)/2, self.width*0.39, 24);
    _toDateField.frame = CGRectMake(self.width*(0.61) - 5, _startDateField.top, _startDateField.width, _startDateField.height);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _startDateField) {
        
        if (_toDate) {
            self.datePicker.maximumDate = _toDate;
            self.datePicker.minimumDate = nil;
        }
        
    }else{
        
        if (_startDate) {
            self.datePicker.minimumDate = _startDate;
            self.datePicker.maximumDate = nil;
        }
        
    }
    
    return true;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
