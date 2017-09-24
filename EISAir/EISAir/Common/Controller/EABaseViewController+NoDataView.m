//
//  EABaseViewController+NoDataView.m
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"
#import "EAMessageNoDataView.h"

static const int kTagOfNoData = 7383948;

@implementation EABaseViewController (NoDataView)

- (void)nodata_showNoDataViewWithTapedBlock:(void (^)(void))tapedBlock {
    EAMessageNoDataView *nodataView = [self nodata_View];
    if (!nodataView) {
        nodataView = [self nodata_createNoDataView];
    }
    if (tapedBlock) {
        nodataView.tapBlock = tapedBlock;
    }
    [self.view addSubview:nodataView];
}

- (void)nodata_hideView {
    EAMessageNoDataView *nodataView = [self nodata_View];
    if (nodataView) {
        [nodataView removeFromSuperview];
    }
}

- (EAMessageNoDataView *)nodata_createNoDataView {
    EAMessageNoDataView *noDataView = [EAMessageNoDataView view];
    noDataView.frame = self.view.bounds;
    __weak typeof(self) wself = self;
    UITableView *tableView = [self nodata_findTableView];
    if (tableView) {
        weakify(tableView);
        weakify(noDataView);
        noDataView.tapBlock = ^{
            [wself startHeadRefresh:weaktableView];
            [weaknoDataView removeFromSuperview];
        };
    }
    noDataView.tag = kTagOfNoData;
    return noDataView;
}

- (EAMessageNoDataView *)nodata_View {
    EAMessageNoDataView *noDataView = [self.view viewWithTag:kTagOfNoData];
    return noDataView;
}

- (UITableView *)nodata_findTableView {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            return (UITableView *)view;
        }
    }
    return nil;
}

@end
