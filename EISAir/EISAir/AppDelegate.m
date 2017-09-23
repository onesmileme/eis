//
//  AppDelegate.m
//  EISAir
//
//  Created by chunhui on 2017/8/15.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "AppDelegate.h"
#import "EAUIInitManager.h"
#import "EANetworkManager.h"
#import "ViewController.h"
#import "EALoginViewController.h"
#import "TKAccountManager.h"

#import "EAFindPassordViewController.h"
#import "EADefines.h"
#import "TKGuideViewController.h"
#import "TKAppInfo.h"

@interface AppDelegate ()

@property(nonatomic , strong) UINavigationController *rootNavController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    application.statusBarHidden = false;
    
    [EAUIInitManager sharedInstance];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.mainController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    self.rootNavController = [[UINavigationController alloc] initWithRootViewController:self.mainController];
    [self.rootNavController setNavigationBarHidden:YES animated:true];
    self.window.rootViewController = self.rootNavController;
    [self.window makeKeyAndVisible];
    

    [EANetworkManager sharedInstance];
    
    if (![[TKAccountManager sharedInstance] isLogin]) {
        [self showLogin];
    }
    
    [self checkShowGuide];
    
    [NotificationCenter addObserver:self selector:@selector(loginDoneNotification:) name:kLoginDoneNotification object:nil];
    [NotificationCenter addObserver:self selector:@selector(logoutNotification:) name:kLogoutNotification object:nil];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)showLogin
{
    EALoginViewController *controller = [[EALoginViewController alloc]initWithNibName:@"EALoginViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = nav;
}

-(void)loginDoneNotification:(NSNotification *)notification
{
    if([notification.userInfo[@"refresh"] boolValue]){
        
    }else{
        
        self.window.rootViewController = self.rootNavController;
        [self.mainController reloadAll];
    }
}

-(void)logoutNotification:(NSNotification *)notification
{
    [self showLogin];
}

#if 1
/**
 *  检查是否需要引导页
 */
- (BOOL)checkShowGuide
{
    NSString *lastShowVersion  = [[NSUserDefaults standardUserDefaults] objectForKey: kUserDefaultsFirstOpenTheApp];
    
    NSString *appVersion = [TKAppInfo appVersion];
    
    if (![lastShowVersion isKindOfClass:[NSString class]] || lastShowVersion.length == 0 || ![lastShowVersion isEqualToString:appVersion])
    {
        
        NSMutableArray * images = [[NSMutableArray alloc]init];
        
        for (int index = 1; index <= 4; index++)
        {
            UIImage *image;
//            if (IsIphone4x) {
//                image = [UIImage imageNamed: [NSString stringWithFormat: @"guide_%d_4.jpg",index]];
//            }else{
                image = [UIImage imageNamed: [NSString stringWithFormat: @"guide_6_%d.jpg",index]];
//            }
            
            if (image) {
                [images addObject:image];
            }
        }
        
        if (images.count > 0) {
            TKGuideViewController *controller = [[TKGuideViewController alloc]initWithNibName:nil bundle:nil];
            
            controller.guideImages = images;
            controller.tapLastToQuit = true;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.window.rootViewController presentViewController:controller animated:false completion:nil];
            });
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey: kUserDefaultsFirstOpenTheApp];
        
        return YES;
    }
    return NO;
}

#endif

@end
