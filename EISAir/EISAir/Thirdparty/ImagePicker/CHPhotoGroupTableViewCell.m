//
//  CHPhotoGroupTableViewCell.m
//  Find
//
//  Created by chunhui on 15/8/6.
//  Copyright (c) 2015年 chunhui. All rights reserved.
//

#import "CHPhotoGroupTableViewCell.h"

@implementation CHPhotoGroupTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithThumb:(UIImage *)thumb name:(NSString *)name count:(NSInteger)count
{
    self.thumbImageView.image = thumb;
    self.nameLabel.text = name;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",count];
}

@end
