//
//  EASheBeiMainVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASheBeiMainVC.h"
#import "EAKongJianHeader.h"
#import "EASpaceModel.h"
#import "EAFilterView.h"
#import "TKAccountManager.h"

@interface EASheBeiMainVC ()

@end

@implementation EASheBeiMainVC {
    EAKongJianHeader *_header;
    UIScrollView *_contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavbar];
    NSArray *data = @[
                      @[@"空间名称", ToSTR(self.rModel.name)],
                      @[@"资产状态", ToSTR(self.rModel.name)],
                      @[@"空间面积", ToSTR(self.rModel.area)],
                      @[@"资产属性", ToSTR(self.rModel.name)],
                      ];
    _header = [[EAKongJianHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) data:data subscribed:NO];
    [self.view addSubview:_header];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - _header.bottom)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    [self addRefreshView:_contentView];
    [self startHeadRefresh:_contentView];
}

- (void)initNavbar {
    // 设置右边的搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 40, 40);
    UIImage *img = [UIImage imageNamed:@"common_filter"];
    [searchButton setImage:img forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(filterAction) forControlEvents:UIControlEventTouchUpInside];
    [searchButton sizeToFit];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
}

- (void)filterAction {
    EAFilterView *v = [[EAFilterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    v.confirmBlock = ^(NSString *item, NSInteger index, NSDate *startDate, NSDate *endDate) {
        if (!(item || (startDate && endDate))) {
            return ;
        }
        if (startDate && endDate) {
            
        }
    };
    [v updateWithTags:nil hasDate:YES showIndicator:NO];
    [self.view.window addSubview:v];
}

- (void)headRefreshAction {
    [self requestData];
}

#pragma mark - request
- (void)requestData {
    [self nodata_hideView];
    NSMutableDictionary *params = @{@"productArray": [TKAccountManager sharedInstance].loginUserInfo.productArray ?: @[],
                                    }.mutableCopy;
//    if (self.spaceId.length) {
//        params[@"spaceId"] = self.spaceId;
//    }
//    if (self.deviceId) {
//        params[@"deviceId"] = self.deviceId;
//    }
    params[@"spaceId"] = @"402881585e710ded015e7117033906b9";
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
