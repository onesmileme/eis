//
//  EASubscribeCell.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/2.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseTableViewCell.h"

@interface EASubscribeCell : EABaseTableViewCell

@property (nonatomic, copy) void (^subscribeClickBlock)(void);

@end
