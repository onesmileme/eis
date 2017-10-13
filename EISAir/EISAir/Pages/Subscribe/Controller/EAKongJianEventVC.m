//
//  EAKongJianEventVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAKongJianEventVC.h"
#import "UIImage+Additions.h"
#import "TKAccountManager.h"
#import "EAMessageModel.h"
#import "EAMessageTableViewCell.h"
#import "EATaskModel.h"
#import "EATaskInfoTableViewCell.h"
#import "EAMsgDetailViewController.h"
#import "EATaskDetailViewController.h"

static const int kTagButton = 100000;

@interface EAKongJianEventVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation EAKongJianEventVC {
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger _page;
    NSInteger _currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    
    [self createTabs];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    UINib *nib = [UINib nibWithNibName:@"EAMessageTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"msg_cell"];
    nib = [UINib nibWithNibName:@"EATaskInfoTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"task_cell"];
    
    [self updateButtonState];
    
    [self addRefreshView:_tableView];
    [self startHeadRefresh:_tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tableView.frame = CGRectMake(0, 45, SCREEN_WIDTH, self.view.height - 45);
}

- (void)createTabs {
    NSArray *tabs = @[@"消息", @"任务",];
    __block float left = 15;
    float width = 75;
    float interval = (SCREEN_WIDTH - 3 * 75 - 30) / 2;
    [tabs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(left, 10, width, 25)];
        [button addTarget:self action:@selector(tabPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:HexColor(0x444444) forState:UIControlStateNormal];
        [button setTitleColor:HexColor(0x28cfc1) forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:HexColor(0xf7f7f7)] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:[HexColor(0x28cfc1) colorWithAlphaComponent:0.1]] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 2.0;
        [self.view addSubview:button];
        left = button.right + interval;
        button.tag = kTagButton + idx;
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45 - LINE_HEIGHT, SCREEN_WIDTH, LINE_HEIGHT)];
    line.backgroundColor = LINE_COLOR;
    [self.view addSubview:line];
}

- (void)tabPressed:(UIButton *)sender {
    _currentIndex = sender.tag - kTagButton;
    [_dataArray removeAllObjects];
    _page = 0;
    [_tableView reloadData];
    [self updateButtonState];
    [self startHeadRefresh:_tableView];
}

- (void)updateButtonState {
    for (int i = 0; i < 3; ++i) {
        UIButton *btn = [self.view viewWithTag:(kTagButton + i)];
        btn.selected = _currentIndex == i;
    }
}

- (void)headRefreshAction {
    [self requestData:0];
}

- (void)footRefreshAction {
    [self requestData:_page + 1];
}

#pragma mark - Request
- (void)requestData:(NSInteger)page {
    [self nodata_hideView];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] = @(page);
    params[@"pageSize"] = @(kEISRequestPageSize);
    params[@"objList"] = @[ToSTR(self.spaceId)];
    params[@"personId"] = [TKAccountManager sharedInstance].loginUserInfo.personId;
    NSString *path = @"/eis/open/msg/findEisMessage";
    Class cls = EAMessageModel.class;
    if (1 == _currentIndex) {
        path = @"/eis/open/task/findEisTask";
        cls = EATaskModel.class;
    }
    weakify(self);
    [TKRequestHandler postWithPath:path params:params jsonModelClass:cls completion:^(id model, NSError *error) {
        strongify(self);
        [self reqeustDone:model page:page];
    }];
}

- (void)reqeustDone:(EAMessageModel *)model page:(NSInteger)page {
    [self stopRefresh:_tableView];
    if (model.success && page == 0) {
        [_dataArray removeAllObjects];
    }
    if (model.success) {
        BOOL hasPageData = NO;
        if (_currentIndex == 0) {
            [_dataArray addObjectsFromArray:model.data.list];
            hasPageData = model.data.list.count > 0;
        } else if (1 == _currentIndex) {
            EATaskModel *taskModel = (EATaskModel *)model;
            [_dataArray addObjectsFromArray:taskModel.data.list];
            hasPageData = taskModel.data.list.count > 0;
        }
        if (!hasPageData) {
            [TKCommonTools showToast:kTextRequestNoData];
        }
        [_tableView reloadData];
    } else {
        [TKCommonTools showToast:kTextRequestFailed];
    }
    if (!_dataArray.count) {
        [self nodata_showNoDataViewWithTapedBlock:nil];
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
    if (0 == _currentIndex || 1 == _currentIndex) {
        return 81;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _currentIndex) {
        EAMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msg_cell"];
        [cell updateWithModel:_dataArray[indexPath.row]];
        return cell;
    }
    else if (1 == _currentIndex) {
        EATaskInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"task_cell"];
        [cell updateWithModel:_dataArray[indexPath.row]];
        return cell;
    }
    else if (2 == _currentIndex) {
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _currentIndex) {
        EAMsgDetailViewController *controller = [[EAMsgDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
        controller.msgModel = _dataArray[indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (1 == _currentIndex) {
        EATaskDetailViewController *controller = [EATaskDetailViewController controller];
        controller.task = _dataArray[indexPath.row];
        [self.navigationController pushViewController:controller animated:true];
    }
}


@end
