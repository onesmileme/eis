//
//  EAReportListVC.m
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportListVC.h"
#import "EAReportCell.h"
#import "EAReportDetailVC.h"
#import "EAReportFilterHandle.h"

@interface EAReportListVC  () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    EAReportFilterHandle *_filterHandle;
    NSMutableArray *_dataArray;
}
@end

@implementation EAReportListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDatas];
    [self updateTitle];
    
    _filterHandle = [[EAReportFilterHandle alloc] initWithData:self.filterHandleData];
    [self.view addSubview:_filterHandle.filterBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _filterHandle.filterBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - _filterHandle.filterBar.bottom)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}

- (void)updateTitle {
    NSString *title = @"日报";
    if (EAReportListContentTypeMouth == self.contentType) {
        title = @"月报";
    } else if (EAReportListContentTypeSpecial == self.contentType) {
        title = @"专题报告";
    }
    self.title = title;
}

- (NSArray *)filterHandleData {
    return @[
             @{
                 @"category": @"名称排序",
                 @"values": @[
                         @"名称排序",
                         @"时间排序",
                         ],
                 },
             @{
                 @"category": @"日期",
                 @"values": @[
                         @"今年",
                         @"2016年",
                         ],
                 },
             ];
}

- (void)initDatas {
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

#pragma mark - TableView Delegate/DataSource
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
        cell = [[EAReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier cellStyle:(EAReportCellStyle)self.showType];
    }
    [cell setModel:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EABaseViewController *vc = nil;
    if (self.showType == EAReportListVCTypeFolder) {
        EAReportListVC *listVC = [[EAReportListVC alloc] init];
        listVC.showType = EAReportListVCTypeList;
        listVC.title = @"日报列表";
        vc = listVC;
    } else {
        EAReportDetailVC *detailVC = [[EAReportDetailVC alloc] init];
        detailVC.title = @"详情";
        vc = detailVC;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
