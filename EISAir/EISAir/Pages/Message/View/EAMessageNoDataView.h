//
//  EAMessageNoDataView.h
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAMessageNoDataView : UIView

@property(nonatomic , strong) IBOutlet UIImageView *tipImageView;
@property(nonatomic , strong) IBOutlet UILabel *tipLabel;

@property(nonatomic , copy) void (^tapBlock)();

@property(nonatomic , assign) BOOL isTask;

+(instancetype)view;

@end
