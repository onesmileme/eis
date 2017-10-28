//
//  EAMessageTableViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAMessageDataListModel;
@interface EAMessageTableViewCell : UITableViewCell

+(CGFloat)heightForModel:(EAMessageDataListModel *)model;

-(void)updateWithModel:(EAMessageDataListModel *)model;

@end
