//
//  EAReportListVC.h
//  EISAir
//
//  Created by iwm on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EABaseViewController.h"

typedef NS_ENUM(NSUInteger, EAReportListVCType) {
    EAReportListVCTypeList,     // 展开的文件列表
    EAReportListVCTypeFolder,   // 文件夹
};

typedef NS_ENUM(NSUInteger, EAReportListContentType) {
    EAReportListContentTypeDay, // 日报
    EAReportListContentTypeMouth,
    EAReportListContentTypeSpecial,
};

@interface EAReportListVC : EABaseViewController

@property (nonatomic, assign) EAReportListVCType showType;
@property (nonatomic, assign) EAReportListContentType contentType;
@property (nonatomic, strong) NSString *reportId;

@end
