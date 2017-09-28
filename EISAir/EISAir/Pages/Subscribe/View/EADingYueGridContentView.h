//
//  EADingYueGridContentView.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EADingYueGridContentView : UIScrollView

@property (nonatomic, copy) void (^subscribeBlock)(EADingYueGridContentView *view, NSDictionary *data);
@property (nonatomic, copy) void (^itemPressedBlock)(EADingYueGridContentView *view, NSUInteger section, NSUInteger row);
- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas;

@end
