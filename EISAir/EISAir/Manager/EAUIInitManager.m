//
//  FAUIInitManager.m
//  FunApp
//
//  Created by chunhui on 16/6/2.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EAUIInitManager.h"
#import <UIKit/UIKit.h>
#import "ImageHelper.h"
//#import "FAConfigManager.h"
#import "UIColor+Util.h"
#import "UIColor+Theme.h"

@implementation EAUIInitManager

IMP_SINGLETON

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initNavStyle];
        [self initTabStyle];
    }
    return self;
}

-(void)initNavStyle
{
//    NSDictionary *uiDict = [[FAConfigManager sharedInstance]uiDict];
//    
//    NSString *hexTextColor = uiDict[@"nav_title_color"];
//    UIColor *titleColor = [UIColor colorWithHexString:hexTextColor] ?: [UIColor whiteColor];
//    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:titleColor};
//    
//    
//    NSString *hexColor = uiDict[@"nav_color"];
//    bar.barTintColor = [UIColor colorWithHexString:hexColor];//HexColor(0x0076d1);//HexColor(0xffd200);
//    
//    UIImage *backImage = [UIImage imageNamed:@"navi_back"];
//    bar.backIndicatorImage = backImage;
//    bar.backIndicatorTransitionMaskImage = backImage;
//    bar.backItem.title = @"";
//    
//    UIImage *bgImage = [ImageHelper imageWithColor:bar.barTintColor size:CGSizeMake(2, 2)];
//    [bar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
//    bar.shadowImage = bgImage;
    
}

-(void)initTabStyle
{
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:HexColor(0x777777)} forState:UIControlStateNormal];

    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:HexColor(0xe84c3d)} forState:UIControlStateSelected];
    
    
//    UITabBar *bar = [UITabBar appearance];
//    bar.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    
}


@end
