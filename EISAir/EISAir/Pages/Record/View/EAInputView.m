//
//  EAInputView.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAInputView.h"

@interface EAInputView () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@end

@implementation EAInputView {
    UITextField *_textField;
    UITextView *_textView;
    UILabel *_valueLabel;
    UILabel *_placeHolderLabel;
    UIImageView *_arrowImageView;
    
    EAInputType _type;
    NSArray *_pickerContents;
}

- (instancetype)initWithFrame:(CGRect)frame
                         type:(EAInputType)type
                        title:(NSString *)title
                  placeHolder:(NSString *)placeHolder {
    return [self initWithFrame:frame
                          type:type
                         title:title
                   placeHolder:placeHolder
                pickerContents:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
                         type:(EAInputType)type
                        title:(NSString *)title
                  placeHolder:(NSString *)placeHolder
               pickerContents:(NSArray *)pickerContents {
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _pickerContents = pickerContents;
        
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = TKTemplateLabel2([UIFont systemFontOfSize:15], HexColor(0x666666), title);
        titleLabel.left = 12;
        titleLabel.centerY = self.height * .5;
        [self addSubview:titleLabel];
        
        _placeHolderLabel = TKTemplateLabel2(titleLabel.font, HexColor(0xb0b0b0), placeHolder);
        _placeHolderLabel.left = 118;
        _placeHolderLabel.centerY = self.height * .5;
        
        if (EAInputTypeChoose == _type || EAInputTypeDate == _type || EAInputTypePicker == _type) {
            UIImage *image = [UIImage imageNamed:@"add_arrow"];
            _arrowImageView = [[UIImageView alloc] initWithImage:image];
            _arrowImageView.right = self.width - 14;
            _arrowImageView.centerY = titleLabel.centerY;
            [self addSubview:_arrowImageView];
        }
        if (EAInputTypeChoose == _type) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choose:)];
            [self addGestureRecognizer:tapGesture];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - LINE_HEIGHT, self.width, LINE_HEIGHT)];
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
        
        if (EAInputTypeOneLineInput == _type || EAInputTypeDate == _type || EAInputTypePicker == _type) {
            [self createField];
        } else if (EAInputTypeMultiLinesInput == _type) {
            titleLabel.top = _placeHolderLabel.top = 12;
            [self createTextView];
        } else {
            [self createValueLabel];
        }
        
        [self addSubview:_placeHolderLabel];
    }
    return self;
}

- (void)createField {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(_placeHolderLabel.left, 0, 0, 18)];
    _textField.textColor = HexColor(0x666666);
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.width = self.width - _placeHolderLabel.left - 14;
    _textField.centerY = self.height * .5;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    if (EAInputTypeDate == _type || EAInputTypePicker == _type) {
        if (EAInputTypeDate == _type) {
            UIDatePicker *picker = [[UIDatePicker alloc]init];
            picker.datePickerMode = UIDatePickerModeDateAndTime;
            picker.date = [NSDate date];
            _textField.inputView = picker;
        } else {
            UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            [pickerView reloadAllComponents];
            _textField.inputView = pickerView;
        }
        
        UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        bar.backgroundColor = HexColor(0xf0f1f2);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:HexColor(0x007aff) forState:UIControlStateNormal];
        button.titleLabel.font  = SYS_FONT(15);
        button.frame = CGRectMake(bar.width - 60, 0, 60, bar.height);
        [bar addSubview:button];
        
        _textField.inputAccessoryView = bar;
    }
}

- (void)createTextView {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(_placeHolderLabel.left, 4, 0, 0)];
    _textView.textColor = HexColor(0x666666);
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.width = self.width - _textView.left - 14;
    _textView.height = self.height - 8;
    _textView.delegate = self;
    [self addSubview:_textView];
}

- (void)createValueLabel {
    _valueLabel = TKTemplateLabel([UIFont systemFontOfSize:15], HexColor(0x666666));
    _valueLabel.left = _placeHolderLabel.left;
    _valueLabel.width = _arrowImageView.left - _valueLabel.left - 8;
    _valueLabel.height = 18;
    _valueLabel.centerY = self.height * .5;
    [self addSubview:_valueLabel];
}

- (void)setInputKeyboardType:(UIKeyboardType)inputKeyboardType {
    _textField.keyboardType = inputKeyboardType;
    _textView.keyboardType = inputKeyboardType;
}

#pragma mark - Property
- (void)setInputText:(NSString *)inputText {
    _textField.text = inputText;
    _textView.text = inputText;
    _valueLabel.text = inputText;
    _placeHolderLabel.hidden = inputText.length > 0;
}

- (NSString *)inputText {
    if (_textField) {
        return _textField.text;
    }
    if (_textView) {
        return _textView.text;
    }
    return _valueLabel.text;
}

- (NSDate *)selectedDate {
    return [(UIDatePicker *)_textField.inputView date];
}

- (void)setSelectedDate:(NSDate *)selectedDate {
    ((UIDatePicker *)_textField.inputView).date = selectedDate;
}

- (NSInteger)pickerIndex {
    return [((UIPickerView *)_textField.inputView) selectedRowInComponent:0];
}

- (void)setPickerIndex:(NSInteger)pickerIndex {
    [((UIPickerView *)_textField.inputView) selectRow:pickerIndex inComponent:0 animated:NO];
}

- (EAInputType)type {
    return _type;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _placeHolderLabel.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _placeHolderLabel.hidden = textField.text.length > 0;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    _placeHolderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    _placeHolderLabel.hidden = textView.text.length > 0;
}

#pragma mark - Actions
- (void)choose:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        !self.chooseBlock ?: self.chooseBlock(self);
    }
}

- (void)doneAction:(id)sender {
    [self endEditing:YES];
}


#pragma mark - Picker delegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerContents.count;
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREEN_WIDTH;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component  {
    return 33;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerContents[row];
}

@end
