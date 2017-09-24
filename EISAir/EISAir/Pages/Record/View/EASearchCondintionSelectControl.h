//
//  EASearchCondintionSelectControl.h
//  EISAir
//
//  Created by DoubleHH on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EASearchCondintionSelectControl : UIControl

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title itemArray:(NSArray *)itemArray;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;
- (void)reset;

@end
