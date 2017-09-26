//
//  EAReportViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportViewController.h"
#import "EAReportCell.h"
#import "EAReportHeader.h"
#import "EAReportListVC.h"
#import "EAReportDetailVC.h"
#import "EAReportPageListModel.h"

@interface EAReportViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    EAReportHeader *_reportHeader;
    NSMutableArray *_dataArray;
    NSInteger _page;
}
@end

@implementation EAReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initDatas {
    _dataArray = [NSMutableArray array];
}

- (void)initViews {
    self.title = @"报告";
    self.tabBarItem.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavbar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    _reportHeader = [[EAReportHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    weakify(self);
    _reportHeader.clickedBlock = ^ (NSUInteger index) {
        strongify(self);
        [self clickedHeaderIndex:index];
    };
    [_reportHeader setModel:@[
                              @{
                                  @"pic": @"report_icon1",
                                  @"title": @"日报",
                                  @"detail": @"6.20更新",
                                  },
                              @{
                                  @"pic": @"report_icon2",
                                  @"title": @"周报",
                                  @"detail": @"6.20更新",
                                  },
                              @{
                                  @"pic": @"report_icon3",
                                  @"title": @"专题报告",
                                  @"detail": @"6.20更新",
                                  },
                              ]];
    _tableView.tableHeaderView = _reportHeader;
    
    [self addRefreshView:_tableView];
    [self startHeadRefresh:_tableView];
}

- (void)initNavbar {
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(0, 0, 40, 40);
    [menuButton setImage:SYS_IMG(@"common_menu") forState:UIControlStateNormal];
    [menuButton sizeToFit];
    [menuButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItems = @[menuItem];
}

- (void)headRefreshAction {
    [self loadDataWithPage:0];
}

- (void)footRefreshAction {
    [self loadDataWithPage:_page+1];
}

- (NSDictionary *)dictWithModel:(id)aModel {
    EAReportPageListDataModel *model = (EAReportPageListDataModel *)aModel;
    return @{
             @"title": ToSTR(model.reportName),
             @"time": ToSTR(model.createDate),
             @"red": @"1",
             };
}

#pragma mark - Actions
- (void)menuAction {
    [[EAPushManager sharedInstance] handleOpenUrl:@"eis://show_home"];
}

- (void)clickedHeaderIndex:(NSUInteger)index {
    EAReportListVC *vc = [[EAReportListVC alloc] init];
    vc.showType = EAReportListVCTypeFolder;
    vc.contentType = index;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - TableView Delegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    view.backgroundColor = [UIColor themeGrayColor];
    UILabel *label = TKTemplateLabel2([UIFont systemFontOfSize:16], [UIColor blackColor], @"报告动态");
    label.left = 15;
    label.centerY = view.height * .5;
    [view addSubview:label];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [EAReportCell cellHeightWithModel:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    EAReportCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[EAReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setModel:[self dictWithModel:_dataArray[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EABaseViewController *vc = [[EAReportDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Request
- (void)loadDataWithPage:(NSInteger)page {
    [self nodata_hideView];
    NSDictionary *params = @{
                             @"pageNum": @(page),
                             @"pageSize": @(kEISRequestPageSize),
                             };
    NSString *path = @"/eis/open/report/findEisReportDetailOfReceive";
    Class cls = EAReportPageListModel.class;
    weakify(self);
    [TKRequestHandler postWithPath:path params:params jsonModelClass:cls completion:^(id model, NSError *error) {
        strongify(self);
        [self loadDataComplete:model page:page];
    }];
}

- (void)loadDataComplete:(id)aModel page:(NSInteger)page {
    [self stopRefresh:_tableView];
    NSArray *list = ((EAReportPageListModel *)aModel).data;
    BOOL success = ((EAReportPageListModel *)aModel).success;
    if (page == 0) {
        _page = 0;
        [_dataArray removeAllObjects];
    }
    if (list.count) {
        _page = page;
        [_dataArray addObjectsFromArray:list];
    } else {
        if (!_dataArray.count) {
            [self nodata_showNoDataViewWithTapedBlock:nil];
        }
        [TKCommonTools showToast:success ? kTextRequestNoMoreData : kTextRequestFailed];
    }
    [_tableView reloadData];
}

@end
