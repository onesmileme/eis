//
//  EAChooseObjVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAChooseObjVC.h"
#import "EATabSwitchControl.h"
#import "EARecordObjVC.h"
#import "EAScanViewController.h"
#import "EAMessageFilterResultViewController.h"
#import "EAMsgSearchHistoryView.h"
#import "EAMsgFilterModel.h"
#import "TKRequestHandler+Search.h"
#import "EARecordFilterCell.h"
#import "EARecordAttrModel.h"

typedef NS_ENUM(NSUInteger, EATableType) {
    EATableTypeNone,
    EATableTypeConditionSearch,
    EATableTypeSug,
    EATableTypeWordSearch,
};

@interface EAChooseObjVC () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    UIPageViewController *_pageViewController;
    EATabSwitchControl *_tabSwtichControl;
    NSMutableArray *_viewControllers;
    NSInteger _currentIndex;
    UITextField *_searchBar;
    
    UIButton *_resetButton;
    UIButton *_confirmButton;
}

@property(nonatomic , strong) UITableView *tableView;
@property(nonatomic , strong) UITextField *searchBar;

@property(nonatomic , assign) NSInteger *objPage;
@property(nonatomic , strong) NSMutableArray *objList;

@property(nonatomic , assign) NSInteger *conditionPage;
@property(nonatomic , strong) NSMutableArray *conditionList;

@property(nonatomic , copy)   NSString *searchKey;
@property(nonatomic , weak)   NSURLSessionDataTask *task;

@property(nonatomic , assign) EATableType tableType;
@property(nonatomic , strong) NSMutableArray *sugList;

@end

@implementation EAChooseObjVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.objList = [NSMutableArray array];
    self.sugList = [NSMutableArray array];
    
    [self initNavbar];
    NSArray *items = @[@"空间", @"设备", @"点", ];
    _tabSwtichControl = [[EATabSwitchControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)
                                                        itemArray:items
                                                        titleFont:[UIFont systemFontOfSize:14]
                                                        lineWidth:SCREEN_WIDTH / 3
                                                        lineColor:HexColor(0x28cfc1)];
    [_tabSwtichControl addTarget:self action:@selector(tabSwitched) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_tabSwtichControl];
    
    float width = (SCREEN_WIDTH - 30 - 50) / 2;
    float top = SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 60;
    _resetButton = [self bottomButtonWithText:@"重置" frame:CGRectMake(25, top, width, 36) isLeft:YES];
    _confirmButton = [self bottomButtonWithText:@"确认" frame:CGRectMake(_resetButton.right + 30, top, width, 36) isLeft:NO];

    _viewControllers = [NSMutableArray array];
    for (int i = 0; i < items.count; ++i) {
        EARecordObjVC *vc = [[EARecordObjVC alloc] initWithType:i];
        [_viewControllers addObject:vc];
    }
    
    [self addPageViewController];
    _pageViewController.view.frame = CGRectMake(0, _tabSwtichControl.bottom, SCREEN_WIDTH, _confirmButton.top - 10 - _tabSwtichControl.height);
    
    [_pageViewController setViewControllers:@[_viewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = HexColor(0xf7f7f7);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pageViewController.view.frame = CGRectMake(0, _tabSwtichControl.bottom, SCREEN_WIDTH, _confirmButton.top - 10 - _tabSwtichControl.height);
}

- (UIButton *)bottomButtonWithText:(NSString *)text frame:(CGRect)frame isLeft:(BOOL)left {
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:(left ? HexColor(0x666666) : [UIColor whiteColor]) forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(bottomClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 2;
    button.clipsToBounds = YES;
    button.layer.borderWidth = LINE_HEIGHT;
    button.layer.borderColor = HexColor(0xb0b0b0).CGColor;
    button.backgroundColor = left ? [UIColor whiteColor] : HexColor(0x28cfc1);
    [self.view addSubview:button];
    return button;
}

- (void)initNavbar {
    _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 33)];
    _searchBar.borderStyle = UITextBorderStyleNone;
    _searchBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    _searchBar.layer.cornerRadius = 4;
    _searchBar.layer.masksToBounds = true;
    _searchBar.delegate = self;
    _searchBar.textColor = HexColor(0x333333);
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //left view
    //search
    UIImageView *searchView =  [[UIImageView alloc]initWithImage:SYS_IMG(@"seach_icon1")];
    searchView.contentMode = UIViewContentModeCenter;
    searchView.frame = CGRectMake(0, 0, 35, 33);
    _searchBar.leftView = searchView;
    
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.titleView = _searchBar;
    
    _searchBar.font = SYS_FONT(14);
    
    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"请输入名称描述" attributes:@{NSFontAttributeName:SYS_FONT(14),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _searchBar.attributedPlaceholder = placeholder;
    
    UIImage *img = SYS_IMG(@"scan") ;
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(scanAction:)];
    self.navigationItem.rightBarButtonItem = scanItem;
}


- (void)addPageViewController {
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
}

#pragma mark - Actions
- (void)tabSwitched {
    if (_tabSwtichControl.selectedIndex >= _viewControllers.count) {
        return;
    }
    UIViewController *vc = [_viewControllers objectAtIndex:_tabSwtichControl.selectedIndex];
    if (_tabSwtichControl.selectedIndex > _currentIndex) {
        [_pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    } else {
        [_pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
        }];
    }
    _currentIndex = _tabSwtichControl.selectedIndex;
}

- (void)scanAction:(id)sender {
    EAScanViewController *controller = [EAScanViewController scanController];
    __weak typeof(self) wself = self;
    controller.doneBlock = ^(NSString *urlcode) {
        //TODO dosearch
        [wself.navigationController popViewControllerAnimated:true];
    };
    [self.navigationController pushViewController:controller animated:true];
}

- (void)bottomClicked:(UIButton *)btn {
    if (btn == _resetButton) {
        EARecordObjVC *vc = _viewControllers[_currentIndex];
        [vc resetCondition];
    } else {
        EARecordObjVC *vc = _viewControllers[_currentIndex];
        [self condintionSearch:vc.chooseConditions];
    }
}

#pragma mark - Search request
- (void)condintionSearch:(NSDictionary *)conditions {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:conditions];
    [TKRequestHandler postWithPath:self.conditionSearchPath params:params jsonModelClass:EAMsgSearchTipModel.class completion:^(id model, NSError *error) {
        
    }];
}

- (NSString *)conditionSearchPath {
    EARecordObjVC *vc = _viewControllers[_currentIndex];
    switch (vc.type) {
        case EARecordObjTypeKongJian:
            return @"/eis/open/object/findSpaces";
        case EARecordObjTypeSheBei:
            return @"/eis/open/object/findAssets";
        case EARecordObjTypeDian:
            return @"/eis/open/object/findMeters";
        default:
            break;
    }
}

#pragma mark - Page Delegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [_viewControllers indexOfObject:viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    return [_viewControllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [_viewControllers indexOfObject:viewController];
    if (index >= _viewControllers.count - 1) {
        return nil;
    }
    return [_viewControllers objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [_viewControllers indexOfObject:nextVC];
    _currentIndex = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        _tabSwtichControl.selectedIndex = _currentIndex ;
    }
}

#pragma mark - search
- (void)search:(NSString *)text {
    if (text.length == 0) {
        return;
    }
    if (self.task.state == NSURLSessionTaskStateRunning) {
        [self.task cancel];
    }
    
    EAMsgFilterModel *filterModel = [[EAMsgFilterModel alloc]init];
    filterModel.objName = text;
    weakify(self);
    NSURLSessionDataTask *task = [[TKRequestHandler sharedInstance] searchWithFilterParam:filterModel completion:^(NSURLSessionDataTask *task, EAMsgSearchTipModel *model, NSError *error) {
        strongify(self);
        [self searchDone:model text:text];
    }];
    self.task = task;
}

- (void)searchDone:(EAMsgSearchTipModel *)model text:(NSString *)text {
    if (model.data.count > 0) {
        self.searchKey = text;
        [self.objList removeAllObjects];
        [self.objList addObjectsFromArray:model.data];
        [self.tableView reloadData];
        [self showTableView];
    } else {
        [TKCommonTools showToast:(model ? kTextRequestNoData : kTextRequestFailed)];
    }
}

- (void)sugSearch:(NSString *)input {
    
}

- (void)showTableView {
    [self.view addSubview:self.tableView];
}

- (void)hideTableView {
    [self.tableView removeFromSuperview];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSug) {
        return [_sugList count];
    }
    return [_objList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isSug) {
        return 42;
    }
    return [EARecordFilterCell cellHeightWithModel:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (self.isSug) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"sug_id"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sug_id"];
            UILabel *label = TKTemplateLabel(SYS_FONT(14), HexColor(0x666666));
            label.tag = 1000;
            [cell addSubview:label];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 42 - LINE_HEIGHT, SCREEN_WIDTH, LINE_HEIGHT)];
            line.backgroundColor = LINE_COLOR;
            [cell addSubview:line];
        }
        UILabel *label = (UILabel *)[cell viewWithTag:1000];
        label.text = @"接口没好，就这样吧";
        [label sizeToFit];
        label.left = 15;
        label.centerY = 21;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"obj_id"];
        if (!cell) {
            cell = [[EARecordFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"obj_id"];
        }
        EAMsgSearchTipDataModel *model = _objList[indexPath.row];
        [((EARecordFilterCell *)cell) setModel:@{
                                                 @"title": ToSTR(model.objName),
                                                 @"desc": ToSTR(model.objDesc),
                                                 @"label": ToSTR(model.objType),
                                                 }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isSug) {
        NSString *key = self.searchBar.text;
        [self search:key];
    }
    else {
        EAMsgSearchTipDataModel *model = _objList[indexPath.row];
        if (self.doneBlock && model.objId.length) {
            self.doneBlock(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - uitextfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.tableType = EATableTypeSug;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *content = [[NSMutableString alloc]initWithString:textField.text ];
    [content replaceCharactersInRange:range withString:string];
    [self sugSearch:content];
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.tableType = EATableTypeWordSearch;
    [self search:textField.text];
    [textField resignFirstResponder];
    return true;
}

#pragma mark - TableType
- (BOOL)isSug {
    return (self.tableType == EATableTypeSug);
}

@end
