//
//  FATools.h
//  FunApp
//
//  Created by wangyan on 16/7/27.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface FATools : NSObject

// Toast
+ (void)showToast:(NSString *)toast;
+ (void)showLongToast:(NSString *)toast;

+ (void)showToast:(NSString *)toast time:(float)time lineBreak:(BOOL)lineBreak;

+ (void)showLoadingOnView:(UIView *)view;
+ (void)hideLoadingOnView:(UIView *)view;

+ (MBProgressHUD *)showLoadHUD:(UIView *)inView;

@end
