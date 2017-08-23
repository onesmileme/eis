//
//  EAAddRecordVC.m
//  EISAir
//
//  Created by DoubleHH on 2017/8/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAddRecordVC.h"

@interface EAAddRecordVC ()

@end

@implementation EAAddRecordVC {
    EAAddRecordType _type;
    
    UIScrollView *_contentView;
    UIButton *_submitBtn;
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
    [self.view addSubview:_contentView];
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
    
}

#pragma mark - submit
- (void)submit {
    
}

@end
