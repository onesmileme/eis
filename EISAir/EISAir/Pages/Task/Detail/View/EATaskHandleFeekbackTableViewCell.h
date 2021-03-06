//
//  EATaskHandleFeekbackTableViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EATaskDataListModel;
@interface EATaskHandleFeekbackTableViewCell : UITableViewCell

@property(nonatomic , copy) void (^showFeedBack)();
@property(nonatomic , copy) void (^showContent)();

-(void)updateWithModel:(EATaskDataListModel *)model;

@end
