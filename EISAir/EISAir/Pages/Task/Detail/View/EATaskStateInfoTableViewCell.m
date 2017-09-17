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
#import "EATaskModel.h"

@interface EATaskStateInfoTableViewCell ()

@property(nonatomic , strong) IBOutlet EATaskProcessStateView *stateView;
@property(nonatomic , strong) IBOutlet UILabel *stateLabel;
@property(nonatomic , strong) IBOutlet UILabel *nameLabel;
@property(nonatomic , strong) IBOutlet UILabel *objLabel;
@property(nonatomic , strong) IBOutlet UILabel *infoLabel;

@end

@implementation EATaskStateInfoTableViewCell

+(CGFloat)heightForModel:(EATaskDataListModel *)model
{
    CGFloat height = 195;
    if (model.taskDescription.length > 0) {
        height += [model.taskDescription sizeWithMaxWidth:(SCREEN_WIDTH - 28) font:SYS_FONT(12)].height;
    }
    
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

-(void)updteWithModel:(EATaskDataListModel*)model
{
    EATaskProcessState state = EATaskProcessStateWating;//EATaskProcessStateBegin;
    NSString *status = [model.taskStatus lowercaseString];
    if ([status  isEqualToString:@"wait"]) {
        state = EATaskProcessStateWating;
    }else if ([status isEqualToString:@"execute"]){
        
    }else if ([status isEqualToString:@""]){
        
    }else if ([status isEqualToString:@""]){
        
    }
    
    self.stateView.state = state;
    
    _nameLabel.text = model.taskName;
    _objLabel.text = model.taskName;//hehe
    _infoLabel.text = model.taskDescription;
}

@end
