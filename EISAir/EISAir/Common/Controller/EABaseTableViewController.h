//
//  FABaseTableViewController.h
//  CaiLianShe
//
//  Created by chunhui on 16/3/2.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Refresh.h"

@interface EABaseTableViewController : UITableViewController
/**
 *  是否定制导航栏返回返回
 *  默认是yes
 */
@property(nonatomic , assign) BOOL customBackItem;

//是否定制刷新提示 默认yes
@property (nonatomic, assign) BOOL customRefreshTip;

@property (nonatomic, copy) NSString *pageName;

//是否进行页面时长统计
@property (nonatomic, assign) BOOL pagedurationLog;

+(instancetype)nibController;

/**
 *  点击导航栏返回是调用的方法
 */
-(void)backAction;

//-(void)initNavbarTitle;
@end
