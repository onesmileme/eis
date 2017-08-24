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

@interface EAInputView : UIView

@property (nonatomic, copy) NSString *inputText;
@property (nonatomic, copy) void (^chooseBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame
                         type:(EAInputType)type
                        title:(NSString *)title
                  placeHolder:(NSString *)placeHolder;

- (void)setInputKeyboardType:(UIKeyboardType)inputKeyboardType;

@end
