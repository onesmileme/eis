//
//  EASlideCollectionViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKSwitchSlideItemCollectionViewCell.h"

@interface EASlideCollectionViewCell : TKSwitchSlideItemCollectionViewCell

@property(nonatomic ,strong,readonly) UIView *bottomBar;

-(void)customItem;

@end
