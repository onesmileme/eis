//
//  FALoginTipAlertView.h
//  FunApp
//
//  Created by chunhui on 2016/8/12.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EALoginTipAlertView : UIView

+(instancetype)loginTipAlertView:(void(^)())loginBlock showProtocol:(void(^)())showProtocolBlock;

-(void)showIn:(UIView *)view;

-(void)hide;

@end

