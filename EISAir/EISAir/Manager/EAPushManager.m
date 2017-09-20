//
//  FAPushManager.m
//  FunApp
//
//  Created by chunhui on 2016/8/8.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EAPushManager.h"
#import "TKModuleWebViewController.h"
#import "AppDelegate.h"
//#import "FATweetDetailViewController.h"
//#import "FATopicViewController.h"
//#import "FATopicModel.h"
//#import "FAMomentDetailViewController.h"
//#import "FALivePlayerViewController.h"
//#import "FALiveModel.h"
//#import "FAConfigManager.h"
//#import "FAMyMessageViewController.h"
//#import "FARelationViewController.h"
#import "TKAccountManager.h"
#import "TKRequestHandler+Push.h"
#import "EANetworkManager.h"
#import "EALoginViewController.h"
#import "EASettingViewController.h"
#import "EAHomeViewController.h"

@import UserNotifications;

#define kUserJPush  0

#define kScheme @"eis"

@interface EAPushManager ()<UNUserNotificationCenterDelegate>

@property(nonatomic , strong) NSMutableDictionary *handlesDic;

@property(nonatomic , strong) NSString *deviceToken;
@property(nonatomic , strong) NSString *msgId;


@end



@implementation EAPushManager

//+(void)load
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
////        [[FAPushManager sharedInstance]handleSystemMsg:nil];
//        NSString *url = @"appfac://private_msg?search_uid=oqRwHwWYBWDiR3idB4tBvUsXqbk0";//
//        [[FAPushManager sharedInstance]handleOpenUrl:url];
//        
//    });
//}


IMP_SINGLETON

+(NSString *)scheme
{
    return kScheme;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLoginDoneNotification:) name:kLoginDoneNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogoutNotification:) name:kLogoutNotification object:nil];
        
#if kUserJPush
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jpushLoginDoneNotification:) name:kJPFNetworkDidLoginNotification object:nil];
#endif
    
        
        [self registerHandles];
    }
    return self;
}

-(void)registerPushConfigWithLauchOptions:(NSDictionary *)launchOptions
{
#if kUserJPush
    //推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey channel:kJPushChannel apsForProduction:true];
    
    
#if DEBUG
    //    [JPUSHService setDebugMode];
#else
    [JPUSHService setLogOFF];
#endif

#else

    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10) {
//        
//        [[UNUserNotificationCenter currentNotificationCenter]setDelegate:self];
//        UNAuthorizationOptions option = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
//        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:option completionHandler:^(BOOL granted, NSError * _Nullable error) {
//            
//        }];
//    }else{
    
    UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
    [[UIApplication sharedApplication]registerUserNotificationSettings:notificationSettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
//    }
    
#endif
    
}

-(void)registerDeviceToken:(NSData *)deviceToken
{
        
    unsigned char *bytes = (unsigned char *)[deviceToken bytes];
    NSMutableString *token = [[NSMutableString alloc]initWithCapacity:deviceToken.length];
    for (int i = 0 ; i < deviceToken.length; i++) {
        [token appendFormat:@"%02x",bytes[i]];
    }
    self.deviceToken = [token copy];
    
    [self pushBind:true completion:nil];
}


    
- (void)registerHandles
{
    _handlesDic = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
    
    _handlesDic[@"show_login"] = ^(NSDictionary *param){
        [weakSelf handleShowLogin:param];
    };

    _handlesDic[@"show_setting"] = ^(NSDictionary *param){
        [weakSelf showSetting:param];
    };
    
    _handlesDic[@"show_home"] = ^(NSDictionary *param)
    {
        [weakSelf showHome:param];
    };
    
//    _handlesDic[@"h5"] = ^(NSDictionary *param){
//        [weakSelf handleWeb:param];
//    };
//    _handlesDic[@"tweet"] = ^(NSDictionary *param){
//        [weakSelf handleTweet:param];
//    };
//    
//    _handlesDic[@"topic"] = ^(NSDictionary *param){
//        [weakSelf handleTopic:param];
//    };
//    
//    _handlesDic[@"moments"] = ^(NSDictionary *param){
//        [weakSelf handleMoments:param];
//    };
//    _handlesDic[@"live_play"] = ^(NSDictionary *param){
//        [weakSelf handleLive:param];
//    };
//    
//    _handlesDic[@"sys_msg"] = ^(NSDictionary *param){
//        [weakSelf handleSystemMsg:param];
//    };
//    
//    _handlesDic[@"my_fans"] = ^(NSDictionary *param){
//        [weakSelf handleFans:param];
//    };
//    
//    _handlesDic[@"private_msg"] = ^(NSDictionary *param){
//        [weakSelf handlePrivateMsg:param];
//    };
//    
//    _handlesDic[@"user_verify"] = ^(NSDictionary *param){
//        [weakSelf handleShowMyTab:param];
//    };
//    
//
//    _handlesDic[@"group_detail"] = ^(NSDictionary *param){
//        [weakSelf handleShowGroup:param];
//    };
//    
//    _handlesDic[@"user_home"] = ^(NSDictionary *param){
//        [weakSelf handleUserHome:param];
//    };
    
}

#pragma mark - handle push
-(void)handlePush:(NSDictionary *)info
{
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        
        NSString *scheme = info[@"schema"];
        if (scheme.length == 0) {
            return;
        }
        [self handleBackgroundOpenUrl:scheme];
        return;
    }
    
    
    NSString *scheme = info[@"schema"];
    if (scheme.length == 0) {
        return;
    }
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        __weak typeof(self) wself = self;
        [self showTipAlert:info showGoto:true confirm:^(BOOL showGoto) {
            [wself handleOpenUrl:scheme];
        }];
    }else{
        [self handleOpenUrl:scheme];
    }
}

-(void)handleOpenUrl:(NSString *)openUrl
{
    NSURL *url = nil;
    if ([openUrl isKindOfClass:[NSString class]]) {
        if (![openUrl containsString:@"%"]) {
            openUrl = [openUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        url =  [NSURL URLWithString:openUrl];
    }else if ([openUrl isKindOfClass:[NSURL class]]){
        url = (NSURL *)openUrl;
    }else{
        return;
    }
    
    NSString *scheme = [[url scheme] lowercaseString];
    NSString *host = url.host;
    NSString *query = url.query;
    if (url == nil) {
        NSInteger index = [openUrl rangeOfString:@":"].location;
        scheme = [openUrl substringToIndex:index];
        NSInteger pathIndex = [openUrl rangeOfString:@"?"].location;
        if (pathIndex < 0 || pathIndex >= openUrl.length ) {
            //没有
            host = [openUrl substringFromIndex:index+1];
        }else{
            index += 3;// ://
            host = [openUrl substringWithRange:NSMakeRange(index, pathIndex - index)];
            query = [openUrl substringFromIndex:pathIndex+1];
        }
    }
    
    if ([scheme isEqualToString:kScheme]) {
        
        /*
         
         1. 深度列表跳详情(新闻链接一样)：cailianshe://article_detail?article_id=xxx
         2. 深度详情页，跳股票页面的schema：cailianshe://stock_detail?stock_id=xxx
         3. 内参列表页跳转详情：cailianshe://article_inter_detail?article_id=xxx
         4. 内参详情页，更多xx按钮，跳转schema：cailianshe://article_inter_list?list_id=xxx
         */
        
        NSDictionary *param = [[self class] processUrlQuery:query];
        void (^handleAction )(NSDictionary *) = _handlesDic[host];
        if (handleAction) {
            handleAction(param);
//        }else{
//            [self showNeedVersionUpdateTip];
        }
        
    } else if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
        
        [self handleWeb:@{@"url":openUrl}];
    }else{
        
        [self showNeedVersionUpdateTip];
        
    }
}
/*
 * 后台时判断并处理url
 */
-(void)handleBackgroundOpenUrl:(NSString *)openUrl
{
    NSURL *url = nil;
    if ([openUrl isKindOfClass:[NSString class]]) {
        if (![openUrl containsString:@"%"]) {
            openUrl = [openUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        url =  [NSURL URLWithString:openUrl];
    }else if ([openUrl isKindOfClass:[NSURL class]]){
        url = (NSURL *)openUrl;
    }else{
        return;
    }
    
    NSString *scheme = [[url scheme] lowercaseString];
    NSString *host = url.host;
    NSString *query = url.query;
    if (url == nil) {
        NSInteger index = [openUrl rangeOfString:@":"].location;
        scheme = [openUrl substringToIndex:index];
        NSInteger pathIndex = [openUrl rangeOfString:@"?"].location;
        if (pathIndex < 0 || pathIndex >= openUrl.length ) {
            //没有
            host = [openUrl substringFromIndex:index+1];
        }else{
            index += 3;// ://
            host = [openUrl substringWithRange:NSMakeRange(index, pathIndex - index)];
            query = [openUrl substringFromIndex:pathIndex+1];
        }
    }
    
    if ([scheme isEqualToString:kScheme]) {
        
        if ([host isEqualToString:@"user_verify"]) {
            //后台处理用户认证更新
            NSDictionary *param = [[self class] processUrlQuery:query];
            void (^handleAction )(NSDictionary *) = _handlesDic[host];
            if (handleAction) {
                handleAction(param);
            }
        }
    }
    
}


/**
 *  显示确认提示
 *
 *  @param info     push消息
 *  @param showGoto yes 显示 需要前往查看
 *  @param confirm  确定回调
 */
-(void)showTipAlert:(NSDictionary *)info showGoto:(BOOL)showGoto confirm:(void(^)(BOOL showGoto))confirm
{
    NSDictionary *apsDic = [info objectForKey:@"aps"];
    
    if ([apsDic count] == 0) {
        return;
    }
    
    NSMutableString *alertString = [[NSMutableString alloc]init];
    [alertString appendString:apsDic[@"alert"]];
    
    if (showGoto) {
        [alertString appendString:@" 您要前往查看吗？"];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:alertString preferredStyle:UIAlertControllerStyleAlert];
    
    if (showGoto) {
        
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"前往查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            confirm(true);
        }];
        
        [alert addAction:showAction];
        
        UIAlertAction *laterAction = [UIAlertAction actionWithTitle:@"以后再看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:laterAction];;

    }else{
        
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            confirm(false);
        }];
        
        [alert addAction:showAction];
        
    }
    

    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *rootController = delegate.mainController.navigationController;
    [rootController presentViewController:alert animated:true completion:nil];
    
}

-(void)showNeedVersionUpdateTip
{
    //提醒版本更新
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您的当前版本过低，请升级至最新版本" preferredStyle:UIAlertControllerStyleAlert];
    
    
    NSString *appId = @"";//[[FAConfigManager sharedInstance]appId];
    if (appId.length > 0) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"马上升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *strUrl = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@",appId];
            NSURL *url = [NSURL URLWithString:strUrl];
            [[UIApplication sharedApplication]openURL:url];
        }];
        
        [alertController addAction:action];
        
        action = [UIAlertAction actionWithTitle:@"暂不升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
        
    }else{
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
    }
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *rootController = delegate.mainController.navigationController;
    [rootController presentViewController:alertController animated:true completion:nil];

}


#pragma handle push items
-(void)handleWeb:(NSDictionary *)param
{
    NSString *openUrl = param[@"url"];
    TKModuleWebViewController *viewController = [[TKModuleWebViewController alloc] init];
    [viewController loadRequestWithUrl:openUrl];
    viewController.backImage = [UIImage imageNamed:@"nav_back"];
    viewController.progressBarColor = [UIColor themeRedColor];
    viewController.backByStep = YES;
    viewController.closeTitle = nil;//@"关闭";
    viewController.closeColor = [UIColor themeRedColor];
    viewController.hiddenTitle = NO;
    viewController.titleColor = [UIColor themeRedColor];
    
    [self pushViewController:viewController];

}

- (void)handleShowLogin:(NSDictionary *)param
{
    UIViewController *controller = nil;

    UINavigationController *rootController = [EABaseViewController currentNavigationController];
    if (![rootController isKindOfClass:[UINavigationController class]]) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        rootController = delegate.mainController.navigationController;
    }
    for (UIViewController *con in [rootController viewControllers]) {
        if ([con isKindOfClass:[EALoginViewController class]]) {
            return;
        }
    }
    
    EALoginViewController *loginVC = [[EALoginViewController alloc] initWithNibName:@"EALoginViewController" bundle:nil];
    controller = loginVC;
    
    
    
    [self pushViewController:controller];
}

-(void)showSetting:(NSDictionary *)param
{
    EASettingViewController *controller = [EASettingViewController controller];    
    [self pushViewController:controller];
}

-(void)showHome:(NSDictionary *)param
{
    EAHomeViewController *controller = [EAHomeViewController controller];
    [self pushViewController:controller];
}

#if 0

-(void)handleTweet:(NSDictionary *)param
{
    NSString *tid = param[@"id"];
    if (tid.length == 0) {
        return;
    }
    FATweetDetailViewController *controller = [[FATweetDetailViewController alloc]initWithNibName:nil bundle:nil];
    controller.tid = tid;
    
    [self pushViewController:controller];
}

-(void)handleTopic:(NSDictionary *)param
{
    NSString *tid = param[@"topic_id"];
    if (tid.length == 0) {
        tid = param[@"id"];
    }
    if (tid.length == 0) {
        return;
    }
    FATopicViewController *controller = [[FATopicViewController alloc]initWithNibName:nil bundle:nil];
    FATopicDataModel *model = [[FATopicDataModel alloc]init];
    model.id = tid;
    controller.topic = model;
    
    [self pushViewController:controller];
}

-(void)handleMoments:(NSDictionary *)param
{
    NSString *tid = param[@"id"];
    if (tid.length == 0) {
        return;
    }
    FAMomentDetailViewController *controller = [[FAMomentDetailViewController alloc]init];
    controller.tid = tid;
    
    [self pushViewController:controller];

}

-(void)handleLive:(NSDictionary *)param
{
    NSString *liveId = param[@"liveid"];
    if (liveId.length == 0) {
        return;
    }
    FALivePlayerViewController *controller = [[FALivePlayerViewController alloc]init];
    FALiveDataContentModel *liveModel = [[FALiveDataContentModel alloc]init];
    liveModel.liveId = liveId;
    controller.liveModel = liveModel;
    
    UIViewController *rootController =  [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [rootController presentViewController:controller animated:true completion:nil];
}

-(void)handleSystemMsg:(NSDictionary *)param
{
    FAMyMessageViewController *controller = [[FAMyMessageViewController alloc]init];
    
    [self pushViewController:controller];
}

-(void)handleFans:(NSDictionary *)param
{
    FARelationViewController *controller = [[FARelationViewController alloc]init];
    controller.uid = MYUID;
    controller.isFans = true;
    [self pushViewController:controller];
}

-(void)handlePrivateMsg:(NSDictionary *)param
{
    NSString *uid = param[@"search_uid"];
    if (uid.length == 0) {
        return;
    }
    FAPrivateMsgTalkViewController *controller = [[FAPrivateMsgTalkViewController alloc]initWithNibName:nil bundle:nil];
    controller.uid = uid;
    controller.name = param[@"nickname"];
    [self pushViewController:controller];
}

-(void)handleShowMyTab:(NSDictionary *)param
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *rootController = delegate.mainController.navigationController;
    [rootController popToRootViewControllerAnimated:true];
    delegate.mainController.selectedIndex = ([delegate.mainController.viewControllers count] - 1);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"VerifyUpdateNotification" object:nil];
}



-(void)handleShowGroup:(NSDictionary *)param
{
    NSString *gid = param[@"id"];
    if (gid.length == 0) {
        return;
    }
    
    FAGroupHomeViewController *controller = [[FAGroupHomeViewController alloc]init];
    controller.groupId = gid;
//    controller.name = group.name;
    controller.hidesBottomBarWhenPushed = true;
    
    [self pushViewController:controller];
}

-(void)handleUserHome:(NSDictionary *)param
{
    NSString *uid = param[@"uid"];
    if (uid.length == 0) {
        return;
    }
    FAUserHomeViewController *controller = [[FAUserHomeViewController alloc]init];
    controller.uid = uid;
    [self pushViewController:controller];
}

#endif

-(void)pushViewController:(UIViewController *)controller
{
    UINavigationController *rootController = [EABaseViewController currentNavigationController];
    if (![rootController isKindOfClass:[UINavigationController class]]) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        rootController = delegate.mainController.navigationController;        
    }
    controller.hidesBottomBarWhenPushed = true;
    [rootController pushViewController:controller animated:true];
}


/**
 *  推送绑定
 *
 *  @param isBind yes 进行绑定 no 解绑定
 */
-(void)pushBind:(BOOL)isBind completion:(void (^)(bool isOk))completion
{
//    if(self.pushRegisterId.length == 0 ){
//        if (completion) {
//            completion(NO);
//        }
//        return;
//    }

    if (self.deviceToken.length == 0) {
        if (completion) {
            completion(false);
        }
        return;
    }
    
    NSString *uid = MYUID;
    if (!isBind) {
        uid = uid.length == 0 ?  @"-1" : uid;
    }
    
    NSString *cuid = [[EANetworkManager sharedInstance]cuid];
    
    [[TKRequestHandler sharedInstance]bindPush:isBind cuid:cuid uid:uid deviceToken:self.deviceToken completion:^(NSURLSessionDataTask *task, NSDictionary *data) {
        
        if (completion) {
            BOOL isOk = NO;
            if(data && [data[@"error"] integerValue] == 0){
                isOk = YES;
            }
            completion(isOk);
        }
        
        
    }];
}


-(void)userLoginDoneNotification:(NSNotification *)notification
{
    [self pushBind:true completion:nil];
}

-(void)userLogoutNotification:(NSNotification *)notification
{
    [self pushBind:false completion:nil];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    NSLog(@"user info is: %@",userInfo);
    
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    NSDictionary *userinfo = response.notification.request.content.userInfo;
    
    [self handlePush:userinfo];
    
    completionHandler();
}

/**
 *  讲请求中k1=v1&k2=v2拆分
 *
 *  @param query 请求url
 *
 *  @return 拆分后的dict
 */
+(NSDictionary *)processUrlQuery:(NSString *)query
{
    if (query.length == 0) {
        return nil;
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    if (query.length > 0 ) {
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        for (NSString *pair in pairs) {
            NSArray *kv = [pair componentsSeparatedByString:@"="];
            if (kv.count == 2) {
                NSString *value = kv[1];
                if ([value containsString:@"%"]) {
                    value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                }
                param[kv[0]] = value;
            }
        }
    }
    
    return param;
}

/**
 *  获得url请求的 query
 *
 *  @param url url字符串
 *
 */
+(NSMutableDictionary *)processQuery:(NSString *)url
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSRange range = [url rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        NSString *query = [url substringFromIndex:range.location + range.length];
        NSDictionary *dict = [self processUrlQuery:query];
        [param addEntriesFromDictionary:dict];
        
    }
    
    return param;
    
}


@end


