//
//  EAMessageTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageTableViewCell.h"
#import "EAMessageModel.h"

@interface EAMessageTableViewCell ()

@property(nonatomic , strong) IBOutlet UIImageView *avatar;
@property(nonatomic , strong) IBOutlet UIImageView *reddot;
@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UILabel *contentLabel;
@property(nonatomic , strong) IBOutlet UILabel *dateLabel;


@end

@implementation EAMessageTableViewCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _avatar.layer.cornerRadius = _avatar.width/2;
    _avatar.layer.masksToBounds = true;
    _reddot.layer.cornerRadius = _reddot.width/2;
    _reddot.layer.masksToBounds = true;
    
    _reddot.backgroundColor = [UIColor orangeColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithModel:(EAMessageDataListModel *)model
{    
    _titleLabel.text = model.msgTitle;
    _contentLabel.text = model.msgContent;
    _dateLabel.text = model.createDate;
}

@end
