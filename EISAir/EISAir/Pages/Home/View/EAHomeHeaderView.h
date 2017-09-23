//
//  EAHomeHeaderView.h
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EALoginUserInfoDataModel;
@interface EAHomeHeaderView : UIView

@property(nonatomic , strong) IBOutlet UIImageView *bgImageView;
@property(nonatomic , strong) IBOutlet UIImageView *avatarImageView;
@property(nonatomic , strong) IBOutlet UILabel *nameLabel;
@property(nonatomic , strong) IBOutlet UILabel *jobLabel;

@property(nonatomic , strong) IBOutlet UILabel *doneCountLabel;
@property(nonatomic , strong) IBOutlet UILabel *recordCountLabel;
@property(nonatomic , strong) IBOutlet UILabel *reportCountLabel;

@property(nonatomic , strong) IBOutlet NSLayoutConstraint *tipWidthConstraint;

@property(nonatomic , copy) void (^tapAvatarBlock)();

-(void)updateModel:(EALoginUserInfoDataModel *)model;

@end
