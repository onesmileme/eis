//
//  EAProjectToolbar.h
//  EISAir
//
//  Created by chunhui on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAProjectToolbar : UIView

@property(nonnull , copy) void (^upBlock)();
@property(nonnull , copy) void (^downBlock)();
@property(nonnull , copy) void (^doneBlock)();

@end
