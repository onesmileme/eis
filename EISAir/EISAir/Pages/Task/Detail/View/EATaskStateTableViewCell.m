//
//  EATaskStateTableViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskStateTableViewCell.h"
#import "EATaskStatusModel.h"

@interface EATaskStateTableViewCell()

@property(nonatomic , strong) IBOutlet UILabel *mainLabel;
@property(nonatomic , strong) IBOutlet UILabel *subLabel;
@property(nonatomic , strong) IBOutlet UIView *bottomLine;
@property(nonatomic , assign) BOOL isFirst;
@property(nonatomic , assign) BOOL isLast;
@end

@implementation EATaskStateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithModel:(EATaskStatusDataModel *)model isStart:(BOOL)isStart isLast:(BOOL)isLast
{
    self.isFirst = isStart;
    self.isLast = isLast;
    if (isStart) {
        self.mainLabel.text = model.createDate?:model.deliveryTime;
        self.subLabel.text = model.taskExecuteDesc;
    }else{
        self.mainLabel.text = model.taskExecuteDesc;
        self.subLabel.text = model.deliveryTime;
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat left = 20.5;
    
    BOOL isFirst = _isFirst;
    BOOL isDoing = false;
    CGSize circelSize = isDoing ? CGSizeMake(11, 11) : CGSizeMake(9, 9);
    UIColor *lineColor = HexColor(0xd8d8d8);
    UIColor *circleColor = isDoing ? HexColor(0x00b0ce) : lineColor;
    
    //draw line
    if (isFirst) {
        CGContextMoveToPoint(context,left ,self.mainLabel.centerY);
    }else {
        CGContextMoveToPoint(context, left, 0);
    }
    if (_isLast) {
        CGContextAddLineToPoint(context, left, self.mainLabel.centerY);
    }else{
        CGContextAddLineToPoint(context, left, self.height);
    }
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextStrokePath(context);
    
    //draw circle
    
    if (isFirst && !isDoing) {
        circelSize = CGSizeMake(9, 9);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(left-circelSize.width/2, self.mainLabel.centerY-circelSize.height/2, circelSize.width, circelSize.height)];
    if (isFirst && !isDoing) {
        
        CGContextSetStrokeColorWithColor(context, [circleColor CGColor]);
        path.lineWidth = 1;
        [path stroke];
        
    }else{
        CGContextSetFillColorWithColor(context, [circleColor CGColor]);
        [path fill];
    }
    
}

@end
