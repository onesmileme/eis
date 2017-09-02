//
//  WMPageControl.m
//  WaiMai
//
//  Created by leigang on 16/4/26.
//  Copyright © 2016年 Baidu. All rights reserved.
//
/////////////////////////////////////////////////////////////////

#import "WMPageControl.h"

@implementation WMPageControl

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}

- (void)updateDots
{
    [self.subviews enumerateObjectsWithOptions:NSEnumerationConcurrent
                                    usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         obj.frame = CGRectMake(obj.origin.x, obj.origin.y, 6 , 6);
         obj.layer.cornerRadius = 3;
     }];
}

@end
