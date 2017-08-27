//
//  EATaskProcessStateView.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EATaskProcessState){
    EATaskProcessStateBegin = 0 ,
    EATaskProcessStateWating = 1,
    EATaskProcessStateDoing = 2,
    EATaskProcessStateDone = 3
};

@interface EATaskProcessStateView : UIView

@property(nonatomic , assign) IBInspectable EATaskProcessState state;

@end
