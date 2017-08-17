//
//  FADefines.h
//  FunApp
//
//  Created by chunhui on 16/6/2.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#ifndef FADefines_h
#define FADefines_h

// NSUserDefaults的系统单例
#define Defaults [NSUserDefaults standardUserDefaults]
// NSNotification
#define NotificationCenter [NSNotificationCenter defaultCenter]
// Null To Nil
#define NULL_TO_NIL(__objc) ((id)[NSNull null] == (__objc) ? nil : (__objc))
// Check is Dictionary
#define IsDictionaryClass(__obj) ((__obj) && [(__obj) isKindOfClass:[NSDictionary class]])
// Check is Array
#define IsArrayClass(__obj) ((__obj) && [(__obj) isKindOfClass:[NSArray class]])
// 把字符串首尾的空格和回车去掉
#define TrimStr(__str) [(__str) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

// 界面所有颜色定义
#define COLOR_NAVIGATION        HexColor(0xfc461e) // 导航栏背景色
#define COLOR_BLACK_NORMAL      HexColor(0x333333) // 基准黑色
#define COLOR_GRAY              HexColor(0xaaaaaa) // 灰色
#define COLOR_GRAY2             HexColor(0xb5b5b5) // 灰色2
#define COLOR_GRAY3             HexColor(0x999999) // 灰色3
#define COLOR_NAME              HexColor(0x748da5) // 名字颜色，例如公众好名
#define COLOR_DIVIDE_LIGHT      HexColor(0xe5e5e5) // 分割线颜色（浅）
#define COLOR_DIVIDE_HARD       HexColor(0xb2b2b2) // 分割线颜色（重）
#define COLOR_CONTENT1          HexColor(0x707070) // 内容颜色（其中一种）
#define COLOR_BOTTOM_BAR        HexColor(0xf5f5f5) // 底部栏背景色
#define COLOR_LIGHT_BLACK       HexColor(0x666666) // 浅黑色
#define COLOR_DARK_BLUE         HexColor(0x448aca) // 深蓝
#define COLOR_Light_BLUE        HexColor(0x889aac) // 淡蓝色
#define COLOR_GREEN_NORMAL      HexColor(0x3fb752) // 绿色



#define kMaxReplyCount         280 //评论最大字符数
#define kMaxDeployCount        500 //发帖
#define kMinNickNameCount      2   //昵称
#define kMaxNickNameCount      16  //昵称
#define kMaxSignCount          30 //签名

#define SYS_FONT(size)      [UIFont systemFontOfSize:size]
#define SYS_BOLD_FONT(size) [UIFont boldSystemFontOfSize:size]
#define SYS_IMG(name)       [UIImage imageNamed:name]

#define HWDefaultPhoto      [UIImage imageNamed:@"icon_head"]

#define kNotiShareWenyouQuanSuccess @"kNotiShareWenyouQuanSuccess" // 直播分享到文友圈成功

#define kAppSlideConfigUpdateNotification @"kAppSlideConfigUpdateNotification" //新闻配置更新
#define kAppSlideConfigSucceedNotification @"kAppSlideConfigSucceedNotification" //新闻配置更新成功
#define kAppSlideConfigFailedNotification @"kAppSlideConfigFailedNotification" //新闻配置更新失败

#define kCollectionChangedNotification @"kCollectionChangedNotification" //收藏更新

#define kConcernChangedNotification @"kConcernChangedNotification" //关注更新

//引导页提醒
#define kUserDefaultsFirstOpenTheApp              @"UserDefaultsFirstOpenTheApp"

#endif /* FADefines_h */
