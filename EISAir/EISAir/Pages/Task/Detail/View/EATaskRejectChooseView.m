//
//  EATaskRejectChooseView.m
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskRejectChooseView.h"

@interface EATaskRejectChooseView ()

@property(nonatomic , strong) IBOutlet NSLayoutConstraint *bottomConstraint;
@property(nonatomic , strong) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation EATaskRejectChooseView

+(instancetype)view
{
    UINib *nib = [UINib nibWithNibName:@"EATaskRejectChooseView" bundle:nil];
    NSArray *views = [nib instantiateWithOwner:self options:nil];
    return [views firstObject];
}

-(void)showInView:(UIView *)view
{
    
    self.bottomConstraint.constant = self.heightConstraint.constant;
    self.frame = view.bounds;
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomConstraint.constant = 0;
    }];
}

-(void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomConstraint.constant = self.heightConstraint.constant;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(IBAction)confirmAction:(id)sender
{
    if (_actionBlock) {
        _actionBlock(true);
        [self hide];
    }
}

-(IBAction)cancelAction:(id)sender
{
    if (_actionBlock) {
        _actionBlock(false);
        [self hide];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
