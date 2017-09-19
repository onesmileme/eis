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

@interface EAReportViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    EAReportHeader *_reportHeader;
    NSMutableArray *_dataArray;
    
}
@end

@implementation EAReportViewController

- (void)initData {
    [super initData];
    
    _dataArray = @[
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   @{
                       @"title": @"C座VAV系统运行分析报告-5月",
                       @"time": @"11:50",
                       @"red": @"1",
                       },
                   ].mutableCopy;
}

- (void)initView {
    [super initView];
    self.title = @"订阅";
    self.tabBarItem.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavbar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    _reportHeader = [[EAReportHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [_reportHeader setModel:@[
                              @{
                                  @"pic": @"report_icon1",
                                  @"title": @"日报",
                                  @"detail": @"6.20更新",
                                  },
                              @{
                                  @"pic": @"report_icon2",
                                  @"title": @"日报",
                                  @"detail": @"6.20更新",
                                  },
                              @{
                                  @"pic": @"report_icon3",
                                  @"title": @"日报",
                                  @"detail": @"6.20更新",
                                  },
                              ]];
    _tableView.tableHeaderView = _reportHeader;
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

#pragma mark - Actions
- (void)menuAction {
    [[EAPushManager sharedInstance] handleOpenUrl:@"eis://show_home"];
}

#pragma mark - TableView Delegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    view.backgroundColor = [UIColor themeGrayColor];
    UILabel *label = TKTemplateLabel2([UIFont systemFontOfSize:18], [UIColor blackColor], @"报告动态");
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
    [cell setModel:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EABaseViewController *vc = nil;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
