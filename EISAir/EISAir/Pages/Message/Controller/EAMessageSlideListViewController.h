//
//  EAMessageSlideListViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"
#import "TKSwitchSlidePageItemViewControllerProtocol.h"

@class EAMessageDataListModel;
@interface EAMessageSlideListViewController : EABaseViewController<TKSwitchSlidePageItemViewControllerProtocol>

@property(nonatomic , strong) void (^showMessageBlock)(EAMessageDataListModel * model);

-(void)updateCustomConfig:(NSDictionary *)dict;

-(void)updateWithType:(NSArray *)types reload:(BOOL)reload;


@end
