//
//  EAFilterView.h
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAFilterView : UIControl

@property(nonatomic , copy) void (^confirmBlock)(NSString *item , NSDate *startDate , NSDate *endDate);
@property(nonatomic , copy) void (^tapHeadBlock)(EAFilterView *filterView ,NSInteger index);
@property(nonatomic , copy) NSString *type;

-(void)updateWithTags:(NSArray *)tags hasDate:(BOOL)showDate showIndicator:(BOOL)showIndicator;

-(void)showInView:(UIView *)view ;
-(void)hide;

@end
