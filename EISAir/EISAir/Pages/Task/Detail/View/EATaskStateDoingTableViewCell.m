//
//  EATaskStateDoingTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskStateDoingTableViewCell.h"

@interface EATaskStateDoingTableViewCell()

@property(nonatomic , strong) IBOutlet UILabel *titleLabel;
@property(nonatomic , strong) IBOutlet UILabel *taskLabel;
@property(nonatomic , strong) IBOutlet UILabel *dateLabel;
@property(nonatomic , strong) IBOutlet UIView *bottomLine;
@end

@implementation EATaskStateDoingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat left = 20.5;
    
    BOOL isFirst = true;
    
    CGSize circelSize = CGSizeMake(11, 11) ;
    UIColor *lineColor = HexColor(0xd8d8d8);
    UIColor *circleColor =  HexColor(0x00b0ce);
    
    //draw line
    if (isFirst) {
        CGContextAddLineToPoint(context,left ,self.textLabel.centerY);
    }else {
        CGContextMoveToPoint(context, left, 0);
    }
    
    CGContextAddLineToPoint(context, left, self.height);
    
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextStrokePath(context);
    
    //draw circle
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(left-circelSize.width/2, self.titleLabel.centerY-circelSize.height/2, circelSize.width, circelSize.height)];

    CGContextSetFillColorWithColor(context, [circleColor CGColor]);
    [path fill];

    
}

@end
