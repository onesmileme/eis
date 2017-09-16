//
//  EASubscribeHeaderView.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EASubscribeHeaderView : UIView

- (instancetype)initWithIcon:(NSString *)icon
              subscribeCount:(NSUInteger)subscribeCount
                  subscribed:(BOOL)subscribed;

@property (nonatomic, copy) void (^subscriberClickBlock)(void);
@property (nonatomic, copy) void (^subscribeClickBlock)(void);

@end
