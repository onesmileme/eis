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
#import "EATaskHelper.h"

@interface EATaskStateInfoTableViewCell ()

@property(nonatomic , strong) IBOutlet EATaskProcessStateView *stateView;
@property(nonatomic , strong) IBOutlet UILabel *stateLabel;
@property(nonatomic , strong) IBOutlet UILabel *nameLabel;
@property(nonatomic , strong) IBOutlet UILabel *objLabel;
@property(nonatomic , strong) IBOutlet UILabel *infoLabel;

@property(nonatomic , strong) IBOutlet NSLayoutConstraint *stateToViewConstraint;
@property(nonatomic , strong) IBOutlet NSLayoutConstraint *nameTopStateConstraint;



@end

@implementation EATaskStateInfoTableViewCell

+(CGFloat)heightForModel:(EATaskDataListModel *)model
{
    CGFloat height = 160;
    EATaskStatus status = [EATaskHelper taskStatus:model];
    EATaskExecuteStatus execStatus = [EATaskHelper taskMyExecuteStatus:model];
    if (execStatus != EATaskExecuteStatusUnknown) {

        switch (status) {
            case EATaskStatusWait:
            {
                if (execStatus == EATaskExecuteStatusAssign || execStatus == EATaskExecuteStatusRefuse) {
                    height += 35;
                }else{
                    height += 15;
                }
            }
                break;
            case EATaskStatusFinish:
            {
                height += 35;
            }
                break;
            case EATaskStatusExecute:
            {
                height += 35;
            }
                break;
            case EATaskStatusInvalid:
            {
                height += 35;
            }
                break;
            case EATaskStatusUnknown:
            {
                
            }
                break;
            default:
                break;
        }
        
    }
    if (model.taskDescription.length > 0) {
        height += [model.taskDescription sizeWithMaxWidth:(SCREEN_WIDTH - 28) font:SYS_FONT(12)].height+3;
    }
    
    if (model.objNameList.count == 0) {
        height -= 15;
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
    EATaskStatus status = [EATaskHelper taskStatus:model];//EATaskProcessStateBegin;
    self.stateView.state = status;
    
    NSString *jobState = [[EATaskHelper sharedInstance] valueForExecuteStatus:model.myExecuteStatus];
    if (jobState.length > 0) {
        _stateLabel.text = jobState;
        _stateLabel.hidden = false;
        [_stateLabel sizeToFit];
        _nameTopStateConstraint.constant = 14;
        _stateToViewConstraint.constant = 19;
    }else{
        _stateLabel.hidden = true;
        _nameTopStateConstraint.constant = 0;
        _stateToViewConstraint.constant = 14;
    }
    
    _nameLabel.text = model.taskName;
    _objLabel.text = [model.objNameList componentsJoinedByString:@" "];//hehe
    _infoLabel.text = model.taskDescription;
}

@end
