//
//  UIColor+Theme.m
//  FunApp
//
//  Created by chunhui on 16/6/23.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+(UIColor *)themeRedColor
{
    return HexColor(0xe84c3d);
}

+(UIColor *)themeBlackColor
{
    return HexColor(0x111111);
}

+(UIColor *)themeMiddleBlackColor
{
    return HexColor(0x666666);
}

+(UIColor *)themeLightBlackColor
{
    return HexColor(0x333333);
}

+(UIColor *)themeLightGray3Color
{
    return HexColor(0x999999);
}

+(UIColor *)themeGrayColor
{
    return HexColor(0xf7f7f7);
}

+(UIColor *)themeLightGrayColor
{
    return HexColor(0xf9f9f9);
}

+(UIColor *)themeLightGray1Color
{
    return HexColor(0xaaaaaa);
}

+(UIColor *)themeLightGray2Color
{
    return HexColor(0xebebeb);
}

+(UIColor *)themeOrangeColor
{
    return HexColor(0xfc461e);
}

+(UIColor *)themeBackgroundColor
{
    return [UIColor clearColor];
}

@end
