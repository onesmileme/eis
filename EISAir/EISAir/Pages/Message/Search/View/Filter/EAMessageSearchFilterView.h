//
//  EAMessageSearchFilterView.h
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAMessageSearchFilterView : UIView

@property(nonatomic , assign , readonly) BOOL checkAll;
@property(nonatomic , strong , readonly) NSArray *choosedItems;
@property(nonatomic , copy) void (^confirmBlock)(EAMessageSearchFilterView *filterView);

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ;

@end
