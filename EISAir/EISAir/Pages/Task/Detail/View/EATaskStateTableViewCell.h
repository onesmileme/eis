//
//  EATaskStateTableViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 任务详情 任务状态
 */
@class EATaskStatusDataModel;
@interface EATaskStateTableViewCell : UITableViewCell

-(void)updateWithModel:(EATaskStatusDataModel *)model isStart:(BOOL)isStart isLast:(BOOL)isLast;

@end
