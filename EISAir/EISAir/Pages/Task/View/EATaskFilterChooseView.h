//
//  EATaskFilterChooseView.h
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EATaskFilterChooseView : UIView

@property(nonatomic , copy) void (^chooseBlock)(NSInteger index);

+(instancetype)view;

-(void)show;
-(void)hide;

@end
