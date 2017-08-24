//
//  EAMessageFilterCollectionViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageFilterCollectionViewCell.h"

@implementation EAMessageFilterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selected = self.selected;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    UIImage *img = nil;
    UIColor *titleColor = nil;
    if (selected) {
        img = SYS_IMG(@"tag_choose_s");
        titleColor = HexColor(0x28cfc1);
    }else{
        img = SYS_IMG(@"tag");
        titleColor = HexColor(0x444444);
    }
    self.bgImageView.image = img;
    self.titleLabel.textColor = titleColor;
}

@end
