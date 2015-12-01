// DRWebViewController.m
// 
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <WebKit/WebKit.h>
#import "DRWebViewController.h"
#import "DRWebViewController+KVO.h"
#import "DRWebViewController+CustomDelegate.h"
#import "DRWebViewController+WKNavigationDelegate.h"
#import "AVPlayerViewController+GestureRecognizer.h"

NSString * const HomeWebSite = @"http://8drama.com";
NSString * const WatchHistoryDeleteNotification = @"watchHistory_delete";


@implementation DRWebViewController

#pragma mark - LifeCycle
- (void)dealloc
{
    [self kvo_remove];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setup];
    [self __setupUI];
    [self kvo_setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_webView.URL)
    {
        NSURL *home = [NSURL URLWithString:HomeWebSite];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:home]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toDRHistoryViewController"])
    {
        UINavigationController *nav  = segue.destinationViewController;
        DRHistoryViewController *mvc = (DRHistoryViewController *)nav.topViewController;
        mvc.dataSource = sender;
        mvc.delegate   = self;
    }
    else if([segue.identifier isEqualToString:@"toDRBookmarksViewController"])
    {
        UINavigationController *nav    = segue.destinationViewController;
        DRBookmarksViewController *mvc = (DRBookmarksViewController *)nav.topViewController;
        mvc.bookmarks = _bookmarks;
        mvc.delegate  = self;
    }
}

#pragma mark - Private
- (void)__setup
{
    NSArray *tempHistory   = [[NSUserDefaults standardUserDefaults]arrayForKey:@"watchHistory"];
    _watchHistory          = tempHistory ? [tempHistory mutableCopy] : [@[] mutableCopy];

    NSArray *tempBookmarks = [[NSUserDefaults standardUserDefaults]objectForKey:@"bookmarks"];
    _bookmarks             = tempBookmarks ? [tempBookmarks mutableCopy] : [@[] mutableCopy];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"LinksHighlight" ofType:@"js"];
    _linksHighlight    = [NSString stringWithContentsOfFile:filePath
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(__playerViewDidLoadNotification:)
                                                name:AVPlayerViewControllerViewDidLoadNotification
                                              object:nil];
}

- (void)__setupUI
{
    _backButton.enabled    = NO;
    _forwardButton.enabled = NO;
    
    _webView = ({
        WKWebView *temp = [[WKWebView alloc]init];
        temp.allowsBackForwardNavigationGestures = YES;
        temp.navigationDelegate = self;
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

- (void)__playerViewDidLoadNotification:(NSNotification *)sender
{
    NSString *watchURLString = _webView.URL.absoluteString;
    
    if(![_watchHistory containsObject:watchURLString]) {
        [_watchHistory addObject:watchURLString];
        [[NSUserDefaults standardUserDefaults]setObject:_watchHistory forKey:@"watchHistory"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

@end
