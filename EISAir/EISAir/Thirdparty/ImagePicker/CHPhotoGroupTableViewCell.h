//
//  FDPhotoGroupTableViewCell.h
//  Find
//
//  Created by chunhui on 15/8/6.
//  Copyright (c) 2015年 chunhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPhotoGroupTableViewCell : UITableViewCell

@property(nonatomic , weak) IBOutlet UIImageView *thumbImageView;
@property(nonatomic , weak) IBOutlet UILabel *nameLabel;
@property(nonatomic , weak) IBOutlet UILabel *countLabel;

-(void)updateWithThumb:(UIImage *)thumb name:(NSString *)name count:(NSInteger)count;

@end
