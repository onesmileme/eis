//
//  EAUserInfoViewController.h
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseTableViewController.h"

@class EALoginUserInfoDataModel;
@interface EAUserInfoViewController : EABaseTableViewController

@property(nonatomic , strong)  EALoginUserInfoDataModel *userInfo;

+(instancetype)controller;

@end