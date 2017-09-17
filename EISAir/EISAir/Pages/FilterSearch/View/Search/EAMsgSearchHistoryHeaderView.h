//
//  EAMsgSearchHistoryHeaderView.h
//  EISAir
//
//  Created by chunhui on 2017/9/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAMsgSearchHistoryHeaderView : UICollectionReusableView

@property(nonatomic , strong) UILabel *tipLabel;
@property(nonatomic , strong) UIButton *removeButton;
@property(nonatomic , copy)   void (^removeBlock)();

@end
