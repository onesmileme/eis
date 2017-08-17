//
//  EASharePanelView.h
//  FunApp
//
//  Created by liuzhao on 2016/12/1.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EASharePanelView : UIView

@property (nonatomic, copy) void(^chooseItem)(NSInteger index);
@property (nonatomic, copy) void(^dismiss)();

- (void)updateWithTitles:(NSArray *)titles images:(NSArray *)images;

@end
