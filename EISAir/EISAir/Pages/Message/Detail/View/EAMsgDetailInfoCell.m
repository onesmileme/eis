//
//  EAMsgDetailInfoCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgDetailInfoCell.h"

@interface EAMsgDetailInfoCell()

@property(nonatomic , strong) IBOutlet UILabel *tagLabel;
@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UILabel *infoLabel;

@end

@implementation EAMsgDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tagLabel.layer.cornerRadius = self.tagLabel.width/2;
    self.tagLabel.layer.masksToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithModel:(EAMessageDataListModel *)model
{
    _titleLabel.text = model.msgTitle;
    _infoLabel.text = model.msgContent;
}


@end
