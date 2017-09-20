//
//  EAReportFilterHandle.h
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAReportFilterHandle : NSObject

- (instancetype)initWithData:(NSArray *)data;
- (UIView *)filterBar;

@end
