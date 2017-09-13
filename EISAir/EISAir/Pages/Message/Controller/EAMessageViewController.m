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
#import "EAMsgDetailViewController.h"
#import "EAHomeViewController.h"
#import "TKRequestHandler+Message.h"
#import "TKAccountManager.h"

#define kSlideSwitchHeight 38

@interface EAMessageViewController ()<TKSwitchSlidePageViewControllerDelegate>

@property (nonatomic, strong) NSArray *titleArray;       //标题
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSMutableDictionary *tagsDict;

@property (nonatomic, strong) NSArray *allTags;
@property (nonatomic, strong) NSArray *alarmTags;
@property (nonatomic, strong) NSArray *exceptionTags;
@property (nonatomic, strong) NSArray *recordTags;
@property (nonatomic, strong) NSArray *noticeTags;
@property (nonatomic, strong) EAMsgFilterModel *filterModel;

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
        self.typeArray = @[@"EIS_MSG_TYPE_ALL",@"EIS_MSG_TYPE_ALARM", @"EIS_MSG_TYPE_EXCEPTION", @"EIS_MSG_TYPE_RECORD" , @"EIS_MSG_TYPE_NOTICE"];
        
        self.tagsDict = [[NSMutableDictionary alloc]init];
        /*
         *  "EIS_MSG_TYPE_NOTICE": "通知",
         *  "EIS_MSG_TYPE_ALARM": "报警",
         *  "EIS_MSG_TYPE_RECORD": "人工记录",
         *  "EIS_MSG_TYPE_EXCEPTION": "异常"
         */
        
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
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
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
    __weak typeof (self) weakself = self;
    EAMessageSlideListViewController *controller = [[EAMessageSlideListViewController alloc]init];
    controller.showMessageBlock = ^(EAMessageDataListModel *model) {
        EAMsgDetailViewController *controller = [[EAMsgDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
        controller.hidesBottomBarWhenPushed = true;
        controller.msgModel = model;
        [weakself.navigationController pushViewController:controller animated:true];
    };
    
    NSArray *types = nil;
    BOOL reload = false;
    if (index == 0) {
        types = nil;//self.typeArray;
    }else{
        NSString *type = _typeArray[index-1];
        types = @[type];
    }
    if (index == 0) {
        reload = true;
    }
    [controller updateWithType:types reload:reload];
    
    return controller;
    
}

-(NSArray *)pageTitles
{
    return  self.titleArray;
}

-(void)willReuseController:(UIViewController<TKSwitchSlidePageItemViewControllerProtocol> *) controller forIndex:(NSInteger)index
{
    EAMessageSlideListViewController *listController = (EAMessageSlideListViewController*)controller;

    NSArray *types = nil;
    if (index != 0) {
        NSString *type = _typeArray[index-1];
        types = @[type];
    }
    [listController updateWithType:types reload:true];
    
}

-(void)tapCurrentItem:(NSInteger)index controller:(UIViewController<TKSwitchSlidePageItemViewControllerProtocol> *)controller
{
    EAMessageSlideListViewController *listController = (EAMessageSlideListViewController *)controller;
    NSArray *types = nil;
    if (index != 0) {
        NSString *type = _typeArray[index-1];
        types = @[type];
    }
    [listController updateWithType:types reload:true];
    
}

-(void)selectedAtIndex:(NSInteger)index
{
    [super selectedAtIndex:index];
    if (index > 0) {
        
        
        
    }
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
//    EAHomeViewController *controller = [EAHomeViewController controller];
//    
//    [self.navigationController pushViewController:controller animated:true];
    [[EAPushManager sharedInstance] handleOpenUrl:@"eis://show_home"];
}

-(void)filterAction
{
    NSString *key = self.typeArray[self.currentIndex];
    NSArray *tags = self.tagsDict[key];
    if (tags) {
        [self showFilterView:tags];
    }else{
        [self loadFilterTags];
    }

}

-(void)showFilterView:(NSArray *)tags
{
    EAFilterView *v = [[EAFilterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    __weak typeof(self) wself = self;
    v.tapHeadBlock = ^(EAFilterView *fv , NSInteger section) {
        [fv hide];
        [wself showSearchPage];
    };
    [v updateWithTags:tags hasDate:true];
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

-(void)loadFilterTags
{
    EAMsgFilterModel *model = nil;
    model = [[EAMsgFilterModel alloc]init];
    EALoginUserInfoDataModel *linfo = [TKAccountManager sharedInstance].loginUserInfo;
    model.orgId = linfo.orgId;
    model.siteId = linfo.siteId;
    model.isAdmin = linfo.isAdmin;
    
    NSString *key = self.typeArray[self.currentIndex];
    if (self.currentIndex != 0) {
        model.msgTypes = @[key];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [[TKRequestHandler sharedInstance] loadMsgFilterTag:model completion:^(NSURLSessionDataTask *task, EAMsgFilterTagModel *tagModel, NSError *error) {
        
        if (error || !tagModel.success) {
            hud.label.text = tagModel.msg?:@"拉取筛选数据失败";
            [hud hideAnimated:true afterDelay:0.7];
        }else if (tagModel.data.count == 0){
            hud.label.text = @"暂无数据";
            [hud hideAnimated:true afterDelay:0.7];
        }else{
            self.tagsDict[key] = tagModel.data;
            [self showFilterView:tagModel.data];
        }
    }];
}


@end
