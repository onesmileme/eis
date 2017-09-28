//
//  EADingYueGridView.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EADingYueGridView : UIView

@property (nonatomic, assign) BOOL subscribed;
@property (nonatomic, copy) void (^subscribeBlock)(EADingYueGridView *view);
@property (nonatomic, copy) void (^itemPressedBlock)(EADingYueGridView *view, NSUInteger index, NSDictionary *data);

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items;

@end
