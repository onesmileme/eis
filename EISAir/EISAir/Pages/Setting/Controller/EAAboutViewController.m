//
//  EAAboutViewController.m
//  EISAir
//
//  Created by chunhui on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAAboutViewController.h"
#import <WebKit/WebKit.h>

@interface EAAboutViewController ()

@property(nonatomic , strong) WKWebView *webView;


@end

@implementation EAAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于EIS Air";
    _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
