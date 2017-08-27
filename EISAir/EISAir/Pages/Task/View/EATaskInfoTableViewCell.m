//
//  EATaskInfoTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskInfoTableViewCell.h"
#import "NSString+TKSize.h"

@interface EATaskInfoTableViewCell ()

@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UILabel *stateLabel;
@property(nonatomic , strong) IBOutlet UILabel *dateLabel;
@property(nonatomic , strong) IBOutlet UILabel *typeLabel;
@property(nonatomic , strong) IBOutlet UILabel *infoLabel;

@end

@implementation EATaskInfoTableViewCell

+(CGFloat)heightForModel:(id)model
{
    CGFloat height = 78;
    
    height += [@"" sizeWithMaxWidth:(SCREEN_WIDTH - 29) font:SYS_FONT(14)].height;
    
    return height;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.stateLabel.layer.cornerRadius = 4;
    self.stateLabel.layer.masksToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithModel:(id)model
{
    
}

@end
