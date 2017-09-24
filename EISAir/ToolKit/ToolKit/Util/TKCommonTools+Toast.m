//
//  TKCommonTools+Toast.m
//  ToolKit
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 chunhui. All rights reserved.
//

#import "TKCommonTools.h"
#import "MBProgressHUD.h"

@implementation TKCommonTools (Toast)

+ (void)showToastWithText:(NSString *)text inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:true];
    hud.label.text = text;
    [hud hideAnimated:true afterDelay:0.7];
}

@end
