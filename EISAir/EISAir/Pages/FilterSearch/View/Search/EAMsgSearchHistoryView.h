//
//  EAMsgSearchHistoryView.h
//  EISAir
//
//  Created by chunhui on 2017/9/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAMsgSearchHistoryView : UIView

@property(nonatomic , copy) void(^clearBlock)();
@property(nonatomic , copy) void(^chooseBlock)(NSString *key);
-(void)updateWithKeys:(NSArray *)keys;

@end
