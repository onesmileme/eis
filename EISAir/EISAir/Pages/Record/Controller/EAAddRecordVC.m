//
//  EAAddRecordVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAddRecordVC.h"
#import "EAInputView.h"
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>
#import "NSString+ValidateFormat.h"

@interface EAAddRecordVC () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation EAAddRecordVC {
    EAAddRecordType _type;
    NSArray *_contentDatas;
    
    UIScrollView *_contentView;
    UIButton *_submitBtn;
    EAInputView *_chooseInputView;
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
                                           title:@"记录对象"
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
        EAInputChooseBlock shuzhiTimeBlock = ^ (EAInputView *view) {
            strongify(self);
            self->_chooseInputView = view;
        };
        EAInputChooseBlock dianweiBlock = ^ (EAInputView *view) {
            strongify(self);
            self->_chooseInputView = view;
        };
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
                              [self itemWithType:EAInputTypeChoose
                                           title:@"点位数值时间"
                                     placeholder:@"请选择"
                                     chooseBlock:shuzhiTimeBlock],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"点位代表时间"
                                     placeholder:@"请选择"
                                     chooseBlock:dianweiBlock],
                              [self itemWithType:EAInputTypeMultiLinesInput
                                           title:@"记录对象"
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
        EAInputChooseBlock guanxiBlock = ^ (EAInputView *view) {
            strongify(self);
            self->_chooseInputView = view;
        };
        EAInputChooseBlock qishiBlock = ^ (EAInputView *view) {
            strongify(self);
            self->_chooseInputView = view;
        };
        EAInputChooseBlock jieshuBlock = ^ (EAInputView *view) {
            strongify(self);
            self->_chooseInputView = view;
        };
        _contentDatas = @[
                          @[
                              [self itemWithType:EAInputTypeChoose
                                           title:@"关系类型"
                                     placeholder:@"请选择关系类型（必填）"
                                     chooseBlock:guanxiBlock],
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
    for (int i = 0; i < _contentDatas.count; ++i) {
        NSArray *itemGroup = _contentDatas[i];
        for (int j = 0; j < itemGroup.count; ++j) {
            NSDictionary *itemDic = itemGroup[j];
            EAInputType type = [itemDic[@"type"] intValue];
            NSString *title = itemDic[@"title"];
            NSString *placeholder = itemDic[@"placeholder"];
            float height = EAInputTypeMultiLinesInput == type ? 85 : 45;
            CGRect frame = CGRectMake(0, top, _contentView.width, height);
            EAInputView *inputView = [[EAInputView alloc] initWithFrame:frame
                                                                   type:type
                                                                  title:title
                                                            placeHolder:placeholder];
            inputView.chooseBlock = itemDic[@"chooseBlock"];
            [_contentView addSubview:inputView];
            if (j == 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentView.width, LINE_HEIGHT)];
                line.backgroundColor = LINE_COLOR;
                [inputView addSubview:line];
            }
            
            top = inputView.bottom;
        }
        top += 10;
    }
    _contentView.contentSize = CGSizeMake(_contentView.width, MAX(_contentView.height, top));
}

#pragma mark - Choose Actions
- (void)chooseContanct {
    ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
    nav.peoplePickerDelegate = self;
    nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)chooseTime {
    
}

#pragma mark - Contact
//取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    if ([phoneNO hasPrefix:@"+"]) {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (phone && [phoneNO isValidatePhoneNum]) {
        NSString *firstName = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty)) ?: @"";
        NSString *lastName = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty)) ?: @"";
        NSString *name = [lastName stringByAppendingString:firstName];
        _chooseInputView.inputText = name;
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    } else {
        // TODO
    }
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person {
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}

#pragma mark - submit
- (void)submit {
    
}

@end
