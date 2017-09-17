//
//  EATaskHandleTableViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , EATashHandler){
    EATashHandlerAccept = 0, //接受
    EATashHandlerReject = 1,//拒绝
    EATashHandlerToOther = 2, //指派他人
};

@interface EATaskHandleTableViewCell : UITableViewCell

@property(nonatomic , copy) void (^handleBlock)(EATashHandler handler);

@end
