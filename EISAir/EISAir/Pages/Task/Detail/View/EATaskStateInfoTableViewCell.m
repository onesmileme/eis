//
//  EATaskInfoTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskStateInfoTableViewCell.h"
#import "EATaskProcessStateView.h"
#import "NSString+TKSize.h"


@interface EATaskStateInfoTableViewCell ()

@property(nonatomic , strong) IBOutlet EATaskProcessStateView *stateView;
@property(nonatomic , strong) IBOutlet UILabel *stateLabel;
@property(nonatomic , strong) IBOutlet UILabel *nameLabel;
@property(nonatomic , strong) IBOutlet UILabel *infoLabel;

@end

@implementation EATaskStateInfoTableViewCell

+(CGFloat)heightForModel:(id)model
{
    CGFloat height = 195;
    
    height += [@"" sizeWithMaxWidth:(SCREEN_WIDTH - 28) font:SYS_FONT(12)].height;
    
    
    return height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updteWithModel:(id)model
{
    
}

@end
