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

#import "EANetworkManager.h"

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
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self test];
//    });
    
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

-(void)reloadAll
{
    //重新创建控件
    [self initItems];
}

-(void)showAddRecord
{
    [EAAddRecordView show];
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


#pragma network request test
-(void)test
{
    //GET /eis/open/task/findTaskResultByTaskId
    //POST /eis/open/msg/findMsgTitleList
    //GET /eis/open/user/findLoginUser
    NSString *path = [NSString stringWithFormat:@"%@/dss/oss/policy",AppHost];
    //@"personId":udata.personId?:@"",
    EALoginUserInfoDataModel *udata = [TKAccountManager sharedInstance].loginUserInfo;
    NSLog(@"product array is: %@",udata.productArray);
    NSMutableArray *productArray = [NSMutableArray new];
    [productArray addObjectsFromArray:udata.productArray];
    
    NSDictionary *param = nil;// @{@"orgId":udata.orgId?:@"",@"siteId":udata.siteId?:@"",@"pageSize":@"20",@"pageNum":@"0",@"objName":@"B",@"productArray":productArray};
    
    
    [[TKRequestHandler sharedInstance]getRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error is: \n%@\n\n",error);
            NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *info = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
            NSLog(@"info is: \n%@\n",info);
        }
        
        if (response) {
            NSLog(@"response is:\n%@\n\n",response);
            NSData *data = [NSJSONSerialization dataWithJSONObject:response options:kNilOptions error:nil];
            NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"json is:\n\n%@\n\n",json);
        }
    }];
}


@end
