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
    EAInputTypeDate,    // time
    EAInputTypePicker,  // picker 模式下需要pickerContents
    EAInputTypeChoose,
} EAInputType;

@class EAInputView;
typedef void(^EAInputChooseBlock)(EAInputView *view);

@interface EAInputView : UIView

@property (nonatomic, copy) NSString *inputText;
@property (nonatomic, copy) EAInputChooseBlock chooseBlock;
@property (nonatomic, copy) NSDate *selectedDate;
@property (nonatomic, assign) NSInteger pickerIndex;

- (instancetype)initWithFrame:(CGRect)frame
                         type:(EAInputType)type
                        title:(NSString *)title
                  placeHolder:(NSString *)placeHolder;

- (instancetype)initWithFrame:(CGRect)frame
                         type:(EAInputType)type
                        title:(NSString *)title
                  placeHolder:(NSString *)placeHolder
               pickerContents:(NSArray *)pickerContents;

- (void)setInputKeyboardType:(UIKeyboardType)inputKeyboardType;

@end
