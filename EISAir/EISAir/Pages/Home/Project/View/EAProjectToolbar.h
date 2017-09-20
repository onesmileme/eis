//
//  EAProjectToolbar.h
//  EISAir
//
//  Created by chunhui on 2017/9/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAProjectToolbar : UIView

@property(nonnull , copy) void (^preBlock)();
@property(nonnull , copy) void (^nextBlock)();
@property(nonnull , copy) void (^doneBlock)();

@end
