//
//  CSBrowserTranistion.h
//  CaiLianShe
//
//  Created by chunhui on 2016/8/2.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EABrowserTranistion : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL reverse;
@property (nonatomic , assign) CGFloat duration;
@property (nonatomic , weak) UIViewController *browserViewController;

@end
