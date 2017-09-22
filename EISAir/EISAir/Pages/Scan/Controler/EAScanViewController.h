//
//  EAScanViewController.h
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "LBXScanViewController.h"

@interface EAScanViewController : LBXScanViewController

@property(nonatomic , copy) void(^doneBlock)(NSString *urlcode);

+(instancetype)scanController;


@end
