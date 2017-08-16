//
//  UIBarButtonItem+Navigation.h
//  CaiLianShe
//
//  Created by chunhui on 15/12/9.
//  Copyright © 2015年 chenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Navigation)

+(UIBarButtonItem *)defaultLeftItemWithTarget:(id)target action:(SEL)action;

+(UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action Image:(UIImage*)image;

@end
