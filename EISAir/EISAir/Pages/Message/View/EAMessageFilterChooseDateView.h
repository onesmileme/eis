//
//  EAMessageFilterChooseDateView.h
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAMessageFilterChooseDateView : UIView

@property(nonatomic , strong) UITextField *fromDateField;
@property(nonatomic , strong) UITextField *toDateField;
@property(nonatomic , strong) NSDate *fromDate;
@property(nonatomic , strong) NSDate *toDate;

@end
