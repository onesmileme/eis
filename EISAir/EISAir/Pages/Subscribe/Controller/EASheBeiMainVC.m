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
#import "TKAccountManager.h"
#import "EADingYueSheBeiModel.h"
#import "EASheBeiContainView.h"
#import "EADingYueDefines.h"

@interface EASheBeiMainVC () {
    EADingYueSheBeiModel *_model;
}

@end

@implementation EASheBeiMainVC {
    EAKongJianHeader *_header;
    UIScrollView *_contentView;
    NSMutableArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.rModel.name stringByAppendingString:@"设备"];
    _dataArray = [NSMutableArray array];
    NSArray *data = @[
                      @[@"空间名称", ToSTR(self.rModel.name)],
                      @[@"空间面积", ToSTR(self.rModel.area)],
                      @[@"资产属性", ToSTR(self.rModel.name)],
                      ];
    _header = [[EAKongJianHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) data:data subscribed:NO];
    [self.view addSubview:_header];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - _header.bottom)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    [self addHeaderRefreshView:_contentView];
    [self startHeadRefresh:_contentView];
}

- (void)headRefreshAction {
    [self requestData];
}

- (void)updateContentView {
    __block float top = 15;
    [_dataArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EASheBeiContainView *view = [[EASheBeiContainView alloc] initWithTitle:obj[@"title"] items:obj[@"items"]];
        [_contentView addSubview:view];
        view.top = top;
        top = view.bottom + 12;
    }];
    _contentView.contentSize = CGSizeMake(_contentView.width, MAX(top, _contentView.height));
}

- (void)updateData {
    [_dataArray removeAllObjects];
    NSMutableArray *array = [NSMutableArray array];
    NSString *title = nil;
    for (EADingYueSheBeiDataModel *dataModel in _model.data) {
        [array addObject:@{
                           @"text": ToSTR(dataModel.name),
                           @"state": @(EASheBeiStateOpen),
                           }];
        if (!title.length) {
            title = dataModel.classificationParentName;
        }
    }
    [_dataArray addObject:@{
                            @"title": ToSTR(title),
                            @"items": array,
                            }];
}

#pragma mark - request
- (void)requestData {
    [self nodata_hideView];
    NSMutableDictionary *params = @{@"productArray": [TKAccountManager sharedInstance].loginUserInfo.productArray ?: @[],
                                    }.mutableCopy;
    params[@"spaceId"] = ToSTR(self.rModel.id);
    weakify(self);
    [TKRequestHandler postWithPath:@"/eis/open/track/findDeviceInfoFilter" params:params jsonModelClass:EADingYueSheBeiModel.class completion:^(id model, NSError *error) {
        strongify(self);
        [self requestDataDone:model];
    }];
}

- (void)requestDataDone:(EADingYueSheBeiModel *)model {
    [self stopRefresh:_contentView];
    if (model.success) {
        _model = model;
        [self updateData];
        [self updateContentView];
    } else {
        [TKCommonTools showToast:model.msg];
        [self nodata_showNoDataViewWithTapedBlock:nil];
    }
}
@end
