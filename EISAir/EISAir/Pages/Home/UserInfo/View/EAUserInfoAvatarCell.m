//
//  EAUserInfoAvatarCell.m
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAUserInfoAvatarCell.h"
#import <UIImageView+WebCache.h>
@interface EAUserInfoAvatarCell ()

@property(nonatomic , strong)IBOutlet UIImageView *avatarImageView;

@end

@implementation EAUserInfoAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.width/2;
    self.avatarImageView.layer.masksToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithAvatar:(NSString *)avatar
{
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatar]];
}

@end
