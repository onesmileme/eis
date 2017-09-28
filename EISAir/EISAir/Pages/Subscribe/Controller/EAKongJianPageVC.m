//
//  EAKongJianPageVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAKongJianPageVC.h"
#import "EADingYueGridContentView.h"
#import "TKAccountManager.h"
#import "EASpaceModel.h"
#import "EASingleKongJianVC.h"

@interface EAKongJianPageVC () {
    EADingYueGridContentView *_contentView;
    EASpaceModel *_model;
}

@end

@implementation EAKongJianPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateContentView];
    [self startHeadRefresh:_contentView];
}

- (void)headRefreshAction {
    [self requestData];
}

- (void)updateContentView {
    [_contentView removeFromSuperview];
    weakify(self);
    _contentView = [[EADingYueGridContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) datas:[self contentData]];
    _contentView.subscribeBlock = ^(EADingYueGridContentView *view, NSDictionary *data) {
        strongify(self);
        [self subscribeAction:data];
    };
    _contentView.itemPressedBlock = ^(EADingYueGridContentView *view, NSUInteger section, NSUInteger row) {
        strongify(self);
        [self itemPressedWithSection:section row:row];
    };
    [self.view addSubview:_contentView];
    [self addHeaderRefreshView:_contentView];
}

- (void)subscribeAction:(NSDictionary *)data {
    
}

- (void)itemPressedWithSection:(NSUInteger)section row:(NSUInteger)row {
    EASingleKongJianVC *vc = [[EASingleKongJianVC alloc] init];
    EASpaceFloorlistModel *floorModel = _model.data.floorList[section];
    vc.rModel = floorModel.roomList[row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _contentView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

- (NSArray *)contentData {
    if (!_model.data.floorList.count) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (EASpaceFloorlistModel *listModel in _model.data.floorList) {
        NSMutableArray *items = [NSMutableArray array];
        for (EASpaceRoomlistModel *roomModel in listModel.roomList) {
            [items addObject:@{
                               @"name": ToSTR(roomModel.name),
                               @"id": ToSTR(roomModel.id),
                               }];
        }
        [array addObject:@{
                           @"title": ToSTR(listModel.name),
                           @"id": ToSTR(listModel.id),
                           @"items": items,
                           @"subscribed": @"0",
                           }];
    }
    return array;
}

#pragma mark - Request
- (void)requestData {
    [self nodata_hideView];
    weakify(self);
    NSMutableDictionary *params = @{@"productArray": [TKAccountManager sharedInstance].loginUserInfo.productArray ?: @[],
                                    }.mutableCopy;
    if (self.categoryId.length) {
        params[EAKongJianVCTypeKongJian == self.type ? @"bulidId" : @"deviceWhatId"] = self.categoryId;
    }
    NSString *path = EAKongJianVCTypeKongJian == self.type ? @"/eis/open/track/findTrackSpaces" : @"/eis/open/track/findTrackDevices";
    [TKRequestHandler postWithPath:path params:params jsonModelClass:EASpaceModel.class completion:^(id model, NSError *error) {
        strongify(self);
        [self requestDataDone:model];
    }];
}

- (void)requestDataDone:(EASpaceModel *)model {
    [self stopRefresh:_contentView];
    if (model.success) {
        _model = model;
        if (self.requestSuccessBlock) {
            self.requestSuccessBlock(model);
        }
        [self updateContentView];
    }
    if (!model.data.floorList.count) {
        [self nodata_showNoDataViewWithTapedBlock:nil];
    }
}

@end
