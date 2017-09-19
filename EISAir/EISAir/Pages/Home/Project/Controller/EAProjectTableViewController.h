//
//  EAProjectTableViewController.h
//  EISAir
//
//  Created by chunhui on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseTableViewController.h"
#import "EALoginUserInfoModel.h"

@interface EAProjectTableViewController : EABaseTableViewController

@property(nonatomic , strong) EALoginUserInfoDataModel *userInfo;

+(instancetype)controller;

@end
