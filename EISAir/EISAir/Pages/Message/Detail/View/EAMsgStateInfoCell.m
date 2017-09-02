//
//  EAMsgStateInfoCell.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgStateInfoCell.h"

@interface EAMsgStateInfoCell ()

@property(nonatomic , strong) UIView *bottomLine;

@end

@implementation EAMsgStateInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(40, 0, 0, 0.5)];
        _bottomLine.backgroundColor = HexColor(0xebebeb);
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}


-(void)updateWithModel:(id)model isFirst:(BOOL)isFirst
{
    self.textLabel.text = @"王磊执行该任务";
    self.textLabel.textColor = isFirst ? HexColor(0x00B0CE) : HexColor(0x858585);
    self.textLabel.font = SYS_FONT(17);
    
    self.detailTextLabel.text = @"10分钟前";
    self.detailTextLabel.textColor = HexColor(0xB0B0B0);
    self.detailTextLabel.font = SYS_FONT(12);
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.textLabel sizeToFit];
    self.textLabel.frame = CGRectMake(40, 13, MIN(self.width-50, self.textLabel.width), 18);
    [self.detailTextLabel sizeToFit];
    self.detailTextLabel.frame = CGRectMake(40, self.textLabel.bottom+6.5, MIN(self.width-50, self.detailTextLabel.width), 18.5);
    self.bottomLine.frame = CGRectMake(40, self.height - 0.5, self.width-40, 0.5);
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat left = 21.5;
    
    BOOL isFirst = false;
    BOOL isDoing = false;
    CGSize circelSize = isDoing ? CGSizeMake(11, 11) : CGSizeMake(9, 9);
    UIColor *lineColor = HexColor(0xd8d8d8);
    UIColor *circleColor = isDoing ? HexColor(0x00b0ce) : lineColor;
    
    //draw line
    if (isFirst) {
        CGContextMoveToPoint(context,left ,self.textLabel.centerY);
    }else {
        CGContextMoveToPoint(context, left, 0);
    }
    
    CGContextAddLineToPoint(context, left, self.height);
    
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextStrokePath(context);
    
    //draw circle
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(left-circelSize.width/2, self.textLabel.centerY-circelSize.height/2, circelSize.width, circelSize.height)];
    CGContextSetFillColorWithColor(context, [circleColor CGColor]);
    [path fill];
}

@end
