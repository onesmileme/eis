//
//  EATaskDetailEditViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

typedef NS_ENUM(NSInteger , EATaskEditType) {
    EATaskEditTypeAssign = 0 , //交接给
    EATaskEditTypeReject = 1,//拒绝
    EATaskEditTypeExecute = 2, //执行
};

@class EAUserDataListModel;
@class EATaskDataListModel;
/*
 * 指派他人或者拒绝页面
 */
@interface EATaskDetailEditViewController : EABaseViewController

@property(nonatomic , copy) NSString *placeHoder;
@property(nonatomic , assign) BOOL showAssign;
//@property(nonatomic , assign) BOOL isRefuse;
@property(nonatomic , assign) EATaskEditType editType;

@property(nonatomic , strong) EATaskDataListModel *task;

@property(nonatomic , copy) void (^doneBlock)(NSString *content ,EAUserDataListModel *user);

@end
