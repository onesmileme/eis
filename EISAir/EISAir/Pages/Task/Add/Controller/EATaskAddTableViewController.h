//
//  EATaskAddTableViewController.h
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

@class EATaskDataListModel;
@interface EATaskAddTableViewController : EABaseViewController

@property(nonatomic , strong) EATaskDataListModel *task;
@property(nonatomic , copy) void (^completionBlock)();
+(instancetype)controller;

@end
