//
//  EATaskSlideListViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseTableViewController.h"
#import "TKSwitchSlidePageItemViewControllerProtocol.h"

@class EATaskDataListModel;
@interface EATaskSlideListViewController : EABaseTableViewController<TKSwitchSlidePageItemViewControllerProtocol>

@property(nonatomic , strong) NSString *taskType;
@property(nonatomic , copy) void (^showTaskBlock)(EATaskDataListModel *task);

@end
