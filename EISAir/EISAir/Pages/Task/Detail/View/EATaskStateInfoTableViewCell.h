//
//  EATaskInfoTableViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 任务详情 任务介绍
 */
@interface EATaskStateInfoTableViewCell : UITableViewCell

+(CGFloat)heightForModel:(id)model;
-(void)updteWithModel:(id)model;

@end