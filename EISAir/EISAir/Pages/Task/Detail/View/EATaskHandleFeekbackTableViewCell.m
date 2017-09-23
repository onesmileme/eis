//
//  EATaskHandleFeekbackTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskHandleFeekbackTableViewCell.h"

@interface EATaskHandleFeekbackTableViewCell ()

@property(nonatomic , strong) IBOutlet UILabel *contentLabel;
@property(nonatomic , strong) IBOutlet UIView *spliteLine;

@end

@implementation EATaskHandleFeekbackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGesture:)];
    [self addGestureRecognizer:gesture];
}

-(void)onTapGesture:(UITapGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self];
    if (location.y < _spliteLine.top - 5) {
        if (_showContent) {
            _showContent();
        }
    }else if (location.y > _spliteLine.bottom + 5){
        if (_showFeedBack) {
            _showFeedBack();
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
