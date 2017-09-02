//
//  DDPageScrollView.h
//
//  Created by Pan,Dedong on 14-5-25.
//

//  This code is distributed under the terms and conditions of the MIT license.

//  Copyright (c) 2014 Pan,Dedong
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

@class DDPageScrollView;
@class DDPageScrollViewCell;
@class WMPageControl;

@protocol DDPageScrollViewDelegate <NSObject>

@optional

- (void)pageScrollView:(DDPageScrollView *)pageScrollView didEndDeceleratingAtIndex:(NSUInteger)index;

- (void)pageScrollView:(DDPageScrollView *)pageScrollView didSelectPageAtIndex:(NSUInteger)index;

@end


@protocol DDPageScrollViewDataSource <NSObject>

@required

- (NSUInteger)numberOfCellsInPageScrollView:(DDPageScrollView *)pageScrollView;

- (DDPageScrollViewCell *)pageScrollView:(DDPageScrollView *)pageScrollView cellForIndex:(NSUInteger)index;

@optional

- (NSTimeInterval)timeIntervalOfAutoScrollForPageScrollView:(DDPageScrollView *)pageScrollView;

@end

@interface DDPageScrollViewCell : UIView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@interface DDPageScrollView : UIView

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic, readonly, strong) UIScrollView *scrollView;
@property (strong ,nonatomic) NSMutableArray *visibleCells;
@property (weak, nonatomic) id <DDPageScrollViewDataSource> dataSource;
@property (weak, nonatomic) id <DDPageScrollViewDelegate>   delegate;
@property (assign, nonatomic) BOOL cycleScrollEnabled; //default NO;
@property (strong, readonly, nonatomic) WMPageControl *pageControl; //default hidden is yes
@property (assign, readonly, nonatomic) BOOL isManualDragged;
@property (assign, readonly, nonatomic) CGPoint velocity;

- (void)reloadData;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (void)selectCellAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
