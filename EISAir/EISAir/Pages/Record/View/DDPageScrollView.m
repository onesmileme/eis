//
//  DDPageScrollView.m
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

#import "DDPageScrollView.h"
#import "WMPageControl.h"

@interface DDPageScrollView () <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    NSTimeInterval          _scrollTime;
    
    NSMutableDictionary     *_reusableCellDict;
    NSMutableArray          *_visibleCells;
    
    NSInteger               _totalCount;
}

@property (assign, nonatomic) BOOL timerShouldInvoke;
@property (strong, nonatomic) NSTimer *timer;

- (NSInteger)getDataIndex;

@end

@interface DDPageScrollViewCell ()

@property (strong, nonatomic) NSString *reuseIdentifie;
@property (assign, nonatomic) NSUInteger index;
@property (weak, nonatomic) DDPageScrollView *pageScrollView;

@end


/********************************************************************************/
@implementation DDPageScrollViewCell : UIView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifie {
    if (self = [super init]) {
        self.reuseIdentifie = reuseIdentifie;
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - touchs

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.pageScrollView.timerShouldInvoke = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if ([self.pageScrollView.delegate respondsToSelector:@selector(pageScrollView:didSelectPageAtIndex:)]) {
        [self.pageScrollView.delegate pageScrollView:self.pageScrollView didSelectPageAtIndex:[self.pageScrollView getDataIndex]];
    }
    self.pageScrollView.timerShouldInvoke = YES;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.pageScrollView.timerShouldInvoke = YES;
}

@end
/********************************************************************************/



/********************************************************************************/
@interface DDPageScrollView ()
@property (assign, readwrite, nonatomic) BOOL isManualDragged;
@property (assign, readwrite, nonatomic) CGPoint velocity;
@end

@implementation DDPageScrollView

- (void)dealloc {
    _scrollView.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _scrollTime = 0.0;
    self.backgroundColor = [UIColor clearColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.scrollsToTop = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    _pageControl = [[WMPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
    _pageControl.hidden = YES;
    
    _reusableCellDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    _visibleCells = [[NSMutableArray alloc] initWithCapacity:0];
    
    _timerShouldInvoke = YES;
    self.isManualDragged = NO;
}

#pragma mark - override Method

- (void)layoutSubviews {
    [super layoutSubviews];

    _scrollView.frame = self.bounds;
    CGFloat originalWidth = 0;

    for (DDPageScrollViewCell *cell in _scrollView.subviews) {
        originalWidth = cell.frame.size.width;
        cell.frame = CGRectMake(cell.index * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    }
    
    if (originalWidth == 0 || _scrollView.frame.size.width == 0) return;
    
    _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x / originalWidth * _scrollView.frame.size.width, 0);
    
    if (_cycleScrollEnabled) {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * (_totalCount + 2), _scrollView.frame.size.height);
    }
    else {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _totalCount, _scrollView.frame.size.height);
    }
    
    _pageControl.frame = CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 20);
}

- (void)removeFromSuperview {
    if (self.timer && [self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [super removeFromSuperview];
}

- (void)setCycleScrollEnabled:(BOOL)cycleScrollEnabled {
    if (_cycleScrollEnabled != cycleScrollEnabled) {
        _cycleScrollEnabled = cycleScrollEnabled;
        [self reloadData];
    }
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    
    if (_cycleScrollEnabled) {
        if (contentOffSetX <= 0) {
            _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * _totalCount + contentOffSetX, 0);
            return;
        }
        else if (contentOffSetX >= _scrollView.frame.size.width * (_totalCount + 1)) {
            _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width + (int)contentOffSetX % (int)_scrollView.frame.size.width, 0);
            return;
        }
    }

    NSMutableArray *needReusableCells = [NSMutableArray array];
    for (DDPageScrollViewCell *cell in _visibleCells) {
        if (CGRectGetMaxX(cell.frame) < contentOffSetX ||
            cell.frame.origin.x > contentOffSetX + scrollView.frame.size.width)
        {
            [needReusableCells addObject:cell];
        }
    }
    if (needReusableCells.count > 0) {
        for (DDPageScrollViewCell *cell in needReusableCells) {
            [self reusableCell:cell];
        }
    }
    
    if (_totalCount == 0 || _scrollView.frame.size.width == 0) return;
    
    NSInteger index = (int)contentOffSetX / scrollView.frame.size.width;
    if (index >= 0) {
        if (![self cellForIndex:index]) {
            NSInteger dateIndex = index;
            if (_cycleScrollEnabled) {
                dateIndex = index == 0 ? _totalCount - 1 : (index == _totalCount + 1 ? 0 : index - 1);
            }
            
            DDPageScrollViewCell *cell = [self.dataSource pageScrollView:self cellForIndex:dateIndex];
            [self addCell:cell atIndex:index];
        }
        
        if ((int)_scrollView.contentOffset.x % (int)_scrollView.frame.size.width > 0) {
            NSInteger nextIndex = index + 1;
            if (![self cellForIndex:nextIndex])
            {
                NSInteger nextDataIndex = nextIndex;
                if (_cycleScrollEnabled) {
                    nextDataIndex = nextIndex == 0 ? _totalCount - 1 : (nextIndex == _totalCount + 1 ? 0 : nextIndex - 1);
                }
                
                if (nextDataIndex > _totalCount - 1) {
                    return;
                }
                DDPageScrollViewCell *cell = [self.dataSource pageScrollView:self cellForIndex:nextDataIndex];
                [self addCell:cell atIndex:nextIndex];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageControl.currentPage = [self getDataIndex];
    if ([self.delegate respondsToSelector:@selector(pageScrollView:didEndDeceleratingAtIndex:)]) {
        [self.delegate pageScrollView:self didEndDeceleratingAtIndex:[self getDataIndex]];
    }
    
    _isManualDragged = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.timerShouldInvoke = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.timerShouldInvoke = YES;
    self.isManualDragged = YES;
}

- (void)scrollToNextIndex {
    NSInteger index = (int)_scrollView.contentOffset.x / _scrollView.frame.size.width ;
    NSInteger nextIndex = index + 1;
    if (!_cycleScrollEnabled && index == _totalCount - 1) {
        nextIndex = 0;
    }
    [_scrollView setContentOffset: CGPointMake(_scrollView.frame.size.width * nextIndex, 0) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _pageControl.currentPage = [self getDataIndex];
    if ([self.delegate respondsToSelector:@selector(pageScrollView:didEndDeceleratingAtIndex:)]) {
        [self.delegate pageScrollView:self didEndDeceleratingAtIndex:[self getDataIndex]];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    self.velocity = velocity;
}

#pragma mark - public instant Method

- (void)reloadData {
    if (!self.dataSource) {
        return;
    }
    
    if (_cycleScrollEnabled && _scrollView.contentOffset.x == 0) {
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    }
    
    if ([self.dataSource respondsToSelector:@selector(timeIntervalOfAutoScrollForPageScrollView:)]) {
        _scrollTime = [self.dataSource timeIntervalOfAutoScrollForPageScrollView:self];
        if (_scrollTime > 0) {
            [self fireTimer:YES];
        }
    }
    
    for (DDPageScrollViewCell *cell in _scrollView.subviews) {
        if ([cell isKindOfClass:[DDPageScrollViewCell class]]) {
            [self reusableCell:cell];
        }
    }
    
    _totalCount = [self.dataSource numberOfCellsInPageScrollView:self];
    _pageControl.numberOfPages = _totalCount;
    
    if (_totalCount == 0 || _scrollView.frame.size.width == 0) return;
    
    if (_cycleScrollEnabled) {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * (_totalCount + 2), _scrollView.frame.size.height);
    }
    else {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _totalCount, _scrollView.frame.size.height);
    }
    
    
    NSInteger index = (int)_scrollView.contentOffset.x / _scrollView.frame.size.width;
    NSInteger dateIndex = index;
    if (_cycleScrollEnabled) {
        dateIndex = index == 0 ? _totalCount - 1 : (index == _totalCount + 1 ? 0 : index - 1);
    }
    _pageControl.currentPage = dateIndex;
    
    DDPageScrollViewCell *cell = [self.dataSource pageScrollView:self cellForIndex:dateIndex];
    [self addCell:cell atIndex:index];
    
    if ((int)_scrollView.contentOffset.x % (int)_scrollView.frame.size.width > 0) {
        NSInteger nextIndex = index + 1;
        NSInteger nextDataIndex = nextIndex;
        if (_cycleScrollEnabled) {
            nextDataIndex = nextIndex == 0 ? _totalCount - 1 : (nextIndex == _totalCount + 1 ? 0 : nextIndex - 1);
        }
        DDPageScrollViewCell *cell = [self.dataSource pageScrollView:self cellForIndex:nextDataIndex];
        [self addCell:cell atIndex:nextIndex];
    }
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    NSMutableArray *reusableCellArray = [_reusableCellDict objectForKey:identifier];
    DDPageScrollViewCell *cell = reusableCellArray.lastObject;
    return cell;
}

- (void)selectCellAtIndex:(NSInteger)index animated:(BOOL)animated {
    NSInteger scrollIndex = index;
    if (_cycleScrollEnabled) scrollIndex = (index == _totalCount - 1)? 0: (index + 1);
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * scrollIndex, 0) animated:animated];
}

#pragma mark - support Method

- (void)visibleCell:(DDPageScrollViewCell *)cell {
    NSMutableArray *reusableCellArray = [_reusableCellDict objectForKey:cell.reuseIdentifie];
    [_visibleCells addObject:cell];
    [reusableCellArray removeObject:cell];
}

- (void)reusableCell:(DDPageScrollViewCell *)cell {
    NSMutableArray *reusableCellArray = [_reusableCellDict objectForKey:cell.reuseIdentifie];
    if (!reusableCellArray) {
        reusableCellArray = [NSMutableArray arrayWithCapacity:0];
        [_reusableCellDict setObject:reusableCellArray forKey:cell.reuseIdentifie];
    }
    [reusableCellArray addObject:cell];
    [_visibleCells removeObject:cell];
    [cell removeFromSuperview];
}


- (DDPageScrollViewCell *)cellForIndex:(NSUInteger)index {
    DDPageScrollViewCell *aCell = nil;
    for (DDPageScrollViewCell *cell in _visibleCells) {
        if (cell.index == index) {
            aCell = cell;
            break;
        }
    }
    return aCell;
}

- (void)addCell:(DDPageScrollViewCell *)cell atIndex:(NSUInteger)index {
    cell.pageScrollView = self;
    cell.index = index;
    cell.frame = CGRectMake(index * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:cell];
    [self visibleCell:cell];
}

- (NSInteger)getDataIndex {
    NSInteger index = (int)_scrollView.contentOffset.x / _scrollView.frame.size.width ;
    NSInteger dateIndex = index;
    if (_cycleScrollEnabled) {
        dateIndex = index == 0 ? _totalCount - 1 : (index == _totalCount + 1 ? 0 : index - 1);
    }
    
    return dateIndex;
}

#pragma mark - willMoveToWindow
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    if (_scrollTime <= 0) {
        return;
    }
    
    if (!newWindow) {
        [self setTimerShouldInvoke:NO];
    }
    else {
        [self setTimerShouldInvoke:YES];
    }
}

#pragma mark - override Method

- (void)setTimerShouldInvoke:(BOOL)timerShouldInvoke
{
    if (_timerShouldInvoke != timerShouldInvoke && _scrollTime > 0)
    {
        _timerShouldInvoke = timerShouldInvoke;
        if (_timerShouldInvoke) {
            [self fireTimer:YES];
        }
        else
        {
            [self fireTimer:NO];
        }
    }
}

#pragma mark - Timer

- (void)fireTimer:(BOOL)isFireTimer
{
    if (!self.timer)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_scrollTime
                                                      target:self
                                                    selector:@selector(timerInvoke)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    
    if (isFireTimer)
    {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_scrollTime]];
    }
    else
    {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)timerInvoke
{
    if (_totalCount == 0 || _scrollView.frame.size.width == 0) return;
    
    [self scrollToNextIndex];
}

@end
/********************************************************************************/
