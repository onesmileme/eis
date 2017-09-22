//
//  EAAddTaskInputCell.m
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAddTaskInputCell.h"


@implementation EAAddTaskInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.modifyButton.hidden = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)modifyAction:(id)sender
{
    if (_modifyBlock) {
        _modifyBlock(self);
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (_inputBlock) {
        _inputBlock(self,textField.text);
    }
    return true;
}

@end
