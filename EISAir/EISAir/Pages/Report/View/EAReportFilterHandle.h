//
//  EAReportFilterHandle.h
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EAReportFilterHandle;
@protocol EAReportFilterHandleProtocol <NSObject>
- (void)filterHandle:(EAReportFilterHandle *)handle clickedInCategory:(NSInteger)categoryIndex rowIndex:(NSInteger)rowIndex;
@end

@interface EAReportFilterHandle : NSObject

@property (nonatomic, weak) id<EAReportFilterHandleProtocol> delegate;
- (instancetype)initWithData:(NSArray *)data;
- (UIView *)filterBar;

@end
