//
//  EALoginCountdownView.h
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EALoginCountdownView : UIView

@property(nonatomic , copy) void (^countdownBlock)();

-(void)startCount;

-(void)stop;

@end
