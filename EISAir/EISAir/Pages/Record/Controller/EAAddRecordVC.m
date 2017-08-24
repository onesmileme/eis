//
//  EAAddRecordVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAddRecordVC.h"
#import "EAInputView.h"

@interface EAAddRecordVC ()

@end

@implementation EAAddRecordVC {
    EAAddRecordType _type;
    NSArray *_contentDatas;
    
    UIScrollView *_contentView;
    UIButton *_submitBtn;
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
    if (EAAddRecordTypeText == _type) {
        _contentDatas = @[
                          @[
                              [self itemWithType:EAInputTypeOneLineInput
                                           title:@"记录名称"
                                     placeholder:@"请输入记录名称（必填）"],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"记录对象"
                                     placeholder:@"请选择（必填）"],
                              [self itemWithType:EAInputTypeMultiLinesInput
                                           title:@"记录对象"
                                     placeholder:@"请输入记录内容（必填3-50字内）"],
                              ],
                          @[
                              [self itemWithType:EAInputTypeChoose
                                           title:@"请选择@"
                                     placeholder:@"请选择"],
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
                                     placeholder:@"请选择（必填）"],
                              [self itemWithType:EAInputTypeOneLineInput
                                           title:@"记录值"
                                     placeholder:@"请输入记录值"],
                              ],
                          @[
                              [self itemWithType:EAInputTypeChoose
                                           title:@"点位数值时间"
                                     placeholder:@"请选择"],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"点位代表时间"
                                     placeholder:@"请选择"],
                              [self itemWithType:EAInputTypeMultiLinesInput
                                           title:@"记录对象"
                                     placeholder:@"请输入记录内容（必填3-50字内）"],
                              ],
                          @[
                              [self itemWithType:EAInputTypeChoose
                                           title:@"请选择@"
                                     placeholder:@"请选择"],
                              ],
                          ];
    }
    else {
        _contentDatas = @[
                          @[
                              [self itemWithType:EAInputTypeChoose
                                           title:@"关系类型"
                                     placeholder:@"请选择关系类型（必填）"],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"起始对象"
                                     placeholder:@"请选择起始对象（必填）"],
                              [self itemWithType:EAInputTypeChoose
                                           title:@"结束对象"
                                     placeholder:@"请选择结束对象（必填）"],
                              ],
                          ];
    }
}

- (NSDictionary *)itemWithType:(EAInputType)type
                         title:(NSString *)title
                   placeholder:(NSString *)placeHolder {
    return @{
             @"type": @(type),
             @"title": title ?: @"",
             @"placeholder": placeHolder ?: @"",
             };
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

#pragma mark - submit
- (void)submit {
    
}

@end
