//
//  EAHomeHeaderView.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAHomeHeaderView.h"
#import "EALoginUserInfoModel.h"
#import "TKRequestHandler+UploadImage.h"
#import "TKAccountManager.h"

@implementation EAHomeHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tipWidthConstraint.constant = SCREEN_WIDTH/3;
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.width/2;
    self.avatarImageView.layer.masksToBounds = true;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarAction:)];
    [self.avatarImageView addGestureRecognizer:gesture];
}

-(void)tapAvatarAction:(UITapGestureRecognizer *)gesture
{
    if (_tapAvatarBlock) {
        _tapAvatarBlock();
    }
}

-(void)updateModel:(EALoginUserInfoDataModel *)model
{
    /*
     @property(nonatomic , strong) IBOutlet UIImageView *bgImageView;
     @property(nonatomic , strong) IBOutlet UIImageView *avatarImageView;
     @property(nonatomic , strong) IBOutlet UILabel *nameLabel;
     @property(nonatomic , strong) IBOutlet UILabel *jobLabel;
     
     @property(nonatomic , strong) IBOutlet UILabel *doneCountLabel;
     @property(nonatomic , strong) IBOutlet UILabel *recordCountLabel;
     @property(nonatomic , strong) IBOutlet UILabel *reportCountLabel;
     */
    
//    NSURL *avatar = [NSURL URLWithString:model];
//    [self.avatarImageView sd_setImageWithURL:avatar];

    _nameLabel.text = model.personName;
    _jobLabel.text = model.roleName;
    NSURL *imgUrl = [NSURL URLWithString:model.avatar];
    if (!imgUrl) {
        __weak typeof(self) wself = self;
        [[TKRequestHandler sharedInstance] loadUserImage:nil completion:^(NSURLSessionTask *task, NSString *imgUrl, NSError *error) {
            
            if (imgUrl ) {
                if (wself) {
                    NSURL *url = [NSURL URLWithString:imgUrl];
                    [wself.avatarImageView sd_setImageWithURL:url];
                }
                
                model.avatar = imgUrl;
                [TKAccountManager sharedInstance].loginUserInfo.avatar = imgUrl;
                [[TKAccountManager sharedInstance] save];
            }
            
            
        }];
    }else{
        [self.avatarImageView sd_setImageWithURL:imgUrl placeholderImage:nil];
    }
}

-(void)updateTask:(NSInteger)task record:(NSInteger)record report:(NSInteger)report
{
    self.doneCountLabel.attributedText = [self countStr:task];
    self.recordCountLabel.attributedText = [self countStr:record];
    self.reportCountLabel.attributedText = [self countStr:report];
}

-(NSAttributedString *)countStr:(NSInteger)count
{
    NSString *str = [NSString stringWithFormat:@"%ld个",count];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:SYS_FONT(27.5),NSForegroundColorAttributeName:HexColor(0x00b0ce)}];
    
    [attrStr addAttributes:@{NSForegroundColorAttributeName:HexColor(0xbebebe),NSFontAttributeName:SYS_FONT(11)} range:NSMakeRange(str.length -1, 1)];
    
    return attrStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
