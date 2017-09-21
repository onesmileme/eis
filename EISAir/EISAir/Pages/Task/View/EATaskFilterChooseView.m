//
//  EATaskFilterChooseView.m
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskFilterChooseView.h"


@interface EATaskFilterCell : UITableViewCell

@property(nonatomic , strong)UIImageView *imgView;
@property(nonatomic , strong)UILabel *titleLabel;

@end

@interface EATaskFilterChooseView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UITableView *tableView;

@end

@implementation EATaskFilterChooseView

+(instancetype)view
{
    EATaskFilterChooseView *v = [[EATaskFilterChooseView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    return v;
}

-(void)show
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}
-(void)hide
{
    [self removeFromSuperview];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.width-120, 70, 103, 90)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self addSubview:_tableView];
        
        self.backgroundColor = RGBA(0x4a, 0x4a, 0x4a, 0.2);
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EATaskFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[EATaskFilterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    
    UIImage *img = nil;
    NSString *title = nil;
    if (indexPath.row == 0) {
        
        img = SYS_IMG(@"task_choose_icon1");
        title = @"状态筛选";
        
    }else{
        img = SYS_IMG(@"task_choose_icon2");
        title = @"对象筛选";
    }
    
    cell.imgView.image = img;
    cell.titleLabel.text = title;    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_chooseBlock) {
        _chooseBlock(indexPath.row);
    }
    [self hide];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation EATaskFilterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc]init];
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SYS_FONT(15);
        _titleLabel.textColor = HexColor(0x666666);
        
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgView.frame = CGRectMake(10, (self.height-15)/2, 15, 15);
    _titleLabel.frame = CGRectMake(34, 0, self.width-34, self.height);
}

@end
