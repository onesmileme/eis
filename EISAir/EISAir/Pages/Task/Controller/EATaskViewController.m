//
//  EATaskViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskViewController.h"
#import "EATaskSlideCollectionVIewCell.h"
#import "EAFilterView.h"
#import "EATaskSearchResultViewController.h"
#import "EAMessageFilterResultViewController.h"
#import "EASearchViewController.h"
#import "EATaskSlideListViewController.h"
#import "EATaskDetailEditViewController.h"
#import "EAUserSearchViewController.h"
#import "EAAddressBookManager.h"
#import "EATaskDetailViewController.h"
#import "EATaskFilterChooseView.h"
#import "EATaskFilterModel.h"
#import "EATaskFilterResultViewController.h"
#import "EATaskAddTableViewController.h"
#import "EAMsgSearchTipModel.h"

#define kSlideSwitchHeight 38

@interface EATaskViewController ()<TKSwitchSlidePageViewControllerDelegate>

@property (nonatomic, strong) NSArray *titleArray;       //标题
@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, strong) NSArray *filterObjList;

@end

@implementation EATaskViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
        self.slideSwitchHeight = kSlideSwitchHeight;
        self.slideItemClass = [EATaskSlideCollectionVIewCell class];
        self.slideBackgroundColor = [UIColor themeGrayColor];
        
        self.titleArray = @[@"临时任务",@"计划任务"];
        self.typeArray = @[kTaskTypeCheck,kTaskTypePlan];
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
    
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [self showFilterResult];
//            [self test];
//        });
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

-(void)menuAction
{
    [[EAPushManager sharedInstance] handleOpenUrl:@"eis://show_home"];
}

-(void)filterAction
{
    EATaskFilterChooseView *filterView = [EATaskFilterChooseView view];
    __weak typeof(self) wself = self;
    filterView.chooseBlock = ^(NSInteger index) {
        [wself showFilterView:index == 0];
    };
    [filterView show];
    
}
/*
 * 显示筛选是对象筛选还是状态筛选
 */
-(void)showFilterView:(BOOL)isState
{
    EAFilterView *v = [[EAFilterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    __weak typeof(self) wself = self;
    v.tapHeadBlock = ^(EAFilterView *fv , NSInteger section) {
        if (!isState) {
            [fv hide];
            [wself showSearchPage:fv];
        }
    };
    
    v.confirmBlock = ^(NSString *item,NSInteger index, NSDate *startDate, NSDate *endDate) {
        EATaskFilterModel *model = [[EATaskFilterModel alloc]init];
        if (item) {
            model.taskTypes = @[item];
        }        
        if (startDate && endDate) {
            model.startDate = [NSString stringWithFormat:@"%.0f",[startDate timeIntervalSince1970]];
            model.endDate = [NSString stringWithFormat:@"%.0f",[endDate timeIntervalSince1970]];
        }
        [wself showFilterResult:model];
    };
    
    if (isState) {
        
        v.type = @"状态";
        [v updateWithTags:@[@"待执行",@"执行中",@"已执行",@"已失效"] hasDate:true showIndicator:false];
        
    }else{
        v.type = @"对象";
        NSMutableArray *tags = nil;
        if (_filterObjList.count > 0) {
            tags = [[NSMutableArray alloc]init];
            for (EAMsgSearchTipDataModel * m in self.filterObjList) {
                [tags addObject:m.objName];
            }
        }
        [v updateWithTags:tags hasDate:true showIndicator:true];
    }
    [self.view.window addSubview:v];
}

-(void)showFilterResult:(EATaskFilterModel *)filterModel
{
    EATaskFilterResultViewController *controller = [[EATaskFilterResultViewController alloc]initWithStyle:UITableViewStyleGrouped];
    controller.hidesBottomBarWhenPushed = true;
    controller.filterModel = filterModel;
    [self.navigationController pushViewController:controller animated:true];
}


-(void)showSearchPage:(EAFilterView *)fv
{
    EASearchViewController *controller = [[EASearchViewController alloc]initWithNibName:nil bundle:nil];
    controller.searchType = @"task";
    __weak typeof(self) wself = self;
    controller.chooseItemsBlock = ^(NSArray<EAMsgSearchTipDataModel *> *items) {
        wself.filterObjList = items;
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself showFilterView:false];
        });
    };
    controller.searchObjBlock = ^(NSString *objId) {
        if (objId.length == 0) {
            return ;
        }
        EATaskFilterModel *filterModel = [[EATaskFilterModel alloc]init];
        filterModel.objList = @[objId];
        [wself showFilterResult:filterModel];
    };
    
    controller.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:controller animated:true];
}

-(NSInteger)numberofPages
{
    return self.titleArray.count;
}

-(UIViewController<TKSwitchSlidePageItemViewControllerProtocol> *)controllerForIndex:(NSInteger)index
{
    EATaskSlideListViewController *controller = [[EATaskSlideListViewController alloc]init];
    __weak typeof(self) wself = self;
    controller.showTaskBlock = ^(EATaskDataListModel *task) {
        [wself showTaskDetail:task];
    };
    controller.taskType = self.typeArray[index];
    return controller;
}

-(NSArray *)pageTitles
{
    return  self.titleArray;
}

-(void)willReuseController:(UIViewController<TKSwitchSlidePageItemViewControllerProtocol> *) controller forIndex:(NSInteger)index
{
    EATaskSlideListViewController *listController = (EATaskSlideListViewController*)controller;
    //    FASlideConfigDataCategoryListModel *model = self.configModel.categoryList[index];
    //    [listController refreshWithModel:model];
    
}

-(void)tapCurrentItem:(NSInteger)index controller:(UIViewController<TKSwitchSlidePageItemViewControllerProtocol> *)controller
{
    EATaskSlideListViewController *listController = (EATaskSlideListViewController *)controller;
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

-(void)showTaskDetail:(EATaskDataListModel *)task
{
    EATaskDetailViewController *controller = [EATaskDetailViewController controller];
    controller.task = task;
    [self.navigationController pushViewController:controller animated:true];
}

-(void)test
{
//
    EATaskAddTableViewController *controller = [[EATaskAddTableViewController alloc]init];
    controller.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:controller animated:true];
    
//    [[EAAddressBookManager sharedInstance] chooseContact:self.navigationController completion:^(NSString *name, NSString *phone) {
//
//    }];
    
}

@end
