//
//  EAUserSearchHeader.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAUserSearchHeader.h"

@implementation EAUserSearchHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _searchBar = [[UISearchBar alloc]initWithFrame:self.bounds];
        _searchBar = [[UITextField alloc]initWithFrame:self.bounds];
        _searchBar.borderStyle = UITextBorderStyleNone;
        
        UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 49, self.height)];
        leftImgView.contentMode = UIViewContentModeCenter;        
        leftImgView.image = SYS_IMG(@"seach_icon1");
        _searchBar.leftView = leftImgView;
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        
        leftImgView.backgroundColor = [UIColor orangeColor];
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        rightView.backgroundColor = [UIColor clearColor];
        _searchBar.rightView = rightView;
        
        _searchBar.font = SYS_FONT(12);
        
        _searchBar.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索" attributes:@{NSFontAttributeName:SYS_FONT(12),NSForegroundColorAttributeName:HexColor(0xbebebe)}];
        
        [self addSubview:_searchBar];
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
