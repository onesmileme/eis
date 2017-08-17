//
//  EABaseViewController.h
//  EIS
//
//  Created by chunhui on 16/3/2.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import "TKViewController.h"
#import "UIViewController+Refresh.h"

@interface EABaseViewController : TKViewController

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

/**
 *  点击导航栏返回是调用的方法
*/
-(void)backAction;

//-(void)initNavbarTitle;
- (void)addRightButtonWithTitle:(NSString *)title;
@end
