//
//  EASheBeiHeader.m
//  EISAir
//
//  Created by iwm on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASheBeiHeader.h"

@implementation EASheBeiHeader {
    UILabel *_yearLabel;
    UILabel *_count1Label;
    UILabel *_count2Label;
    
    NSArray *_danweis;
    NSArray *_values;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgImageView.image = [UIImage imageNamed:@"dingyue_bg_s"];
        bgImageView.frame = self.bounds;
        [self addSubview:bgImageView];
        [self insertSubview:bgImageView atIndex:0];
        
        NSArray *array = @[@"已运行年份", @"开启次数", @"报警次数"];
        for (int i = 0; i < array.count; ++i) {
            UILabel *label1 = TKTemplateLabel2([UIFont systemFontOfSize:12], [UIColor whiteColor], array[i]);
            label1.top = 25;
            label1.centerX = self.width * (i + 1) / 4;
            [self addSubview:label1];
        }
        
        NSMutableArray *danweis = [NSMutableArray array];
        NSMutableArray *values = [NSMutableArray array];
        NSArray *danweiTitles = @[@"年", @"次", @"次",];
        for (int i = 0; i < danweiTitles.count; ++i) {
            UILabel *label1 = TKTemplateLabel2([UIFont systemFontOfSize:13], [UIColor whiteColor], danweiTitles[i]);
            label1.top = 60;
            label1.centerX = self.width * (i + 1) / 4;
            [self addSubview:label1];
            [danweis addObject:label1];
            
            UILabel *label2 = TKTemplateLabel2([UIFont systemFontOfSize:30], [UIColor whiteColor], @" ");
            label2.centerY = label1.centerY - 3;
            [self addSubview:label2];
            [values addObject:label2];
        }
        _danweis = danweis;
        _values = values;
        
        [self updateValuesFrame];
    }
    return self;
}

- (void)updateModel:(NSArray *)values {
    for (int i = 0; i < _values.count; ++i) {
        UILabel *valueLabel = _values[i];
        valueLabel.text = values[i];
        [valueLabel sizeToFit];
    }
    [self updateValuesFrame];
}

- (void)updateValuesFrame {
    for (int i = 0; i < _values.count; ++i) {
        UILabel *valueLabel = _values[i];
        UILabel *danweiLabel = _danweis[i];
        float width = valueLabel.width + danweiLabel.width + 3;
        float left = self.width * (i + 1) / 4 - width * .5;
        valueLabel.left = left;
        danweiLabel.left = valueLabel.right + 3;
    }
}

@end
