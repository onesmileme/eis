//
//  EAMsgSearchFilterTableViewCell.h
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAMsgSearchFilterTableViewCell : UITableViewCell

@property(nonatomic , copy) void (^chooseBlock)(EAMsgSearchFilterTableViewCell *cell , id model , BOOL checked);

-(BOOL)checked;

-(void)updateTitle:(NSString *)title msg:(NSString *)msg checked:(BOOL)checked;

@end
