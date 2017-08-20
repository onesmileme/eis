//
//  EAMessageTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageTableViewCell.h"

@interface EAMessageTableViewCell ()

@property(nonatomic , strong) IBOutlet UIImageView *avatar;
@property(nonatomic , strong) IBOutlet UIImageView *reddot;
@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UILabel *contentLabel;
@property(nonatomic , strong) IBOutlet UILabel *dateLabel;


@end

@implementation EAMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
