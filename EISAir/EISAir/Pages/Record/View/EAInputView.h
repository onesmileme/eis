//
//  EAInputView.h
//  EISAir
//
//  Created by DoubleHH on 2017/8/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EAInputTypeOneLineInput,
    EAInputTypeMultiLinesInput,
    EAInputTypeChoose,
} EAInputType;

@class EAInputView;
typedef void(^EAInputChooseBlock)(EAInputView *view);

@interface EAInputView : UIView

@property (nonatomic, copy) NSString *inputText;
@property (nonatomic, copy) EAInputChooseBlock chooseBlock;

- (instancetype)initWithFrame:(CGRect)frame
                         type:(EAInputType)type
                        title:(NSString *)title
                  placeHolder:(NSString *)placeHolder;

- (void)setInputKeyboardType:(UIKeyboardType)inputKeyboardType;

@end
