//
//  EAShareView.h
//  FunApp
//
//  Created by liuzhao on 2016/12/1.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAShareView : UIView

@property (nonatomic, copy) void(^shareAction)(NSInteger index);

- (instancetype)initWithTitles:(NSMutableArray *)titles images:(NSMutableArray *)images;

- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)dismiss:(BOOL)animated;

@end
