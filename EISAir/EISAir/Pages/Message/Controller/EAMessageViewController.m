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
    UIImage *img = [UIImage imageNamed:@"icon_search"];
    [searchButton setImage:img forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [searchButton sizeToFit];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
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

- (void)searchAction {
//    FASearchViewController *controller = [[FASearchViewController alloc]init];
//    controller.searchBlock = ^(FASearchFilterType type){
//    };
//    
//    controller.hidesBottomBarWhenPushed = true;
//    [self.navigationController pushViewController:controller animated:true];
}


@end
