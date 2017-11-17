//
//  EASubscribePageVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASubscribePageVC.h"
#import "EASubscribeCell.h"
#import "EAKongJianVC.h"
#import "EAAllSubscribeModel.h"
#import "TKAccountManager.h"

@interface EASubscribePageVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_dataArray;
}

@end

@implementation EASubscribePageVC {
    EASubscribePageType _type;
}

- (instancetype)initWithType:(EASubscribePageType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self addHeaderRefreshView:_tableView];
    [self startHeadRefresh:_tableView];
}

- (void)headRefreshAction {
    [self requestData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

#pragma mark - TableView Delegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [EASubscribeCell cellHeightWithModel:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    EASubscribeCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[EASubscribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        weakify(self);
        cell.subscribeClickBlock = ^ {
            strongify(self);
        };
    }
    [cell setModel:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EABaseViewController *vc = nil;
    if (indexPath.row == 2) {
        vc = [[NSClassFromString(@"EADingYueEnergyMainVC") alloc] init];
    } else {
        EAKongJianVC *kjVC = [[EAKongJianVC alloc] init];
        kjVC.type = indexPath.row == 0 ? EAKongJianVCTypeKongJian : EAKongJianVCTypeSheBei;
        vc = kjVC;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Request
- (void)requestData {
    
#if kOnLine
    NSString *path = EASubscribePageTypeMe == _type ? @"/eis/open/subscribe/findEisSubscribeByPerson" : @"/eis/open/subscribe/findAllEisSubscribe";
#else
        NSString *path = EASubscribePageTypeMe == _type ? @"/eis/open/subscribe/findEisSubscribeByPerson" : @"/app/eis/open/subscribe/findAllEisSubscribe";
#endif
    NSDictionary *params = nil;
    if (EASubscribePageTypeMe == _type) {
        params = @{ @"personId": ToSTR([TKAccountManager sharedInstance].loginUserInfo.personId)};
    }
    weakify(self);
    [TKRequestHandler postWithPath:path params:params jsonModelClass:EAAllSubscribeModel.class completion:^(id model, NSError *error) {
        strongify(self);
        [self requestDataDone:model];
    }];
}

- (void)requestDataDone:(EAAllSubscribeModel *)model {
    [self stopRefresh:_tableView];
    if (model.success && model.data.count) {
        NSMutableArray *array = [NSMutableArray array];
        int i = 0;
        for (EAAllSubscribeDataModel *dataModel in model.data) {
            [array addObject:@{
                               @"name": ToSTR(dataModel.modularName),
                               @"desc": ToSTR([self descWithModel:dataModel]),
                               @"pic": [NSString stringWithFormat:@"dingyue_pic%d", i % 3 + 1],
                               @"subscribed": ToSTR(dataModel.isSubscribe),
                               }];
            ++i;
        }
        _dataArray = array;
        [_tableView reloadData];
    } else {
        [self nodata_showNoDataViewWithTapedBlock:nil];
    }
}

- (NSString *)descWithModel:(EAAllSubscribeDataModel *)model {
    return @"薛之谦等100人订阅";
}

@end
