//
//  EAAddTaskInputCell.h
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAAddTaskInputCell : UITableViewCell

@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UITextField *contentField;
@property(nonatomic , strong) IBOutlet UIButton *modifyButton;

@end