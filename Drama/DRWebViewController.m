// DRWebViewController.m
// 
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <WebKit/WebKit.h>
#import "DRWebViewController.h"
#import "DRWebViewController+KVO.h"
#import "DRWebViewController+CustomDelegate.h"

NSString * const HomeWebSite = @"http://8drama.com";


@implementation DRWebViewController

#pragma mark - LifeCycle
- (void)dealloc
{
    [self kvo_remove];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setup];
    [self kvo_setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_webView.URL) {
        NSURL *home = [NSURL URLWithString:HomeWebSite];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:home]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toDRHistoryViewController"]) {
        UINavigationController *nav  = segue.destinationViewController;
        DRHistoryViewController *mvc = (DRHistoryViewController *)nav.topViewController;
        mvc.dataSource = sender;
        mvc.delegate   = self;
    }
    else if([segue.identifier isEqualToString:@"toDRBookmarksViewController"]) {
        UINavigationController *nav    = segue.destinationViewController;
        DRBookmarksViewController *mvc = (DRBookmarksViewController *)nav.topViewController;
        mvc.delegate = self;
    }
}

#pragma mark - Private
- (void)__setup
{
    _backButton.enabled    = NO;
    _forwardButton.enabled = NO;

    _webView = ({
        WKWebView *temp = [[WKWebView alloc]init];
        temp.allowsBackForwardNavigationGestures = YES;
        
        [temp setTranslatesAutoresizingMaskIntoConstraints:NO];
        temp;
    });
    
    [self.view addSubview:_webView];
    
    NSString *v = @"V:[progressView]-1.0-[webView]-0-[bottomLayoutGuide]";
    NSString *h = @"H:|-0-[webView]-0-|";
    
    NSDictionary *views = @{@"progressView"      : _progressView,
                            @"webView"           : _webView,
                            @"bottomLayoutGuide" : self.bottomLayoutGuide};
    
    
    [NSLayoutConstraint activateConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:v options:0 metrics:nil views:views]];
    
    [NSLayoutConstraint activateConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:h options:0 metrics:nil views:views]];
}

@end
