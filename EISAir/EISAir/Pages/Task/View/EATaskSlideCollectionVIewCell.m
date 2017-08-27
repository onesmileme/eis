//
//  EATaskSlideCollectionVIewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskSlideCollectionVIewCell.h"

@implementation EATaskSlideCollectionVIewCell

+(CGFloat)cellWidthForTitle:(NSString *)title
{
    return SCREEN_WIDTH/2;
}

-(void)customItem
{
    [super customItem];
    
    self.bottomBar.width = self.width*0.7;
    self.bottomBar.centerX = self.width/2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
