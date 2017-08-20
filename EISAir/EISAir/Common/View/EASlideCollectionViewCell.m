//
//  EASlideCollectionViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASlideCollectionViewCell.h"

#define kSelectedColor HexColor(0x058497)
#define kUnSelectedColor HexColor(0x5F646E)

@interface EASlideCollectionViewCell ()

@property(nonatomic ,strong) UIView *bottomBar;

@end

@implementation EASlideCollectionViewCell

+(CGFloat)cellWidthForTitle:(NSString *)title
{
//    CGSize size = [title sizeWithMaxWidth:100 font:kUnSelectedFont];
//    
//    FASlideConfigDataModel *model = [[FASlideConfigManager sharedInstance] slideConfigModel];
//    NSInteger itemWidth = 0;
//    if (model.categoryList.count > 0) {
//        itemWidth = (SCREEN_WIDTH / [model.categoryList count]);
//    }
//    
//    return  MAX(size.width + 30, itemWidth) ;
    
    return 100;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        
        [self customItem];
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        
        [self customItem];
    }
    return self;
}

-(void)customItem
{
    self.titleLabel.font = SYS_FONT(15);
    self.titleLabel.textColor = kUnSelectedColor;
    self.titleLabel.highlightedTextColor = kSelectedColor;
    
    _bottomBar = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, self.width, 2)];
    _bottomBar.backgroundColor = kSelectedColor;
    _bottomBar.hidden = true;
    
    [self addSubview:_bottomBar];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.titleLabel.highlighted = selected;
    self.bottomBar.hidden = !selected;
    if (selected) {
        self.titleLabel.textColor = kSelectedColor;
    } else {
        self.titleLabel.textColor = kUnSelectedColor;
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
