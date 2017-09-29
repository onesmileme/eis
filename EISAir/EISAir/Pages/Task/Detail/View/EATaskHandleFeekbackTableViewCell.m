//
//  EATaskHandleFeekbackTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskHandleFeekbackTableViewCell.h"
#import "EATaskModel.h"

@interface EATaskHandleFeekbackTableViewCell ()

@property(nonatomic , strong) IBOutlet UILabel *contentLabel;
@property(nonatomic , strong) IBOutlet UILabel *stateLabel;
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

-(void)updateWithModel:(EATaskDataListModel *)model
{
    
    NSString *tip = model.fillNum ?@"数值填写完成":@"未进行数值填写";//部分数值填写
    UIColor *color = model.fillNum?RGB(63, 209, 196):HexColor(0xff6663);
    
    self.stateLabel.attributedText = [[NSAttributedString alloc] initWithString:tip attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:SYS_FONT(12)}];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
