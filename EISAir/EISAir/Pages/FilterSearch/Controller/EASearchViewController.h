//
//  EASearchViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

@class EAMsgSearchTipDataModel;
@interface EASearchViewController : EABaseViewController

@property(nonatomic , copy) void (^chooseItemsBlock)(NSArray<EAMsgSearchTipDataModel *> *items);

@end
