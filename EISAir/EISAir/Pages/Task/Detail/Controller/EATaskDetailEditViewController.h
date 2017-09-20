//
//  EATaskDetailEditViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"
@class EAUserDataListModel;
/*
 * 指派他人或者拒绝页面
 */
@interface EATaskDetailEditViewController : EABaseViewController

@property(nonatomic , copy) NSString *placeHoder;
@property(nonatomic , assign) BOOL showAssign;

@property(nonatomic , copy) void (^doneBlock)(NSString *content ,EAUserDataListModel *user);

@end
