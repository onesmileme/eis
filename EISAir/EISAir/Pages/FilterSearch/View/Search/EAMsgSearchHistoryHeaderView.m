//
//  EAMsgSearchHistoryHeaderView.m
//  EISAir
//
//  Created by chunhui on 2017/9/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgSearchHistoryHeaderView.h"

@implementation EAMsgSearchHistoryHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.textColor = HexColor(0x666666);
        _tipLabel.text = @"搜索历史";
        _tipLabel.font = SYS_FONT(14);
        [_tipLabel sizeToFit];
        
        _removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeButton addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *img = SYS_IMG(@"search_remove");
        [_removeButton setBackgroundImage:img forState:UIControlStateNormal];
        _removeButton.frame = CGRectMake(0, 0, 11, 11);
        
        [self addSubview:_tipLabel];
        [self addSubview:_removeButton];
        
    }
    return self;
}

-(void)removeAction:(id)sender
{
    if (_removeBlock) {
        self.removeBlock();
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _tipLabel.left = 16;
    _tipLabel.centerY = self.height/2;
    
    _removeButton.centerY = self.height/2;
    _removeButton.right = self.width - 16;
    
}

@end
