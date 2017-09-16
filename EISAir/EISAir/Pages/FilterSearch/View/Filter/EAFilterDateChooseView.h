//
//  EAFilterDateChooseView.h
//  EISAir
//
//  Created by chunhui on 2017/9/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAFilterDateChooseView : UIView

@property(nonatomic , strong) UITextField *startDateField;
@property(nonatomic , strong) UITextField *toDateField;

@property(nonatomic , strong) NSDate *startDate;
@property(nonatomic , strong) NSDate *toDate ;

-(void)clearDate;

@end
