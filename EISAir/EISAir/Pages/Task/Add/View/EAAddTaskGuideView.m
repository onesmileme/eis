//
//  EAAddTaskGuideView.m
//  EISAir
//
//  Created by chunhui on 2017/9/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAddTaskGuideView.h"

@implementation EAAddTaskGuideView


+(instancetype)view
{
    UINib *nib = [UINib nibWithNibName:@"EAAddTaskGuideView" bundle:nil];
    EAAddTaskGuideView *v = (EAAddTaskGuideView *)[[nib instantiateWithOwner:self options:nib] firstObject];
    return v;
}

-(IBAction)confirmAction:(id)sender
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
