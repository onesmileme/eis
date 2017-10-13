//
//  EASheBeiContainView.h
//  EISAir
//
//  Created by DoubleHH on 2017/10/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EASheBeiContainView : UIView

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items;
@property (nonatomic, copy) void (^clickedBlock)(NSDictionary *dic);

@end
