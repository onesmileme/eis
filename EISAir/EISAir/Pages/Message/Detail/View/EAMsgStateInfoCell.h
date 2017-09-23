//
//  EAMsgStateInfoCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EATaskStatusDataModel;
@interface EAMsgStateInfoCell : UITableViewCell

-(void)updateWithModel:(EATaskStatusDataModel *)model isFirst:(BOOL)isFirst;

@end
