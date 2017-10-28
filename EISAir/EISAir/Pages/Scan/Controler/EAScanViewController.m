//
//  EAScanViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAScanViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIBarButtonItem+Navigation.h"
#import "UINavigationItem+margin.h"

@interface EAScanViewController ()

@property(nonatomic , strong) UIButton *lightButton;

@end

@implementation EAScanViewController

+(instancetype)scanController
{
    EAScanViewController *controller = [[EAScanViewController alloc]init];
    
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    //扫码框周围4个角的类型设置为在框的上面
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    //扫码框周围4个角绘制线宽度
    style.photoframeLineW = 3;
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 20;
    //扫码框周围4个角的高度
    style.photoframeAngleH = 20;
    //显示矩形框
    style.isNeedShowRetangle = NO;
    //动画类型：网格形式，模仿支付宝
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    style.xScanRetangleOffset = 100;
    
    style.animationImage = SYS_IMG(@"scan_qr_icon");
    //码框周围4个角的颜色
    style.colorAngle = [UIColor whiteColor];
    //矩形框颜色
    style.colorRetangleLine = [UIColor orangeColor];
    //非矩形框区域颜色
    style.notRecoginitonArea = RGBA(0x33, 0x33, 0x33, .8);
    
    controller.style = style;
    
    controller.libraryType = SLT_Native;
    controller.scanCodeType = SCT_QRCode;
    
    return controller;
}

-(void)initBackItem
{
    UIBarButtonItem *backItem = [UIBarButtonItem defaultLeftItemWithTarget:self action:@selector(backAction)];
    
    [self.navigationItem setMarginLeftBarButtonItem:backItem];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"扫一扫";
    
    [self initBackItem];
    
    self.view.backgroundColor = HexColor(0x333333);
    
    _lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lightButton.frame = CGRectMake(0, 0, 120, 24);
    [_lightButton addTarget:self action:@selector(lightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *img = SYS_IMG(@"scan_qr_icon_light");
    [_lightButton setImage:img forState:UIControlStateNormal];
    [_lightButton setTitle:@"轻触点亮" forState:UIControlStateNormal];
    _lightButton.titleLabel.font = SYS_FONT(16);
    _lightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _lightButton.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - 180);

    [self.view addSubview:_lightButton];
        
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:_lightButton];
}


#pragma mark -实现类继承该方法，作出对应处理

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        NSLog(@"scanResult:%@",result.strScanned);
    //    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString* strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    //...
    
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    __weak __typeof(self) weakSelf = self;
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"扫一扫" message:strResult preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertActionStyle style =  UIAlertActionStyleCancel;
    // Create the actions.
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:style handler:^(UIAlertAction *action) {
        [weakSelf reStartDevice];
    }];
    [alertController addAction:action];
    [self.navigationController presentViewController:alertController animated:true completion:nil];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    //TODO : add action
    if (_doneBlock) {
        _doneBlock(strResult.strScanned);
    }
    [self.navigationController popViewControllerAnimated:false];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)lightAction:(id)sender
{
    [self openOrCloseFlash];
    [self.lightButton setTitle:self.isOpenFlash?@"轻触关闭":@"轻触点亮" forState:UIControlStateNormal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
