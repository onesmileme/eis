//
//  EAAddTaskDateCell.m
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAddTaskDateCell.h"

@interface EAAddTaskDateCell ()

@property(nonatomic , strong) UIDatePicker *picker;
@property(nonatomic , strong) UIView *toolbar;

@end

@implementation EAAddTaskDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    self.contentField.inputView = [self picker];
    self.contentField.inputAccessoryView = self.toolbar;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIDatePicker *)picker
{
    if (!_picker) {
        _picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 214)];
        _picker.datePickerMode = UIDatePickerModeDate;
    }
    
    return _picker;
}

-(UIView *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _toolbar.backgroundColor = HexColor(0xf0f1f2);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        button.titleLabel.font = SYS_FONT(15);
        [button setTitleColor:HexColor(0x007aff) forState:UIControlStateNormal];
        button.frame = CGRectMake(_toolbar.width - 60, 0, 60, _toolbar.height);
        [_toolbar addSubview:button];
    }
    return _toolbar;
}

-(void)doneAction
{
    if (_chooseDate) {
        [self.contentField resignFirstResponder];
        NSDate *date = self.picker.date;
        _chooseDate(self,date);
    }
}

@end
