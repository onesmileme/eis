//
//  ViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/15.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "ViewController.h"
#import "TKTabControllerIniter.h"
#import "TKAccountManager.h"
#import "TKRequestHandler+Account.h"
#import "MBProgressHUD.h"
#import "UIAlertView+BlocksKit.h"
#import "EAMessageViewController.h"
#import "EATaskViewController.h"
#import "EAReportViewController.h"
#import "EARecordViewController.h"
#import "EASubscribeViewController.h"
#import "EAAddRecordView.h"

@interface ViewController ()<UITabBarControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation ViewController

-(void)initItems
{
    TKTabControllerItem *message = [[TKTabControllerItem alloc]initWithControllerName:@"EAMessageViewController" title:@"" tabImageName:@"tab_news" selectedImageName:@"tab_news_pre"];
    message.addNavController = true;
    
    TKTabControllerItem *task = [[TKTabControllerItem alloc]initWithControllerName:@"EATaskViewController" title:@"" tabImageName:@"tab_task" selectedImageName:@"tab_task_pre"];
    task.addNavController = true;
    
   TKTabControllerItem *record = [[TKTabControllerItem alloc]initWithControllerName:@"EARecordViewController" title:@"" tabImageName:@"tab_add" selectedImageName:@"tab_add"];
    
    TKTabControllerItem *subscribe = [[TKTabControllerItem alloc]initWithControllerName:@"EASubscribeViewController" title:@"" tabImageName:@"tab_Subscribe" selectedImageName:@"tab_Subscribe_pre"];
    subscribe.addNavController = true;
    
    TKTabControllerItem *report = [[TKTabControllerItem alloc]initWithControllerName:@"EAReportViewController" title:@"" tabImageName:@"tab_report" selectedImageName:@"tab_report_pre"];
    report.addNavController = true;
    
    
    NSArray *tabItems = @[message,task,record,subscribe,report];
  
    NSArray *controllers = [TKTabControllerIniter viewControllersWithItems:tabItems];
    self.viewControllers = controllers;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initItems];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = true;
    self.delegate = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}

-(void)showAddRecord
{
    EAAddRecordView *recordView = [[EAAddRecordView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [recordView show];
}

#pragma mark -
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if ([viewController isKindOfClass:[EARecordViewController class]]) {
        
        [self showAddRecord];
        
        return NO;
    }
    
    return YES;
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //首页手指从最左侧滑动不处理
    if (self.navigationController &&  [[self.navigationController viewControllers] count] == 1) {
        return NO;
    }
    return YES;
}



@end
