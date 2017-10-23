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
        
        UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(18, (_searchBar.height - 16)/2, 16, 16)];
        leftImgView.contentMode = UIViewContentModeScaleAspectFit;
        
        leftImgView.image = SYS_IMG(@"search_icon2");
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, CGRectGetHeight(frame))];
        [leftView addSubview:leftImgView];
        _searchBar.leftView = leftView;
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        
        leftImgView.backgroundColor = [UIColor clearColor];
        
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
