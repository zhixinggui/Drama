// DRWebViewController+WKNavigationDelegate.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "NSObject+Utility.h"
#import "DRWebViewController+WKNavigationDelegate.h"


@implementation DRWebViewController (WKNavigationDelegate)

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSArray *bookmarksURL = [self.bookmarks valueForKey:@"url"];
    
    NSMutableArray *shouldHighlightLinks = ^{
        NSMutableArray *temp = [@[] mutableCopy];
        [temp addObjectsFromArray:bookmarksURL];
        [temp addObjectsFromArray:self.watchHistory];
        
        return temp;
    }();
    
    NSString *JSONArray = [NSObject utility_jsonStringFromNSArray:shouldHighlightLinks];
    
    if(JSONArray.length)
    {
        NSString *javaScript = [NSString stringWithFormat:self.linksHighlight, JSONArray];
        
        [webView evaluateJavaScript:javaScript completionHandler:nil];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error
{
    NSURL *failURL = error.userInfo[@"NSErrorFailingURLKey"];
    
    if(!failURL)
    {
        return;
    }
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"錯誤!"
                                        message:@"無法載入頁面."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *doNothing = [UIAlertAction actionWithTitle:@"確定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil];
    
    UIAlertAction *goHome = [UIAlertAction actionWithTitle:@"返回首頁"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
        NSURL *homeURL = [NSURL URLWithString:HomeWebSite];
        NSURLRequest *request = [NSURLRequest requestWithURL:homeURL];
        [self.webView loadRequest:request];
    }];
    
    UIAlertAction *reload = [UIAlertAction actionWithTitle:@"重新載入"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
        NSURLRequest *request = [NSURLRequest requestWithURL:failURL];
        [self.webView loadRequest:request];
    }];
    
    [alert addAction:doNothing];
    [alert addAction:goHome];
    [alert addAction:reload];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
