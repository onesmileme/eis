//
//  EATaskProcessStateView.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EATaskHelper.h"

//typedef NS_ENUM(NSInteger, EATaskProcessState){
//    EATaskProcessStateBegin = 0 ,
//    EATaskProcessStateWating ,
//    EATaskProcessStateDoing ,
//    EATaskProcessStateDone ,
//    EATaskProcessStateInvalid ,
//};

@interface EATaskProcessStateView : UIView

@property(nonatomic , assign) IBInspectable EATaskStatus state;

@end
