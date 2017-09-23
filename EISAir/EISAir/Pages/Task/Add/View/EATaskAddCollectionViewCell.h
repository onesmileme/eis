//
//  EATaskAddCollectionViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EATaskItemDataModel;
@interface EATaskAddCollectionViewCell : UICollectionViewCell

-(void)updateWithModel:(EATaskItemDataModel *)model;

@end
