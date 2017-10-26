//
//  EAAddRecordVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAddRecordVC.h"
#import "EAInputView.h"
#import "NSString+ValidateFormat.h"
#import "EAUserSearchViewController.h"
#import "EAUserModel.h"
#import "EAChooseObjVC.h"
#import "EAMsgSearchTipModel.h"
#import "NSString+JSON.h"
#import "EARelationModel.h"

static NSString *const kEARelations = @"kEARelations";

@interface EAAddRecordVC ()

@end

@implementation EAAddRecordVC {
    EAAddRecordType _type;
    NSArray *_contentDatas;
    NSArray *_inputViews;
    
    UIScrollView *_contentView;
    UIButton *_submitBtn;
    EAInputView *_chooseInputView;
    EAUserDataListModel *_user;
    EAMsgSearchTipDataModel *_firstModel;
    EAMsgSearchTipDataModel *_secondModel;
    NSDictionary *_relations;
}

- (instancetype)initWithType:(EAAddRecordType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (EAAddRecordTypeRelation == _type) {
        _relations = [[NSUserDefaults standardUserDefaults] objectForKey:kEARelations];
    }
    [self initContentData];
    
    [self updateTitle];
    _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 60, SCREEN_WIDTH - 36, 45)];
    _submitBtn.backgroundColor = HexColor(0x28cfc1);
    _submitBtn.layer.cornerRadius = 5;
    _submitBtn.clipsToBounds = YES;
    _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _submitBtn.top - 10)];
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.backgroundColor = HexColor(0xf7f7f7);
    [self.view addSubview:_contentView];
    
    [self createInputViews];
    [self requestRelations];
}

- (void)initContentData {
    weakify(self);
    EAInputChooseBlock objBlock = ^ (EAInputView *view) {
        strongify(self);
        self->_chooseInputView = view;
        [self chooseObj];
    };
    EAInputChooseBlock atBlock = ^ (EAInputView *view) {
        strongify(self);
        self->_chooseInputView = view;
        [self chooseContanct];
    };
    if (EAAddRecordTypeText == _type) {
        _contentDatas = @[
                          @[
                              [self itemWithType:EAInputTypeOneLineInput
                                           title:@"记录名称"
                                     placeholder:@"请输入记录名称（必填）"],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"记录对象"
                                     placeholder:@"请选择（必填）"
                                     chooseBlock:objBlock],
                              [self itemWithType:EAInputTypeMultiLinesInput
                                           title:@"记录内容"
                                     placeholder:@"请输入记录内容（必填3-50字内）"],
                              ],
                          @[
                              [self itemWithType:EAInputTypeChoose
                                           title:@"请选择@"
                                     placeholder:@"请选择"
                                     chooseBlock:atBlock],
                              ],
                          ];
    }
    else if (EAAddRecordTypeNumber == _type) {
        _contentDatas = @[
                          @[
                              [self itemWithType:EAInputTypeOneLineInput
                                           title:@"记录名称"
                                     placeholder:@"请输入记录名称（必填）"],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"记录对象"
                                     placeholder:@"请选择（必填）"
                                     chooseBlock:objBlock],
                              [self itemWithType:EAInputTypeOneLineInput
                                           title:@"记录值"
                                     placeholder:@"请输入记录值"],
                              ],
                          @[
                              [self itemWithType:EAInputTypeDate
                                           title:@"点位数值时间"
                                     placeholder:@"请选择"],
                              [self itemWithType:EAInputTypeDate
                                           title:@"点位代表时间"
                                     placeholder:@"请选择"],
                              [self itemWithType:EAInputTypeMultiLinesInput
                                           title:@"记录内容"
                                     placeholder:@"请输入记录内容（必填3-50字内）"],
                              ],
                          @[
                              [self itemWithType:EAInputTypeChoose
                                           title:@"请选择@"
                                     placeholder:@"请选择"
                                     chooseBlock:atBlock],
                              ],
                          ];
    }
    else {
        EAInputChooseBlock qishiBlock = ^ (EAInputView *view) {
            strongify(self);
            self->_chooseInputView = view;
            [self chooseObj];
        };
        EAInputChooseBlock jieshuBlock = ^ (EAInputView *view) {
            strongify(self);
            self->_chooseInputView = view;
            [self chooseObj];
        };
        _contentDatas = @[
                          @[
                              [self itemWithType:EAInputTypePicker
                                           title:@"关系类型"
                                     placeholder:@"请选择关系类型（必填）"],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"起始对象"
                                     placeholder:@"请选择起始对象（必填）"
                                     chooseBlock:qishiBlock],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"结束对象"
                                     placeholder:@"请选择结束对象（必填）"
                                     chooseBlock:jieshuBlock],
                              ],
                          ];
    }
}

- (NSDictionary *)itemWithType:(EAInputType)type
                         title:(NSString *)title
                   placeholder:(NSString *)placeHolder {
    return [self itemWithType:type title:title placeholder:placeHolder chooseBlock:nil];
}

- (NSDictionary *)itemWithType:(EAInputType)type
                         title:(NSString *)title
                   placeholder:(NSString *)placeHolder
                   chooseBlock:(EAInputChooseBlock)chooseBlock {
    NSMutableDictionary *dict = @{
                                  @"type": @(type),
                                  @"title": title ?: @"",
                                  @"placeholder": placeHolder ?: @"",
                                  }.mutableCopy;
    if (chooseBlock) {
        dict[@"chooseBlock"] = chooseBlock;
    }
    if (EAAddRecordTypeRelation == _type && EAInputTypePicker == type && _relations.count) {
        dict[@"pickerData"] = self.relationDescs;
    }
    return dict;
}

- (NSArray *)relationDescs {
    NSArray *allValues = _relations.allValues;
    return [allValues sortedArrayUsingComparator:^NSComparisonResult(NSString  *_Nonnull obj1, NSString  *  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
}

- (void)updateTitle {
    NSString *title = @"添加文本记录";
    if (EAAddRecordTypeNumber == _type) {
        title = @"添加数值记录";
    } else if (EAAddRecordTypeRelation == _type) {
        title = @"添加关系记录";
    }
    self.title = title;
}

- (void)createInputViews {
    float top = 10;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _contentDatas.count; ++i) {
        NSArray *itemGroup = _contentDatas[i];
        for (int j = 0; j < itemGroup.count; ++j) {
            NSDictionary *itemDic = itemGroup[j];
            EAInputType type = [itemDic[@"type"] intValue];
            NSString *title = itemDic[@"title"];
            NSString *placeholder = itemDic[@"placeholder"];
            NSArray *pickerData = itemDic[@"pickerData"];
            float height = EAInputTypeMultiLinesInput == type ? 85 : 45;
            CGRect frame = CGRectMake(0, top, _contentView.width, height);
            EAInputView *inputView = [[EAInputView alloc] initWithFrame:frame
                                                                   type:type
                                                                  title:title
                                                            placeHolder:placeholder
                                                         pickerContents:pickerData];
            inputView.chooseBlock = itemDic[@"chooseBlock"];
            if ([title isEqualToString:@"记录值"]) {
                [inputView setInputKeyboardType:(UIKeyboardTypeNumbersAndPunctuation)];
            }
            [_contentView addSubview:inputView];
            [array addObject:inputView];
            if (j == 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentView.width, LINE_HEIGHT)];
                line.backgroundColor = LINE_COLOR;
                [inputView addSubview:line];
            }
            
            top = inputView.bottom;
        }
        top += 10;
    }
    _inputViews = array;
    _contentView.contentSize = CGSizeMake(_contentView.width, MAX(_contentView.height, top));
}

#pragma mark - Choose Actions
- (void)chooseContanct {
    EAUserSearchViewController *vc = [[EAUserSearchViewController alloc] init];
    vc.title = @"选择@";
    weakify(self);
    vc.chooseUserBlock = ^ (NSArray *users) {
        strongify(self);
        [self choosedUser:users.firstObject];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)choosedUser:(EAUserDataListModel *)user {
    if (user) {
        _user = user;
        [_chooseInputView setInputText:user.name];
    }
}

- (void)chooseObj {
    EAChooseObjVC *vc = [[EAChooseObjVC alloc] init];
    weakify(self);
    vc.doneBlock = ^(EAMsgSearchTipDataModel *model) {
        strongify(self);
        [self choosedObj:model];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)choosedObj:(EAMsgSearchTipDataModel *)model {
    if (EAAddRecordTypeRelation == _type) {
        if ([_inputViews indexOfObject:_chooseInputView] == 1) {
            _firstModel = model;
        } else {
            _secondModel = model;
        }
    } else {
        _firstModel = model;
    }
    [_chooseInputView setInputText:model.objName];
}

#pragma mark - relations
- (void)requestRelations {
    weakify(self);
    [TKRequestHandler getWithPath:@"/eis/open/constants/findRelationalTypes" params:nil jsonModelClass:EARelationModel.class completion:^(id model, NSError *error) {
        strongify(self);
        [self requestRelationsDone:model];
    }];
}

- (void)requestRelationsDone:(EARelationModel *)aModel {
    if (aModel.data) {
        NSDictionary *dic = [aModel.data toDictionary];
        if (dic.count) {
            [[NSUserDefaults standardUserDefaults] setValue:dic forKey:kEARelations];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (EAAddRecordTypeRelation == _type && !(self->_relations.count)) {
                self->_relations = dic;
                
                for (EAInputView *inputView in _inputViews) {
                    if (inputView.type == EAInputTypePicker) {
                        [inputView updatePickerContents:[self relationDescs]];
                        break;
                    }
                }
            }
        }
    }
}

#pragma mark - submit
- (void)submit {
    __block NSString *toast = nil;
    if (EAAddRecordTypeText == _type) {
        [_inputViews enumerateObjectsUsingBlock:^(EAInputView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *inputText = TrimStr(obj.inputText);
            if (!inputText.length) {
                if (1 == idx) {
                    toast = @"请选择对象";
                }
            }
            if (0 == idx && (inputText.length < 2 || inputText.length > 20)) {
                toast = @"请输入2~20个字的记录名称";
            }
            if (2 == idx && inputText.length < 3) {
                toast = @"请输入记录内容(3-50字)";
            }
            if (toast.length) {
                *stop = YES;
            }
        }];
    } else if (EAAddRecordTypeNumber == _type) {
        [_inputViews enumerateObjectsUsingBlock:^(EAInputView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *inputText = TrimStr(obj.inputText);
            if (!inputText.length) {
                if (1 == idx) {
                    toast = @"请选择对象";
                } else if (2 == idx) {
                    toast = @"请输入记录值";
                } else if (3 == idx) {
                    toast = @"请选择点位数值时间";
                } else if (4 == idx) {
                    toast = @"请选择点位代表时间";
                }
            }
            if (0 == idx && (inputText.length < 2 || inputText.length > 20)) {
                toast = @"请输入2~20个字的记录名称";
            }
            if (5 == idx && inputText.length < 3) {
                toast = @"请输入记录内容(3-50字)";
            }
            if (toast.length) {
                *stop = YES;
            }
        }];
    } else if (EAAddRecordTypeRelation == _type) {
        [_inputViews enumerateObjectsUsingBlock:^(EAInputView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *inputText = TrimStr(obj.inputText);
            if (!inputText.length) {
                if (0 == idx) {
                    toast = @"请选择关系类型";
                } else if (1 == idx) {
                    toast = @"请选择起始对象";
                } else if (2 == idx) {
                    toast = @"请选择结束对象";
                }
            }
            if (toast.length) {
                *stop = YES;
            }
        }];
    }
    if (toast.length) {
        [TKCommonTools showToast:toast];
        return;
    }
    MBProgressHUD *hud = [EATools showLoadHUD:self.view];
    weakify(self);
    [TKRequestHandler postWithPath:@"/eis/open/record/saveEisWorkRecord" params:[self paramsForSubmit] jsonModelClass:EAPostBasicModel.class completion:^(id model, NSError *error) {
        strongify(self);
        EAPostBasicModel *aModel = model;
        hud.label.text = aModel.msg;
        hud.mode = MBProgressHUDModeText;
        hud.label.textColor = [UIColor whiteColor];
        [hud hideAnimated:true afterDelay:0.7];
//        [TKCommonTools showToast:aModel.msg];
        if (aModel.success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (NSDictionary *)paramsForSubmit {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"recordType"] = self.recordType;
    if (EAAddRecordTypeText == _type) {
        [_inputViews enumerateObjectsUsingBlock:^(EAInputView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *inputText = ToSTR(TrimStr(obj.inputText));
            if (0 == idx) {
                params[@"recordName"] = inputText;
            } else if (2 == idx) {
                params[@"recordContent"] = inputText;
            }
        }];
        params[@"objType"] = _firstModel.objType;
        if (_user.uid.length) {
            params[@"assignPersonIds"] = @[_user.uid];
        }
        params[@"objIds"] = @[ToSTR(_firstModel.objId)];
    } else if (EAAddRecordTypeNumber == _type) {
        [_inputViews enumerateObjectsUsingBlock:^(EAInputView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *inputText = ToSTR(TrimStr(obj.inputText));
            if (0 == idx) {
                params[@"recordName"] = inputText;
            } else if (2 == idx) {
                params[@"recordValue"] = inputText;
            } else if (5 == idx) {
                params[@"recordContent"] = inputText;
            } else if (3 == idx) {
                params[@"pointReadTime"] = inputText;
            } else if (4 == idx) {
                params[@"pointDeputyEndTime"] = inputText;
            }
        }];
        params[@"objType"] = _firstModel.objType;
        if (_user.uid.length) {
            params[@"assignPersonIds"] = @[_user.uid];
        }
        params[@"objIds"] = @[ToSTR(_firstModel.objId)];
    } else if (EAAddRecordTypeRelation == _type) {
        [_inputViews enumerateObjectsUsingBlock:^(EAInputView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *inputText = ToSTR(TrimStr(obj.inputText));
            if (0 == idx) {
                params[@"refType"] = [self relationKeyWithValue:inputText];
            }
            *stop = YES;
        }];
        params[@"startObjId"] = _firstModel.objId;
        params[@"startObjType"] = _firstModel.objType;
        params[@"endObjIds"] = @[ToSTR(_secondModel.objId)];
        params[@"endObjType"] = _secondModel.objType;
    }
    return params;
}

- (NSString *)relationKeyWithValue:(NSString *)value {
    __block NSString *result = nil;
    [_relations enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:value]) {
            result = key;
            *stop = YES;
        }
    }];
    return result ?: @"";
}

- (NSString *)recordType {
    switch (_type) {
        case EAAddRecordTypeText:
            return @"text";
        case EAAddRecordTypeNumber:
            return @"number";
        case EAAddRecordTypeRelation:
            return @"relation";
        default:
            break;
    }
    return @"text";
}

@end
