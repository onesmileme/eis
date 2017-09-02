//
//  EABaseTableViewCell.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface EABaseTableViewCell : UITableViewCell

+ (CGFloat)cellHeightWithModel:(id)model;
- (void)setModel:(id)aModel;

@end
