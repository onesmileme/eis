//
//  EAInputView.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAInputView.h"

@implementation EAInputView {
    UITextField *_textField;
    UITextView *_textView;
    UILabel *_valueLabel;
    UILabel *_placeHolderLabel;
    UIImageView *_arrowImageView;
    
    EAInputType _type;
}

- (instancetype)initWithFrame:(CGRect)frame
                         type:(EAInputType)type
                        title:(NSString *)title
                  placeHolder:(NSString *)placeHolder
                hasBottomLine:(BOOL)hasBottomLine {
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        
        UILabel *titleLabel = TKTemplateLabel2([UIFont systemFontOfSize:15], HexColor(0x666666), title);
        titleLabel.left = 12;
        titleLabel.centerY = self.height * .5;
        [self addSubview:titleLabel];
        
        _placeHolderLabel = TKTemplateLabel2(titleLabel.font, HexColor(0xb0b0b0), placeHolder);
        _placeHolderLabel.left = 118;
        _placeHolderLabel.centerY = self.height * .5;
        [self addSubview:_placeHolderLabel];
        
        if (EAInputTypeChoose == _type) {
            UIImage *image = [UIImage imageNamed:@"add_arrow"];
            _arrowImageView = [[UIImageView alloc] initWithImage:image];
            _arrowImageView.right = self.width - 14;
            _arrowImageView.centerY = titleLabel.centerY;
            [self addSubview:_arrowImageView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choose:)];
            [self addGestureRecognizer:tapGesture];
        }
        
        if (hasBottomLine) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, LINE_HEIGHT)];
            line.backgroundColor = HexColor(0xececec);
            [self addSubview:line];
        }
        
        if (EAInputTypeOneLineInput == _type) {
            [self createField];
        } else if (EAInputTypeMultiLinesInput == _type) {
            titleLabel.top = 12;
            [self createTextView];
        } else {
            [self createValueLabel];
        }
    }
    return self;
}

- (void)createField {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(_placeHolderLabel.left, 0, 0, 18)];
    _textField.textColor = HexColor(0x666666);
    _textField.font = [UIFont systemFontOfSize:15];
    _textView.width = self.width - _textField.left - 14;
    _textField.centerY = self.height * .5;
    [self addSubview:_textField];
}

- (void)createTextView {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(_placeHolderLabel.left, 12, 0, 0)];
    _textView.textColor = HexColor(0x666666);
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.width = self.width - _textView.left - 14;
    _textView.height = self.height - 24;
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

#pragma mark - Actions
- (void)choose:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        !self.chooseBlock ?: self.chooseBlock();
    }
}

@end
