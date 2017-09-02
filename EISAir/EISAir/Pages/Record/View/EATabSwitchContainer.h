//
//  EATabSwitchContainer.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/1.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EATabSwitchContainer;
@protocol EATabSwitchContainerProtocol <NSObject>

// data source
- (NSArray<NSString *> *)tabSwitchContainerHeaderTitles:(EATabSwitchContainer *)container;
- (NSDictionary *)tabSwitchContainerHeaderConfig:(EATabSwitchContainer *)container;
- (UIView *)tabSwitchContainer:(EATabSwitchContainer *)container viewForIndex:(NSUInteger)index;

// actions
- (void)tabSwitchContainer:(EATabSwitchContainer *)container selectedIndex:(NSUInteger)index;

@end

@interface EATabSwitchContainer : UIView

@property (nonatomic, weak) id<EATabSwitchContainerProtocol> delegate;

@end
