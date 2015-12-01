// DRWebViewController+KVO.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "DRWebViewController+KVO.h"


@implementation DRWebViewController (KVO)

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"loading"])
    {
        BOOL loading = [change[NSKeyValueChangeNewKey]boolValue];
        
        if(loading)
        {
            self.title = @"Loading...";
            self.progressView.hidden = NO;
        }
        else
        {
            self.title = self.webView.title;
            self.progressView.hidden = YES;
        }
    }
    else if([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.progressView.progress = [change[NSKeyValueChangeNewKey]floatValue];
    }
    else if([keyPath isEqualToString:@"canGoBack"])
    {
        self.backButton.enabled = [change[NSKeyValueChangeNewKey]boolValue];
    }
    else if([keyPath isEqualToString:@"canGoForward"])
    {
        self.forwardButton.enabled = [change[NSKeyValueChangeNewKey]boolValue];
    }
}

#pragma mark - Public
- (void)kvo_setup
{
    [self.webView addObserver:self forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew context:nil];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew context:nil];
    
    [self.webView addObserver:self forKeyPath:@"canGoBack"
                      options:NSKeyValueObservingOptionNew context:nil];
    
    [self.webView addObserver:self forKeyPath:@"canGoForward"
                      options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)kvo_remove
{
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
}

@end
