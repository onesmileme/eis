//
//  EAMsgSearchFilterHeaderView.h
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAMsgSearchFilterHeaderView : UIView

@property(nonatomic , copy) void (^checkBlock)(BOOL checked);

@end
