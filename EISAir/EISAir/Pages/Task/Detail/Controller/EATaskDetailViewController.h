//
//  EATaskDetailViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseTableViewController.h"

@class EATaskDataListModel;
@interface EATaskDetailViewController : EABaseTableViewController

@property(nonatomic , strong) EATaskDataListModel *task;

+(instancetype)controller;

@end
