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

@interface EASheBeiMainVC ()

@end

@implementation EASheBeiMainVC {
    EAKongJianHeader *_header;
    UIScrollView *_contentView;
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [self addRefreshView:_contentView];
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
    [self updateData];
    [self updateContentView];
}
@end
