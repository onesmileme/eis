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
}

- (instancetype)initWithType:(EAAddRecordType)type {
    self = [super init];
    if (self) {
        _type = type;
        [self initContentData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    if (EAInputTypePicker == type) {
        dict[@"pickerData"] = @[@"包含关系", @"包含关系", @"包含关系", ];
    }
    return dict;
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
    _firstModel = model;
    [_chooseInputView setInputText:model.objName];
}

#pragma mark - submit
- (void)submit {
    __block NSString *toast = nil;
    if (EAAddRecordTypeText == _type) {
        [_inputViews enumerateObjectsUsingBlock:^(EAInputView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *inputText = TrimStr(obj.inputText);
            if (!inputText.length) {
                if (0 == idx) {
                    toast = @"请输入记录名称";
                } else if (1 == idx) {
                    toast = @"请选择对象";
                }
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
                if (0 == idx) {
                    toast = @"请输入记录名称";
                } else if (1 == idx) {
                    toast = @"请选择对象";
                } else if (2 == idx) {
                    toast = @"请输入记录值";
                } else if (3 == idx) {
                    toast = @"请选择点位数值时间";
                } else if (4 == idx) {
                    toast = @"请选择点位代表时间";
                }
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
    weakify(self);
    [TKRequestHandler postWithPath:@"/eis/open/record/saveEisWorkRecord" params:[self paramsForSubmit] jsonModelClass:EAPostBasicModel.class completion:^(id model, NSError *error) {
        strongify(self);
        EAPostBasicModel *aModel = model;
        [TKCommonTools showToast:aModel.msg];
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
            [_inputViews enumerateObjectsUsingBlock:^(EAInputView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *inputText = ToSTR(TrimStr(obj.inputText));
                if (0 == idx) {
                    params[@"recordName"] = inputText;
                } else if (2 == idx) {
                    params[@"recordValue"] = inputText;
                } else if (5 == idx) {
                    params[@"recordContent"] = inputText;
                } else if (3 == idx) {
                    params[@"pointReadTime"] = @((long long)([obj.selectedDate timeIntervalSince1970] * 1000));
                } else if (4 == idx) {
                    params[@"pointDeputyEndTime"] = @((long long)([obj.selectedDate timeIntervalSince1970] * 1000));
                }
            }];
            params[@"objType"] = _firstModel.objType;
            if (_user.uid.length) {
                params[@"assignPersonIds"] = @[_user.uid];
            }
            params[@"objIds"] = @[ToSTR(_firstModel.objId)];
        }];
    } else if (EAAddRecordTypeRelation == _type) {
        
    }
    return params;
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
