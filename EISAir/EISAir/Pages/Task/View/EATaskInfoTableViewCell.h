//
//  EATaskInfoTableViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EATaskDataListModel;
@interface EATaskInfoTableViewCell : UITableViewCell

+(CGFloat)heightForModel:(EATaskDataListModel *)model;

-(void)updateWithModel:(EATaskDataListModel *)model;

@end
