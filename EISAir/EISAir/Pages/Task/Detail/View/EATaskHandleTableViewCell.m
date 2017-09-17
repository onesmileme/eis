//
//  EATaskHandleTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskHandleTableViewCell.h"

@interface EATaskHandleTableViewCell()

@property(nonatomic ,strong) IBOutlet UIButton *executeButton;
@property(nonatomic ,strong) IBOutlet UIButton *rejectButton;


@end

@implementation EATaskHandleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _executeButton.layer.cornerRadius = 4;
    _executeButton.layer.masksToBounds = true;
    
    _rejectButton.layer.cornerRadius = 4;
    _rejectButton.layer.borderColor = [HexColor(0x28cfc1) CGColor];
    _rejectButton.layer.borderWidth = 0.5;
    _rejectButton.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)executeAction:(id)sender
{
    if (_handleBlock) {
        _handleBlock(EATashHandlerAccept);
    }
}

-(IBAction)rejectAction:(id)sender
{
    if (_handleBlock) {
        _handleBlock(EATashHandlerReject);
    }
}

-(IBAction)assiginAction:(id)sender
{
    if (_handleBlock) {
        _handleBlock(EATashHandlerToOther);
    }
}

@end
