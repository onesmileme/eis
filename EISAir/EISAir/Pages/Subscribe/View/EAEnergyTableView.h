//
//  EAEnergyTableView.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAEnergyTableView : UITableView

@property (nonatomic, copy) void (^clickBlock)(NSInteger index);
- (void)updateData:(NSArray *)data;

@end
