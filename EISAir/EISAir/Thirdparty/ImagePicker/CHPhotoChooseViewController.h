//
//  FDPhotoChooseViewController.h
//  Find
//
//  Created by chunhui on 15/8/6.
//  Copyright (c) 2015年 chunhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerGroup.h"

/**
 *  图片选择页面
 */
@interface CHPhotoChooseViewController : UIViewController

@property (nonatomic , copy)   void (^backActionBlock)();
@property (nonatomic , copy)   void (^nextActionBlcok)(NSArray *assets);
@property (nonatomic , copy)   void (^chooseBlock)(NSArray *assets);
@property (nonatomic , copy)   void (^chooseRefuseBlock)();//选择使用相册被拒绝

@property (nonatomic , strong) NSString *rightItemName;

@property (nonatomic , strong) ZLPhotoPickerGroup *assetsGroup;
// 需要记录选中的值的数据
@property (strong,nonatomic) NSArray *selectPickerAssets;
// 置顶展示图片
@property (assign,nonatomic) BOOL topShowPhotoPicker;

@property (nonatomic , assign) NSInteger maxCount;

//所有的group,ZLPhotoPickerGroup 类型
@property (nonatomic , strong) NSArray *assetGroups;

-(NSArray *)chooseAssets;

-(void)clear;

@end
