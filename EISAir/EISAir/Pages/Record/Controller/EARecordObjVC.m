//
//  EARecordObjVC.m
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EARecordObjVC.h"
#import "EASearchCondintionSelectControl.h"
#import "EARecordAttrModel.h"
#import "NSString+JSON.h"

static NSString *kRequestSpace = @"/eis/open/object/findSpaceAssetType";
static NSString *kRequestDeviceOne = @"/eis/open/object/findDeviceOneLevelClassify";
static NSString *kRequestDeviceTwo = @"/eis/open/object/findDeviceTwoLevelClassify";
static NSString *kRequestPoint = @"/eis/open/object/findMeasureList";

@interface EARecordObjVC () {
    NSArray *_dataArray;
    
    UIScrollView *_contentView;
    NSMutableArray *_selectedIndexs;
    NSArray *_attrModelArray;
    NSArray *_controls;
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
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    [self requestData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _contentView.frame = self.view.bounds;
}

- (void)loadData {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0;
    for (EARecordAttrModel *model in _attrModelArray) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"title"] = [self itemTitle:index];
        NSMutableArray *values = [NSMutableArray array];
        for (EARecordAttrDataModel *data in model.data) {
            [values addObject:ToSTR(data.name)];
        }
        dict[@"values"] = values;
        [array addObject:dict];
        index++;
    }
    _dataArray = array;
}

- (NSString *)itemTitle:(NSInteger)index {
    switch (_type) {
        case EARecordObjTypeKongJian:
            return (0 == index ? @"空间类型" : @"资产属性");
        case EARecordObjTypeSheBei:
            return (0 == index ? @"设备分类" : @"设备子类");
        case EARecordObjTypeDian:
            return (@"点分类");
        default:
            break;
    }
}

- (void)refreshView {
    [self loadData];
    
    NSMutableArray *array = [NSMutableArray array];
    float top = 18;
    for (int i = 0; i < _dataArray.count; ++i) {
        NSDictionary *dict = _dataArray[i];
        int tag = i + 10000;
        EASearchCondintionSelectControl *control = [[EASearchCondintionSelectControl alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 0) title:dict[@"title"] itemArray:dict[@"values"]];
        control.tag = tag;
        [control addTarget:self action:@selector(conditionControlPressed:) forControlEvents:UIControlEventValueChanged];
        [_contentView addSubview:control];
        top = control.bottom + 16;
        [array addObject:control];
    }
    _controls = array;
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

#pragma mark - request
- (void)requestData {
    [TKCommonTools showLoadingOnView:self.view];
    weakify(self);
    if (_type == EARecordObjTypeSheBei) {
        dispatch_group_t group = dispatch_group_create();
        __block EARecordAttrModel *firstModel;
        __block EARecordAttrModel *secondModel;
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [TKRequestHandler postWithPath:kRequestDeviceOne params:nil jsonModelClass:EARecordAttrModel.class completion:^(id model, NSError *error) {
                firstModel = model;
            }];
        });
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [TKRequestHandler postWithPath:kRequestDeviceTwo params:nil jsonModelClass:EARecordAttrModel.class completion:^(id model, NSError *error) {
                secondModel = model;
            }];
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            strongify(self);
            [self requestedDeviceDone:firstModel sModel:secondModel];
        });
    } else {
        [TKRequestHandler postWithPath:[self requestPath] params:nil jsonModelClass:EARecordAttrModel.class completion:^(id model, NSError *error) {
            strongify(self);
            [self requestedDataDone:model];
        }];
    }
}

- (void)requestedDeviceDone:(EARecordAttrModel *)firstModel sModel:(EARecordAttrModel *)secondModel {
    [TKCommonTools hideLoadingOnView:self.view];
    if (firstModel.data.count && secondModel.data.count) {
        _attrModelArray = @[firstModel, secondModel];
        [self refreshView];
    } else {
        [TKCommonTools showToast:kTextRequestNoData];
    }
}

- (void)requestedDataDone:(EARecordAttrModel *)model {
    [TKCommonTools hideLoadingOnView:self.view];
    if (model.data.count) {
        NSDictionary *dict = @{
                               @"name": @"不限",
                               @"id": @"",
                               };
        EARecordAttrDataModel *buxianModel = [[EARecordAttrDataModel alloc] initWithDictionary:dict error:nil];
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:buxianModel];
        [array addObjectsFromArray:model.data];
        model.data = array;
        if (EARecordObjTypeKongJian == _type) {
            EARecordAttrModel *kongJianModel = [[EARecordAttrModel alloc] initWithDictionary:self.kongJianDefaultDic error:nil];
            _attrModelArray = @[kongJianModel, model];
        } else {
            _attrModelArray = @[model];
        }
        [self refreshView];
    } else {
        [TKCommonTools showToast:kTextRequestNoData];
    }
}

- (NSDictionary *)kongJianDefaultDic {
    return @{
             @"data": @[
                     @{
                         @"name": @"不限",
                         @"id": @"",
                         },
                     @{
                         @"name": @"建筑",
                         @"id": @"building",
                         },
                     @{
                         @"name": @"楼层",
                         @"id": @"floor",
                         },
                     @{
                         @"name": @"房间",
                         @"id": @"room",
                         },
                     ],
             };
}

- (NSString *)requestPath {
    switch (_type) {
        case EARecordObjTypeKongJian:
            return kRequestSpace;
        case EARecordObjTypeSheBei:
            return kRequestDeviceOne;
        case EARecordObjTypeDian:
            return kRequestPoint;
        default:
            break;
    }
    return kRequestSpace;
}

- (NSDictionary *)chooseConditions {
    NSMutableArray *shebeiArray = [NSMutableArray array];
    NSMutableDictionary *conditions = [NSMutableDictionary dictionary];
    [_controls enumerateObjectsUsingBlock:^(EASearchCondintionSelectControl *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.selectedIndex != 0) {
            EARecordAttrModel *model = _attrModelArray[idx];
            if (obj.selectedIndex < model.data.count) {
                EARecordAttrDataModel *dataModel = model.data[obj.selectedIndex];
                switch (_type) {
                    case EARecordObjTypeKongJian:
                        if (0 == idx) {
                            conditions[@"spaceType"] = dataModel.id;
                        } else if (1 == idx) {
                            conditions[@"assetType"] = dataModel.id;
                        }
                        break;
                    case EARecordObjTypeSheBei:
                        [shebeiArray addObject:dataModel.id];
                        break;
                    case EARecordObjTypeDian:
                        if (0 == idx) {
                            conditions[@"dataType"] = dataModel.id;
                        } else if (1 == idx) {
                            conditions[@"measureId"] = dataModel.id;
                        } else if (2 == idx) {
                            conditions[@"what"] = dataModel.id;
                        }
                        break;
                    default:
                        break;
                }
            }
        }
    }];
    if (shebeiArray.count) {
        conditions[@"classificationIds"] = [NSString json_stringWithArray:shebeiArray];
    }
    return conditions;
}

@end
