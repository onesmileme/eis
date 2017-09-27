//
//  EAPageVCHandler.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EAPageVCHandler;
@protocol EAPageVCHandlerDelegate <NSObject>
- (UIViewController *)pageHandler:(EAPageVCHandler *)handler viewControllerWithIndex:(NSUInteger)index;
- (void)pageHandler:(EAPageVCHandler *)handler didMoveToIndex:(NSUInteger)index;
@end

@interface EAPageVCHandler : NSObject

@property (nonatomic, weak) id<EAPageVCHandlerDelegate> delegate;
@property (nonatomic, strong, readonly) UIPageViewController *pageVC;

- (void)moveToIndex:(NSUInteger)index animated:(BOOL)animated;

@end
