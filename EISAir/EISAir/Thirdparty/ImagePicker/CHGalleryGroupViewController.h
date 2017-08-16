//
//  FDGalleryGroupViewController.h
//  Find
//
//  Created by chunhui on 15/8/6.
//  Copyright (c) 2015年 chunhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerGroup.h"
/**
 *  相册选择页面
 */
@interface CHGalleryGroupViewController : UITableViewController

@property(nonatomic , strong) NSArray *groups;
@property(nonatomic , copy) void (^chooseGroupBlock)(ZLPhotoPickerGroup *group);

@end
