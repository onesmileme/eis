//
//  EAKongJianChartVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAKongJianChartVC.h"
#import "TKAccountManager.h"
#import "EADingYueTemperatureView.h"
#import "WMDingYueChartModel.h"

@interface EAKongJianChartVC ()

@end

@implementation EAKongJianChartVC {
    UIScrollView *_contentView;
    WMDingYueChartModel *_chartModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    [self addHeaderRefreshView:_contentView];
    [self startHeadRefresh:_contentView];
}

- (void)headRefreshAction {
    [self requestData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _contentView.frame = self.view.bounds;
}

- (void)updateContentView {
    [_contentView removeAllSubviews];
    
    float top = 20;
    int index = 0;
    for (WMDingYueChartDataModel *dataModel in _chartModel.data) {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        data[@"title"] = ToSTR(dataModel.objName);
        data[@"date"] = @"2016-08-11";
        data[@"compare_date"] = @"2016-08-12";
        NSMutableArray *items = [NSMutableArray array];
        data[@"data"] = items;
        NSMutableArray *compareItems = [NSMutableArray array];
        data[@"compare_data"] = compareItems;
        
        for (WMDingYueChartDisvaluesModel *model in dataModel.disValues) {
            NSString *time = [[[[model.timestamp componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"] firstObject];
            [items addObject:@{
                               @"time": ToSTR(time),
                               @"temper": ToSTR(model.value),
                               }];
        }
        for (WMDingYueChartContrastdisvaluesModel *model in dataModel.contrastDisValues) {
            NSString *time = [[[[model.timestamp componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"] firstObject];
            [compareItems addObject:@{
                               @"time": ToSTR(time),
                               @"temper": ToSTR(model.value),
                               }];
        }
        EADingYueTemperatureView *view = [[EADingYueTemperatureView alloc] initWithData:data];
        view.top = top;
        [_contentView addSubview:view];
        
        top = view.bottom + 20;
        
        if (index < _chartModel.data.count - 1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom + 10, SCREEN_WIDTH, LINE_HEIGHT)];
            line.backgroundColor = LINE_COLOR;
        }
        
        index++;
    }
}

- (void)requestData {
    [self nodata_hideView];
    NSMutableDictionary *params = @{@"productArray": [TKAccountManager sharedInstance].loginUserInfo.productArray ?: @[],
                                    }.mutableCopy;
    if (self.spaceId.length) {
        params[@"spaceId"] = self.spaceId;
    }
    if (self.deviceId) {
        params[@"deviceId"] = self.deviceId;
    }
    params[@"spaceId"] = @"402881585e710ded015e7117033906b9";
    params[@"trackType"] = EAKongJianVCTypeKongJian == self.type ? @"SPACE_TRACK" : @"DEVICE_TRACK";
    params[@"dateType"] = @"day";
    params[@"compareType"] = @"section";
    params[@"chooseDate"] = @"2016-08-11";
    params[@"compareDate"] = @"2016-08-12";
    weakify(self);
    [TKRequestHandler postWithPath:@"/eis/open/track/findInfoByObject" params:params jsonModelClass:WMDingYueChartModel.class completion:^(id model, NSError *error) {
        strongify(self);
        [self requestDataDone:model];
    }];
}

- (void)requestDataDone:(WMDingYueChartModel *)model {
    [self stopRefresh:_contentView];
    if (model.success && model.data.count) {
        _chartModel = model;
        [self updateContentView];
    } else {
        [TKCommonTools showToast:kTextRequestFailed];
        [self nodata_showNoDataViewWithTapedBlock:nil];
    }
}

@end
