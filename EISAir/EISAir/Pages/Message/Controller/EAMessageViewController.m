//
//  EAMessageViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageViewController.h"
#import "EAMessageSlideCollectionViewCell.h"
#import "EAMessageSlideListViewController.h"
#import "EAMessageFilterResultViewController.h"
#import "EAFilterView.h"
#import "EASearchViewController.h"

#define kSlideSwitchHeight 38

@interface EAMessageViewController ()<TKSwitchSlidePageViewControllerDelegate>

@property (nonatomic, strong) NSArray *titleArray;       //标题

@end


@implementation EAMessageViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
        self.slideSwitchHeight = kSlideSwitchHeight;
        self.slideItemClass = [EAMessageSlideCollectionViewCell class];
        self.slideBackgroundColor = [UIColor themeGrayColor];
        
        self.titleArray = @[@"全部",@"报警",@"异常",@"人工记录",@"通知"];
        
    }
    return self;
}

-(void)initNavbar
{    
    // 设置右边的搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 40, 40);
    UIImage *img = [UIImage imageNamed:@"common_filter"];
    [searchButton setImage:img forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(filterAction) forControlEvents:UIControlEventTouchUpInside];
    [searchButton sizeToFit];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(0, 0, 40, 40);
    img = SYS_IMG(@"common_menu");
    [menuButton setImage:img forState:UIControlStateNormal];
    [menuButton sizeToFit];
    [menuButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = menuItem;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的消息";
    self.tabBarItem.title = @"";
    
    [self initNavbar];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.slideBackgroundColor = [UIColor whiteColor];
    self.slideBottomLineColor = HexColor(0xdddddd);
 
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self showFilterResult];
//    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberofPages
{
    return self.titleArray.count;
}

-(UIViewController<TKSwitchSlidePageItemViewControllerProtocol> *)controllerForIndex:(NSInteger)index
{
//    FASlideConfigDataCategoryListModel *model = self.configModel.categoryList[index];
//    FASlidePageListViewController *controller = [[FASlidePageListViewController alloc]initWithNewsModel:model];
//    __weak typeof (self) weakself = self;
//    controller.pushAction = ^(UIViewController *viewController,BOOL animated){
//        [weakself.navigationController pushViewController:viewController animated:YES];
//    };
//    return  controller;
    EAMessageSlideListViewController *controller = [[EAMessageSlideListViewController alloc]init];
    
    return controller;
    
}

-(NSArray *)pageTitles
{
    return  self.titleArray;
}

-(void)willReuseController:(UIViewController<TKSwitchSlidePageItemViewControllerProtocol> *) controller forIndex:(NSInteger)index
{
    EAMessageSlideListViewController *listController = (EAMessageSlideListViewController*)controller;
//    FASlideConfigDataCategoryListModel *model = self.configModel.categoryList[index];
//    [listController refreshWithModel:model];
    
}

-(void)tapCurrentItem:(NSInteger)index controller:(UIViewController<TKSwitchSlidePageItemViewControllerProtocol> *)controller
{
    EAMessageSlideListViewController *listController = (EAMessageSlideListViewController *)controller;
//    [listController reload:true];
}

- (void)slideConfigChangedNotification
{
//    self.configModel = [[FASlideConfigManager sharedInstance] slideConfigModel];
//    self.titleArray = nil;
    [self reload];
}

- (void)slideConfigFailedNotification
{
//    [self.view addSubview:self.reloadView];
}

- (void)slideConfigSucceedNotification
{
//    NSArray *subviews = [self.view subviews];
//    if ([subviews containsObject:self.reloadView]) {
//        [self.reloadView removeFromSuperview];
//    }
//    self.configModel = [[FASlideConfigManager sharedInstance] slideConfigModel];
//    self.titleArray = nil;
//    [self reload];
}


-(void)menuAction
{
    
}

-(void)filterAction
{
    EAFilterView *v = [[EAFilterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    __weak typeof(self) wself = self;
    v.tapHeadBlock = ^(EAFilterView *fv , NSInteger section) {
        [fv hide];
        [wself showSearchPage];
    };
    [self.view.window addSubview:v];
}


-(void)showFilterResult
{
    EAMessageFilterResultViewController *controller = [[EAMessageFilterResultViewController alloc]initWithNibName:nil bundle:nil];
    controller.hidesBottomBarWhenPushed = true;
    
    [self.navigationController pushViewController:controller animated:true];
}

-(void)showSearchPage
{
    EASearchViewController *controller = [[EASearchViewController alloc]initWithNibName:nil bundle:nil];
    controller.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:controller animated:true];
}


@end
