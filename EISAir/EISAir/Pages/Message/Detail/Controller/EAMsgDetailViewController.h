//
//  EAMsgDetailViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseTableViewController.h"
@class EAMessageDataListModel;
@interface EAMsgDetailViewController : EABaseTableViewController

@property(nonatomic , strong) EAMessageDataListModel *msgModel;

@end
