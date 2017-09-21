//
//  EAReportFilterContentView.h
//  EISAir
//
//  Created by iwm on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAReportFilterContentView : UIView

@property (nonatomic, assign, readonly) NSInteger selectedIndex;
@property (nonatomic, copy) void (^itemClickedBlock)(void);
@property (nonatomic, copy) void (^bgClickedBlock)(void);

- (instancetype)initWithData:(NSArray *)data
               selectedIndex:(NSInteger)selectedIndex;

@end
