//
//  EAMessageNoDataView.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageNoDataView.h"

@implementation EAMessageNoDataView

+(instancetype)view
{
    UINib *nib = [UINib nibWithNibName:@"EAMessageNoDataView" bundle:nil];
    EAMessageNoDataView *v = [[nib instantiateWithOwner:self options:nil] firstObject];
    
    return v;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addGesture];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self addGesture];
    
}

-(void)setIsTask:(BOOL)isTask
{
    _isTask = isTask;
    NSString *imgName = nil;
    NSString *tip = nil;
    if (_isTask) {
        imgName = @"no_task";
        tip = @"暂时没有相关任务";
    }else{
        imgName = @"no_message";
        tip = @"暂时没有相关消息";
    }
    self.tipImageView.image = SYS_IMG(imgName);
    self.tipLabel.text = tip;
    
}

-(void)addGesture
{
    if (self.tipImageView.gestureRecognizers.count == 0) {
        self.tipImageView.userInteractionEnabled = true;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGesture:)];
        [self.tipImageView addGestureRecognizer:gesture];
    }
}

-(void)onTapGesture:(UITapGestureRecognizer *)gesture
{
    if (_tapBlock) {
        _tapBlock();
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
