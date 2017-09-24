//
//  EARecordObjVC.m
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EARecordObjVC.h"
#import "EASearchCondintionSelectControl.h"
#import "TKRequestHandler+Simple.h"
#import "EAReportListModel.h"

static NSString *kRequestSpace = @"/eis/open/object/findSpaceAssetType";
static NSString *kRequestDevice = @"/eis/open/object/findAssets";
static NSString *kRequestPoint = @"/eis/open/object/findSpaceAssetType";

@interface EARecordObjVC () {
    NSArray *_dataArray;
    
    UIScrollView *_contentView;
    NSMutableArray *_selectedIndexs;
}

@end

@implementation EARecordObjVC

- (instancetype)initWithType:(EARecordObjType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    [self refreshView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _contentView.frame = self.view.bounds;
}

- (void)loadData {
    _dataArray = @[
                   @{
                       @"title": @"空间类型",
                       @"values": @[@"不限", @"租区", @"市区", @"东三环", @"昌平区", @"高端小区", ],
                       },
                   @{
                       @"title": @"空间类型",
                       @"values": @[@"不限", @"租区", @"市区", @"东三环", @"昌平区", @"高端小区", ],
                       },
                   @{
                       @"title": @"空间类型",
                       @"values": @[@"不限", @"租区", @"市区", @"东三环",  ],
                       },
                   @{
                       @"title": @"空间类型",
                       @"values": @[@"不限", @"租区", ],
                       },
                   @{
                       @"title": @"空间类型",
                       @"values": @[@"不限", @"租区", @"市区", @"东三环",  ],
                       },
                   @{
                       @"title": @"空间类型",
                       @"values": @[@"不限", @"租区", @"市区", @"东三环",  ],
                       },
                   ];
    _selectedIndexs = [NSMutableArray array];
    for (id obj in _dataArray) {
        [_selectedIndexs addObject:@(0)];
    }
}

- (void)loadDataComplete:(id)model {
    
}

- (void)refreshView {
    float top = 18;
    for (int i = 0; i < _dataArray.count; ++i) {
        NSDictionary *dict = _dataArray[i];
        int tag = i + 10000;
        EASearchCondintionSelectControl *control = [[EASearchCondintionSelectControl alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 0) title:dict[@"title"] itemArray:dict[@"values"]];
        control.tag = tag;
        [control addTarget:self action:@selector(conditionControlPressed:) forControlEvents:UIControlEventValueChanged];
        [_contentView addSubview:control];
        top = control.bottom + 16;
    }
    _contentView.contentSize = CGSizeMake(_contentView.width, top);
}

- (void)conditionControlPressed:(EASearchCondintionSelectControl *)control {
    
}

- (void)resetCondition {
    for (int i = 0; i < _dataArray.count; ++i) {
        int tag = i + 10000;
        EASearchCondintionSelectControl *control = [_contentView viewWithTag:tag];
        [control reset];
    }
}

@end
