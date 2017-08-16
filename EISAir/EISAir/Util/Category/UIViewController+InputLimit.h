//
//  UIViewController+InputLimit.h
//  FunApp
//
//  Created by liuzhao on 2016/12/28.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (InputLimit)

- (NSString *)handleInputLimtWithContent:(NSString *)content limitCount:(NSUInteger)limit toast:(NSString *)toast;

@end
