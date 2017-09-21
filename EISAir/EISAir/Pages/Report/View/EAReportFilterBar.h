//
//  EAReportFilterBar.h
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAReportFilterBar : UIView

@property (nonatomic, copy) void (^clickedBlock)(NSInteger index);
- (void)setModel:(NSArray *)model;
- (void)selectedNone;

@end
