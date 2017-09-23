//
//  EAMsgSearchFilterTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgSearchFilterTableViewCell.h"

@interface EAMsgSearchFilterTableViewCell ()

@property(nonatomic , strong) IBOutlet UIImageView *chooseImageView;
@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UILabel *msgLabel;

@end

@implementation EAMsgSearchFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(BOOL)checked
{
    return _chooseImageView.highlighted;
}

-(IBAction)checkAction:(id)sender
{
    _chooseImageView.highlighted = !_chooseImageView.highlighted;
    if (_chooseBlock) {
        _chooseBlock(self,nil , _chooseImageView.highlighted);
    }
}

-(void)updateTitle:(NSString *)title msg:(NSString *)msg checked:(BOOL)checked
{
    _titleLabel.text = title;
    _msgLabel.text = msg;
    _chooseImageView.highlighted = checked;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    _chooseImageView.highlighted = selected;
}

@end
