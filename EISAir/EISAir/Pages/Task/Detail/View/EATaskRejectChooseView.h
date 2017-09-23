//
//  EATaskRejectChooseView.h
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EATaskRejectChooseView : UIView

@property(nonatomic , copy) void (^actionBlock)(BOOL confirm);

+(instancetype)view;

-(void)showInView:(UIView *)view;
-(void)hide;

@end
