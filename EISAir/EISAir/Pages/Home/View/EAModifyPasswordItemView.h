//
//  EAModifyPasswordItemView.h
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAModifyPasswordItemView : UIView

@property(nonatomic , strong) IBInspectable UILabel *titleLabel;
@property(nonatomic , strong) IBInspectable UILabel *tipLabel;
@property(nonatomic , strong) IBInspectable UITextField *textField;

-(void)showSecure:(BOOL)secure;

-(void)updateTitle:(NSString *)title;
-(void)updateTip:(NSString *)tip;

@end
