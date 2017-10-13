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
#import "TKRequestHandler+Simple.h"
#import "EAReportListModel.h"
#import "EAReportPageListModel.h"
#import "NSDate+Category.h"

typedef NS_ENUM(NSUInteger, EAReportListFilterTimeType) {
    EAReportListFilterTimeTypeCurrent,
    EAReportListFilterTimeTypeLastYear,
};

static NSString *const kReportTypeDay = @"day";
static NSString *const kReportTypeMonth = @"month";
static NSString *const kReportTypeSpecial = @"special";

static NSString *const kFilterRankName = @"nameAsc";
static NSString *const kFilterRankDate = @"dateAsc";

@interface EAReportListVC  () <UITableViewDelegate, UITableViewDataSource, EAReportFilterHandleProtocol> {
    UITableView *_tableView;
    EAReportFilterHandle *_filterHandle;
    NSMutableArray *_dataArray;
    NSInteger _page;
    BOOL _requestFinished;
    // filter
    NSString *_filterRank;
    EAReportListFilterTimeType _filterTime;
}
@end

@implementation EAReportListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDatas];
    [self updateTitle];
    
    _filterHandle = [[EAReportFilterHandle alloc] initWithData:self.filterHandleData];
    _filterHandle.delegate = self;
    [self.view addSubview:_filterHandle.filterBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _filterHandle.filterBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - _filterHandle.filterBar.bottom)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    [self addRefreshView:_tableView];
    [self startHeadRefresh:_tableView];
}

- (NSString *)reportType {
    switch (self.contentType) {
        case EAReportListContentTypeDay:
            return kReportTypeDay;
        case EAReportListContentTypeMouth:
            return kReportTypeMonth;
        case EAReportListContentTypeSpecial:
            return kReportTypeSpecial;
        default:
            break;
    }
    return kReportTypeDay;
}

#pragma mark - Header/Footer action
- (void)headRefreshAction {
    [self loadDataWithPage:0];
}

- (void)footRefreshAction {
    [self loadDataWithPage:_page+1];
}

#pragma mark - request
- (void)loadDataWithPage:(NSInteger)page {
    [self nodata_hideView];
    NSMutableDictionary *params = @{ @"reportId": ToSTR(self.reportId), }.mutableCopy;
    NSString *path = @"/eis/open/report/findEisReportDetailOfReceive";
    Class cls = EAReportPageListModel.class;
    if (EAReportListVCTypeFolder == self.showType) {
        params = @{ @"reportType": [self reportType], }.mutableCopy;
        path = @"/eis/open/report/findEisReportOfReceive";
        cls = EAReportListModel.class;
    }
    params[@"sorts"] = _filterRank;
    params[@"pageNum"] = @(page);
    params[@"pageSize"] = @(kEISRequestPageSize);
    NSInteger year =[[NSDate date] year];
    if (EAReportListFilterTimeTypeCurrent == _filterTime) {
        params[@"startDate"] = [NSString stringWithFormat:@"%@-01-01 00:00:00", @(year)];
    } else {
        params[@"startDate"] = [NSString stringWithFormat:@"%@-01-01 00:00:00", @(year-1)];
        params[@"endDate"] = [NSString stringWithFormat:@"%@-01-01 00:00:00", @(year)];
    }
    weakify(self);
    [TKRequestHandler postWithPath:path params:params jsonModelClass:cls completion:^(id model, NSError *error) {
        strongify(self);
        [self loadDataComplete:model page:page];
    }];
}

- (void)loadDataComplete:(id)aModel page:(NSInteger)page {
    [self stopRefresh:_tableView];
    NSArray *list = nil;
    BOOL success = YES;
    if (EAReportListVCTypeFolder == self.showType) {
        EAReportListModel *model = aModel;
        list = model.data.list;
        success = model.success;
    } else {
        list = ((EAReportPageListModel *)aModel).data;
        success = ((EAReportPageListModel *)aModel).success;
    }
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

- (void)updateTitle {
    if (EAReportListVCTypeFolder == self.showType) {
        NSString *title = @"日报";
        if (EAReportListContentTypeMouth == self.contentType) {
            title = @"月报";
        } else if (EAReportListContentTypeSpecial == self.contentType) {
            title = @"专题报告";
        }
        self.title = title;
    }
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
    _filterRank = kFilterRankName;
    _filterTime = EAReportListFilterTimeTypeCurrent;
    _dataArray = [NSMutableArray array];
}

- (NSDictionary *)dictWithModel:(id)aModel {
    if (EAReportListVCTypeFolder == self.showType) {
        EAReportListListModel *model = (EAReportListListModel *)aModel;
        return @{
                 @"title": ToSTR(model.reportName),
                 @"time": ToSTR(model.createDate),
                 @"red": @(model.isRead),
                 };
    } else {
        EAReportPageListDataModel *model = (EAReportPageListDataModel *)aModel;
        return @{
                 @"title": ToSTR(model.reportName),
                 @"time": ToSTR(model.createDate),
                 @"red": @(model.isRead),
                 };
    }
}

#pragma mark - EAReportFilterHandleProtocol
- (void)filterHandle:(EAReportFilterHandle *)handle clickedInCategory:(NSInteger)categoryIndex rowIndex:(NSInteger)rowIndex {
    BOOL changed = NO;
    if (0 == categoryIndex) {
        NSString *filter = 0 == rowIndex ? kFilterRankName : kFilterRankDate;
        changed = ![_filterRank isEqualToString:filter];
        _filterRank = filter;
    } else if (1 == categoryIndex) {
        EAReportListFilterTimeType type = 0 == rowIndex ? EAReportListFilterTimeTypeCurrent : EAReportListFilterTimeTypeLastYear;
        changed = _filterTime != type;
        _filterTime = type;
    }
    if (changed) {
        [self loadDataWithPage:0];
    }
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
    [cell setModel:[self dictWithModel:_dataArray[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EABaseViewController *vc = nil;
    if (self.showType == EAReportListVCTypeFolder) {
        EAReportListListModel *model = _dataArray[indexPath.row];
        EAReportListVC *listVC = [[EAReportListVC alloc] init];
        listVC.showType = EAReportListVCTypeList;
        listVC.title = model.reportName;
        listVC.reportId = model.id;
        vc = listVC;
    } else {
        EAReportPageListDataModel *model = _dataArray[indexPath.row];
        EAReportDetailVC *detailVC = [[EAReportDetailVC alloc] init];
        detailVC.title = @"详情";
        vc = detailVC;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
