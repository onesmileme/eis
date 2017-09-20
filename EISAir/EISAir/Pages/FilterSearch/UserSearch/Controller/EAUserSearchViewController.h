//
//  EAUserSearchViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseTableViewController.h"

@class EAUserDataListModel;
@interface EAUserSearchViewController : EABaseTableViewController

@property(nonatomic ,copy) void (^chooseUserBlock)(EAUserDataListModel *user);

@end
