//
//  EAReportHeader.h
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAReportHeader : UIControl

@property (nonatomic, copy) void (^clickedBlock)(NSUInteger index);
- (void)setModel:(NSArray *)model;

@end