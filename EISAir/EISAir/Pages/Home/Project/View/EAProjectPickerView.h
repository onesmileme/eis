//
//  EAProjectPickerView.h
//  EISAir
//
//  Created by chunhui on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAProjectPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic , strong) UIPickerView *picker;
@property(nonatomic , strong) NSArray *items;

@property(nonatomic , copy) void (^chooseBlock)(NSInteger index);

-(void)show;
-(void)hide;

@end
