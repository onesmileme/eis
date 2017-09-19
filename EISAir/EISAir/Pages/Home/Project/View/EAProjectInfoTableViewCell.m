//
//  EAProjectInfoTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAProjectInfoTableViewCell.h"

@implementation EAProjectInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithIcon:(NSString *)iconName title:(NSString *)title detail:(NSString *)detail
{
    self.imageView.image = SYS_IMG(iconName);
    self.textLabel.text = title;
    self.detailTextLabel.text = detail;
}

@end
