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
@property(nonatomic , strong) IBOutlet UILabel *avatarLabel;
@property(nonatomic , strong) IBOutlet UIImageView *reddot;
@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UILabel *contentLabel;
@property(nonatomic , strong) IBOutlet UILabel *dateLabel;


@end

@implementation EAMessageTableViewCell

+(NSDictionary *)avatarBgDict
{
            /*
              *  "EIS_MSG_TYPE_NOTICE": "通知",
              *  "EIS_MSG_TYPE_ALARM": "报警",
              *  "EIS_MSG_TYPE_RECORD": "人工记录",
              *  "EIS_MSG_TYPE_EXCEPTION": "异常"
             <color name="icon_bg_warn">#FFB549</color>
             <color name="icon_bg_user">#00B0CE</color>
             <color name="icon_bg_err">#FF6663 </color>
             <color name="icon_bg_notice">#28CFC1 </color>
             
              */
    static NSDictionary *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{@"EIS_MSG_TYPE_NOTICE":@(0X28CFC1),
                 @"EIS_MSG_TYPE_ALARM":@(0XFFB549),
                 @"EIS_MSG_TYPE_RECORD":@(0X00B0CE),
                 @"EIS_MSG_TYPE_EXCEPTION":@(0XFF6663)
                 };
    });
    return dict;
}

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
    _avatarLabel.text = [model.msgTitle substringToIndex:4];    
    NSNumber *num = [[self class] avatarBgDict][model.msgType];
    NSInteger hexColor =  [num integerValue];
    _avatarLabel.backgroundColor = HexColor(hexColor);
    
    _titleLabel.text = model.msgTitle;
    _contentLabel.text = model.msgContent;
    _dateLabel.text = model.createDate;
}

@end
