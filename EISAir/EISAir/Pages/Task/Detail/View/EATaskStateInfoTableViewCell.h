//
//  EATaskInfoTableViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EATaskStateInfoTableViewCell : UITableViewCell

+(CGFloat)heightForModel:(id)model;
-(void)updteWithModel:(id)model;

@end
