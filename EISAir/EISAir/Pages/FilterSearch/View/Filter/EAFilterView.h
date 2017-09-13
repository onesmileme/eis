//
//  EAFilterView.h
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAFilterView : UIView

@property(nonatomic , copy) void (^confirmBlock)();
@property(nonatomic , copy) void (^tapHeadBlock)(EAFilterView *filterView ,NSInteger section);
@property(nonatomic , copy) NSString *type;

-(void)updateWithTags:(NSArray *)tags hasDate:(BOOL)showDate;

-(void)showInView:(UIView *)view ;
-(void)hide;

@end
