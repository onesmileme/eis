//
//  EATaskInfoTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskInfoTableViewCell.h"
#import "NSString+TKSize.h"
#import "EATaskModel.h"
#import "TKCommonTools.h"

@interface EATaskInfoTableViewCell ()

@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UILabel *stateLabel;
@property(nonatomic , strong) IBOutlet UILabel *dateLabel;
@property(nonatomic , strong) IBOutlet UILabel *typeLabel;
@property(nonatomic , strong) IBOutlet UILabel *infoLabel;

@end

@implementation EATaskInfoTableViewCell

+(UIColor *)colorForStatus:(NSString *)status
{
    static NSDictionary *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{@"wait":HexColor(0xffb549) ,@"execute":HexColor(0x058497) ,@"finish":HexColor(0x28CFC1) , @"invalid":HexColor(0xECECEC)};
    });
    return dict[status];
}

+(CGFloat)heightForModel:(EATaskDataListModel *)model
{
    CGFloat height = 78;
    
    if (model.taskDescription.length > 0) {
        height += [model.taskDescription sizeWithMaxWidth:(SCREEN_WIDTH - 29) font:SYS_FONT(14)].height;
    }

    return height;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.stateLabel.layer.cornerRadius = 4;
    self.stateLabel.layer.masksToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithModel:(EATaskDataListModel *)model
{
    self.titleLabel.text = model.taskName;
    self.stateLabel.text = [[EATaskHelper sharedInstance] valueForStatus:model.taskStatus];
    self.typeLabel.text = [model.objNameList componentsJoinedByString:@" "];
    self.infoLabel.text = model.taskDescription;
    
    NSString *dateStr = model.updateDate?:model.createDate;
    NSDate *date = [TKCommonTools dateWithFormat:TKDateFormatChineseLongYMD dateString:dateStr];
    
    self.dateLabel.text = [TKCommonTools dateDescForDate:date];        
}

@end
