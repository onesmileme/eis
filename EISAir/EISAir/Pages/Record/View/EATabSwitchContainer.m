//
//  EATabSwitchContainer.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/1.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATabSwitchContainer.h"
#import "EATabSwitchControl.h"

static const int kTabSwtichControlHeight = 40;

@interface EATabSwitchContainer () <UIScrollViewDelegate>

@end

@implementation EATabSwitchContainer {
    EATabSwitchControl *_tabSwtichControl;
    UIScrollView *_contentView;
    
    struct ContainerDelegate {
        BOOL tabSwitchContainerHeaderTitles;
        BOOL tabSwitchContainerHeaderConfig;
        BOOL viewForIndex;
        BOOL selectedIndex;
        BOOL tabSwitchContainerHeaderHeight;
    } _containerDelegate;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDelegate:(id<EATabSwitchContainerProtocol>)delegate {
    _delegate = delegate;
    
    _containerDelegate.tabSwitchContainerHeaderTitles = [self.delegate respondsToSelector:@selector(tabSwitchContainerHeaderTitles:)];
    _containerDelegate.tabSwitchContainerHeaderConfig = [self.delegate respondsToSelector:@selector(tabSwitchContainerHeaderConfig:)];
    _containerDelegate.viewForIndex = [self.delegate respondsToSelector:@selector(tabSwitchContainer:viewForIndex:)];
    _containerDelegate.selectedIndex = [self.delegate respondsToSelector:@selector(tabSwitchContainer:selectedIndex:)];
}

- (void)initViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!_containerDelegate.tabSwitchContainerHeaderTitles) {
        return;
    }
    NSArray *titles = [self.delegate tabSwitchContainerHeaderTitles:self];
    NSDictionary *config = _containerDelegate.tabSwitchContainerHeaderConfig ? [self.delegate tabSwitchContainerHeaderConfig:self] : nil;
    UIFont *titleFont = config[@"titleFont"] ?: [UIFont systemFontOfSize:15];
    CGFloat lineWidth = [config[@"lineWidth"] intValue] ?: FlexibleWithTo6(115);
    UIColor *lineColor = config[@"lineColor"] ?: HexColor(0x058497);
    _tabSwtichControl = [[EATabSwitchControl alloc] initWithFrame:CGRectMake(0, 0, self.width, kTabSwtichControlHeight)
                                                        itemArray:titles
                                                        titleFont:titleFont
                                                        lineWidth:lineWidth
                                                        lineColor:lineColor];
    [self addSubview:_tabSwtichControl];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _tabSwtichControl.bottom, self.width, self.height - _tabSwtichControl.bottom)];
    _contentView.pagingEnabled = YES;
    _contentView.delegate = self;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.contentSize = CGSizeMake(_contentView.width * titles.count, _contentView.height);
    _contentView.scrollsToTop = NO;
    [self addSubview:_contentView];
}

- (void)updatePage {
    _tabSwtichControl.selectedIndex = MAX(0, _contentView.contentOffset.x / _contentView.width);
}

#pragma mark - mark
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updatePage];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self updatePage];
}

@end
