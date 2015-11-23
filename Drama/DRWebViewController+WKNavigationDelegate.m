// DRWebViewController+WKNavigationDelegate.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "DRWebViewController+WKNavigationDelegate.h"


@implementation DRWebViewController (WKNavigationDelegate)

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if(!self.watchHistory.count) {
        return;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.watchHistory
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *filePath   = [[NSBundle mainBundle]pathForResource:@"HistoryCheck" ofType:@"js"];
    NSString *file       = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString *javaScript = [NSString stringWithFormat:file,jsonString];
    
    [webView evaluateJavaScript:javaScript completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error
{
    NSURL *failURL = error.userInfo[@"NSErrorFailingURLKey"];
    
    if(!failURL) {
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
