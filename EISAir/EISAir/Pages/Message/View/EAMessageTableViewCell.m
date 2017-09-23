//
//  EAMessageTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageTableViewCell.h"
#import "EAMessageModel.h"
#import "EAMsgHelper.h"
#import "TKAccountManager.h"

@interface EAMessageTableViewCell ()

@property(nonatomic , strong) IBOutlet UIImageView *avatar;
@property(nonatomic , strong) IBOutlet UILabel *avatarLabel;
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
    _avatarLabel.layer.cornerRadius = _avatarLabel.width/2;
    _avatarLabel.layer.masksToBounds = true;
    
    _reddot.layer.cornerRadius = _reddot.width/2;
    _reddot.layer.masksToBounds = true;
    _reddot.backgroundColor = HexColor(0xff5500);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithModel:(EAMessageDataListModel *)model
{
    
    EALoginUserInfoDataModel *userinfo = [[TKAccountManager sharedInstance]loginUserInfo];
    BOOL read = false;
    for (EAMessageDataListMessageFollowersModel *follower in model.messageFollowers) {
        if ([follower.personId isEqualToString:userinfo.personId]) {
            read = true;
            break;
        }
    }
    
    _reddot.hidden = read;    
    _avatarLabel.text = [model.msgTitle substringToIndex:model.msgTitle.length > 4?3:model.msgTitle.length-1];
    _avatarLabel.backgroundColor = [EAMsgHelper colorForMsgType:model.msgType];
    
    NSString *title = nil;
    if (model.msgTitle.length >= 4) {
        title = [NSString stringWithFormat:@"%@\n%@",[model.msgTitle substringToIndex:2],[model.msgTitle substringWithRange:NSMakeRange(2, 2)]];
    }else if(model.msgTitle.length > 0){
        title = model.msgTitle;
    }else{
        title = [EAMsgHelper detailTagForMsgType:model.msgType];
    }
    
    _avatarLabel.text = title;
    
    if ([model.msgType isEqualToString:EIS_MSG_TYPE_RECORD] && model.avatar.length > 0) {
        
        _avatar.hidden = false;
        NSURL *url = [NSURL URLWithString:model.avatar];
        [_avatar sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                
            }
        }];
        
    }else{
        _avatar.hidden = true;
    }
    
    _titleLabel.text = model.msgTitle;
    _contentLabel.text = model.msgContent;
    _dateLabel.text = model.createDate;
}

@end
