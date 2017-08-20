//
//  EALoginTextField.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EALoginTextField.h"

@implementation EALoginTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.borderStyle = UITextBorderStyleNone;
    self.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
