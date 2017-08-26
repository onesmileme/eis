//
//  EAMsgDetailHeader.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgDetailHeader.h"

@implementation EAMsgDetailHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.font = SYS_FONT(13);
        _infoLabel.textColor = HexColor(0x858585);
        _infoLabel.text = @"消息动态";
        
        [_infoLabel sizeToFit];
        _infoLabel.left = 15;
        _infoLabel.bottom = self.height;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _infoLabel.bottom = self.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
