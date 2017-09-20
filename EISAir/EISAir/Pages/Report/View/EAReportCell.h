//
//  EAReportCell.h
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, EAReportCellStyle) {
    EAReportCellStyleSingle,
    EAReportCellStyleFolder,
};

@interface EAReportCell : EABaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellStyle:(EAReportCellStyle)cellStyle;

@end
