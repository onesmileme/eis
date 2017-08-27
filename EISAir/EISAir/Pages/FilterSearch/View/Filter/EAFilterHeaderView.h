//
//  EAFilterHeaderView.h
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAFilterHeaderView : UICollectionReusableView

@property(nonatomic , copy) void (^tapBlock)(EAFilterHeaderView *header);

-(void)updateTitle:(NSString *)title showTopLine:(BOOL)showTopline showIndicator:(BOOL)showIndicator;


@end
