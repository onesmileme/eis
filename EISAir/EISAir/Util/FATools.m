//
//  FATools.m
//  FunApp
//
//  Created by wangyan on 16/7/27.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "FATools.h"
#import "MBProgressHUD.h"

@implementation FATools
+ (UIWindow *)keyWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!window) {
        window = [[[UIApplication sharedApplication] windows] firstObject];
    }
    return window;
}

+ (void)showToast:(NSString *)toast {
    [self showToast:toast time:1];
}

+ (void)showLongToast:(NSString *)toast {
    [self showToast:toast time:2];
}

+ (void)showToast:(NSString *)toast time:(float)time {
    [self showToast:toast time:time lineBreak:NO];
}

+ (void)showToast:(NSString *)toast time:(float)time lineBreak:(BOOL)lineBreak {
    if (!toast.length) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self keyWindow] animated:YES];

    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = toast;
    hud.label.numberOfLines = (lineBreak? 0: 1);
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;

    [hud hideAnimated:true afterDelay:time];
}

+ (void)showLoadingOnView:(UIView *)view {
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)hideLoadingOnView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (MBProgressHUD *)showLoadHUD:(UIView *)inView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
    
    return hud;
}

@end
