//
//  EASubscribeViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASubscribeViewController.h"
#import "EATabSwitchControl.h"
#import "EASubscribeCell.h"
#import "EADingYueRenVC.h"
#import "TKRequestHandler+Subscribe.h"
#import "EADingYueEnergyMainVC.h"
#import "EAKongJianVC.h"

@interface EASubscribeViewController () <UITableViewDelegate, UITableViewDataSource> {
    EATabSwitchControl *_tabSwitchControl;
    UITableView *_tableView;
    
    NSArray *_dataArray;
}

@end

@implementation EASubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订阅";
    self.tabBarItem.title = @"";
    self.view.backgroundColor = [UIColor themeGrayColor];
    [self initNavbar];
    
    _dataArray = @[@1, @2, @3];
    
    // tab
    _tabSwitchControl = [[EATabSwitchControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)
                                                        itemArray:@[@"我的", @"全部"]
                                                        titleFont:[UIFont systemFontOfSize:15]
                                                        lineWidth:FlexibleWithTo6(115)
                                                        lineColor:HexColor(0x058497)];
    [_tabSwitchControl addTarget:self action:@selector(tabSwitched:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_tabSwitchControl];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _tabSwitchControl.bottom, self.view.width, self.view.height - _tabSwitchControl.bottom)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initNavbar {
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(0, 0, 40, 40);
    [menuButton setImage:SYS_IMG(@"common_menu") forState:UIControlStateNormal];
    [menuButton sizeToFit];
    [menuButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItems = @[menuItem];
}

#pragma mark - Request
- (void)fetchAllSubscribes {
    [[TKRequestHandler sharedInstance] fetchAllSubscribesCompletion:^(NSURLSessionDataTask *task, id model, NSError *error) {
        
    }];
}

#pragma mark - Actions
- (void)menuAction {
    [[EAPushManager sharedInstance] handleOpenUrl:@"eis://show_home"];
}

- (void)tabSwitched:(EATabSwitchControl *)control {
    
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
//        vc = [[EADingYueEnergyMainVC alloc] init];
        vc = [[NSClassFromString(@"EADingYueEnergyHistoryVC") alloc] init];
    } else {
        EAKongJianVC *kjVC = [[EAKongJianVC alloc] init];
        kjVC.type = indexPath.row == 0 ? EAKongJianVCTypeKongJian : EAKongJianVCTypeSheBei;
        vc = kjVC;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
