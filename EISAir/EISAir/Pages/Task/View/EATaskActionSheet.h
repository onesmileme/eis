//
//  EATaskActionSheet.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EATaskActionSheet : UIView

@property(nonatomic , copy) void (^confirmBlock)();
@property(nonatomic , copy) void (^cancelBlock)();

-(void)show;

-(void)hide;

@end
