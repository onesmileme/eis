//
//  WMWebViewController.m
//  EISAir
//
//  Created by DoubleHH on 2017/10/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "WMWebViewController.h"
#import "EAShareReportView.h"

@interface WMWebViewController () <UIWebViewDelegate>

@end

@implementation WMWebViewController {
    UIWebView *_webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavbar];
    [self initWebView];
    [self loadWebView];
}

- (void)initNavbar {
    // 设置右边的搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 40, 40);
    UIImage *img = [UIImage imageNamed:@"点"];
    [searchButton setImage:img forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [searchButton sizeToFit];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
}

- (void)share {
    [EAShareReportView showWithUrl:self.url fromVC:self];
}

- (void)initWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _webView.frame = self.view.bounds;
}

- (void)loadWebView {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
