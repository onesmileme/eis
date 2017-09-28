//
//  EAKongJianChartVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAKongJianChartVC.h"
#import "TKAccountManager.h"

@interface EAKongJianChartVC ()

@end

@implementation EAKongJianChartVC {
    UIScrollView *_contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    [self addRefreshView:_contentView];
//    [self startHeadRefresh:_contentView];
}

- (void)headRefreshAction {
    [self requestData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _contentView.frame = self.view.bounds;
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
    params[@"track_type"] = EAKongJianVCTypeKongJian == self.type ? @"SPACE_TRACK" : @"DEVICE_TRACK";
    params[@"dateType"] = @"day";
    params[@"compareType"] = @"section";
    params[@"chooseDate"] = @"2016-08-11";
    params[@"compareDate"] = @"2016-08-11";
    weakify(self);
    [TKRequestHandler postWithPath:@"/eis/open/track/findInfoByObject" params:params jsonModelClass:EAPostBasicModel.class completion:^(id model, NSError *error) {
        strongify(self);
        [self requestDataDone:model];
    }];
}

- (void)requestDataDone:(id)model {
    [self stopRefresh:_contentView];
}

@end
