//
//  EAKongJianVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAKongJianVC.h"
#import "EATabSwitchControl.h"
#import "EADingYueGridContentView.h"
#import "EASubscribeHeaderView.h"
#import "TKAccountManager.h"
#import "EAKongJianPageVC.h"
#import "EAPageVCHandler.h"
#import "EASpaceModel.h"

@interface EAKongJianVC () <EAPageVCHandlerDelegate>

@end

@implementation EAKongJianVC {
    EASubscribeHeaderView *_headerView;
    EATabSwitchControl *_tabSwitchControl;
    NSArray *_datas;
    NSArray *_contents;
    EAPageVCHandler *_pageHandler;
    NSArray *_buildList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.type == EAKongJianVCTypeSheBei ? @"设置追踪" : @"空间追踪";
    [self createSubviews];
}

- (void)createSubviews {
    _headerView = [[EASubscribeHeaderView alloc] initWithIcon:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504329930636&di=31c2f68226b75ce1f5db43f3ecfd6659&imgtype=0&src=http%3A%2F%2Fa1.att.hudong.com%2F41%2F79%2F19300001290790131174792213082.jpg" subscribeCount:20 subscribed:YES];
    weakify(self);
    _headerView.subscribeClickBlock = ^{
        strongify(self);
    };
    _headerView.subscriberClickBlock = ^{
        strongify(self);
    };
    [self.view addSubview:_headerView];
    
    // tab
    _tabSwitchControl = [[EATabSwitchControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)
                                                        itemArray:nil
                                                        titleFont:[UIFont systemFontOfSize:15]
                                                        lineWidth:FlexibleWithTo6(115)
                                                        lineColor:HexColor((0x28cfc1))];
    [_tabSwitchControl addTarget:self action:@selector(tabSwitched:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_tabSwitchControl];
    
    _pageHandler = [[EAPageVCHandler alloc] init];
    _pageHandler.delegate = self;
    [self addChildViewController:_pageHandler.pageVC];
    [self.view addSubview:_pageHandler.pageVC.view];
    [_pageHandler moveToIndex:0 animated:NO];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pageHandler.pageVC.view.frame = CGRectMake(0, _tabSwitchControl.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _tabSwitchControl.height - NAVIGATION_BAR_HEIGHT - _headerView.bottom);
}

- (void)tabSwitched:(id)sender {
    [_pageHandler moveToIndex:_tabSwitchControl.selectedIndex animated:YES];
}

#pragma mark - Request
- (void)requestDataDone:(EASpaceModel *)model {
    if (!_buildList.count && model.data.buildList.count) {
        _buildList = model.data.buildList;
        NSMutableArray *array = [NSMutableArray array];
        for (EASpaceBuildlistModel *listModel in _buildList) {
            [array addObject:ToSTR(listModel.name)];
        }
        [_tabSwitchControl updateItemArray:array];
    }
}

- (NSString *)categoryIdWithIndex:(NSInteger)index {
    if (index >= 0 && index < _buildList.count) {
        EASpaceBuildlistModel *listModel = _buildList[index];
        return listModel.id;
    }
    return nil;
}

#pragma mark - EAPageVCHandlerDelegate
- (UIViewController *)pageHandler:(EAPageVCHandler *)handler viewControllerWithIndex:(NSUInteger)index {
    EAKongJianPageVC *vc = [[EAKongJianPageVC alloc] init];
    vc.type = self.type;
    weakify(self);
    vc.requestSuccessBlock = ^(EASpaceModel *model) {
        strongify(self);
        [self requestDataDone:model];
    };
    vc.categoryId = [self categoryIdWithIndex:index];
    return vc;
}

- (void)pageHandler:(EAPageVCHandler *)handler didMoveToIndex:(NSUInteger)index {
    _tabSwitchControl.selectedIndex = index;
}

@end
