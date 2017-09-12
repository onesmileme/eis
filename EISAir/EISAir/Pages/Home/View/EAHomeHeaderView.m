//
//  EAHomeHeaderView.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAHomeHeaderView.h"

@implementation EAHomeHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tipWidthConstraint.constant = SCREEN_WIDTH/3;
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.width/2;
    self.avatarImageView.layer.masksToBounds = true;
}

-(void)updateModel:(id)model
{
    self.doneCountLabel.attributedText = [self countStr:25];
    self.recordCountLabel.attributedText = [self countStr:10];
    self.reportCountLabel.attributedText = [self countStr:8];
}

-(NSAttributedString *)countStr:(NSInteger)count
{
    NSString *str = [NSString stringWithFormat:@"%ld个",count];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:SYS_FONT(27.5),NSForegroundColorAttributeName:HexColor(0x00b0ce)}];
    
    [attrStr addAttributes:@{NSForegroundColorAttributeName:HexColor(0xbebebe),NSFontAttributeName:SYS_FONT(11)} range:NSMakeRange(str.length -1, 1)];
    
    return attrStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end