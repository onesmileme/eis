//
//  EAConditionSearchVC.m
//  EISAir
//
//  Created by iwm on 2017/9/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAConditionSearchVC.h"
#import "EAConditionSearchModel.h"
#import "EARecordFilterCell.h"

@interface EAConditionSearchVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation EAConditionSearchVC {
    NSMutableArray *_dataArray;
    NSInteger _page;
    EARecordObjType _type;
    NSDictionary *_conditions;
    
    UITableView *_tableView;
}

- (instancetype)initWithType:(EARecordObjType)type conditions:(NSDictionary *)conditions {
    self = [super init];
    if (self) {
        _type = type;
        _conditions = conditions;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    
    [self updateTitle];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self addRefreshView:_tableView];
    [self startHeadRefresh:_tableView];
}

- (void)updateTitle {
    NSString *title = @"点筛选";
    if (EARecordObjTypeKongJian == _type) {
        title = @"空间筛选";
    } else if (EARecordObjTypeSheBei == _type) {
        title = @"设备筛选";
    }
    self.title = title;
}

- (void)headRefreshAction {
    [self condintionSearch:0];
}

- (void)footRefreshAction {
    [self condintionSearch:_page+1];
}

#pragma mark - Search request
- (void)condintionSearch:(NSInteger)page {
    [self nodata_hideView];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:_conditions];
    params[@"pageNum"] = @(page);
    params[@"pageSize"] = @(kEISRequestPageSize);
    weakify(self);
    [TKRequestHandler postWithPath:self.conditionSearchPath params:params jsonModelClass:EAConditionSearchModel.class completion:^(id model, NSError *error) {
        strongify(self);
        [self condintionSearchedModel:model page:page];
    }];
}

- (void)condintionSearchedModel:(EAConditionSearchModel *)model page:(NSInteger)page {
    [self stopRefresh:_tableView];
    if (model.success) {
        _page = page;
        if (page == 0) {
            [_dataArray removeAllObjects];
        }
        if (model.data.list.count) {
            [_dataArray addObjectsFromArray:model.data.list];
        } else {
            [TKCommonTools showToast:_dataArray.count ? kTextRequestNoMoreData : kTextRequestNoData];
            if (!_dataArray.count) {
                [self.navigationController popToViewController:self animated:YES];
            }
        }
        [_tableView reloadData];
    } else {
        [self nodata_showNoDataViewWithTapedBlock:nil];
        [TKCommonTools showToast:kTextRequestFailed];
    }
}

- (NSString *)conditionSearchPath {
    switch (_type) {
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

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [EARecordFilterCell cellHeightWithModel:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EARecordFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"obj_id"];
    if (!cell) {
        cell = [[EARecordFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"obj_id"];
    }
    EAConditionSearchListModel *model = _dataArray[indexPath.row];
    [cell setModel:@{
                     @"title": ToSTR(model.name),
                     @"desc": ToSTR(model.desc),
                     @"label": ToSTR(model.assetTypeName),
                     }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EAConditionSearchListModel *model = _dataArray[indexPath.row];
    switch (_type) {
        case EARecordObjTypeKongJian:
            model.objType = @"space";
            break;
        case EARecordObjTypeSheBei:
            model.objType = @"device";
            break;
        case EARecordObjTypeDian:
            model.objType = @"point";
            break;
        default:
            break;
    }
    if (self.doneBlock && model.id.length) {
        self.doneBlock(model);
    }
}

@end
