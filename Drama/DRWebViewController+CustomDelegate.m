// DRWebViewController+CustomDelegate.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "DRWebViewController+CustomDelegate.h"


@implementation DRWebViewController (CustomDelegate)

#pragma mark - DRBookmarksViewControllerDelegate
- (void)mvc:(DRBookmarksViewController *)mvc selectedBookmark:(NSDictionary *)bookmark
{
    [mvc dismissViewControllerAnimated:YES completion:^{
        NSString *urlString   = bookmark[@"url"];
        NSURL *URL            = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        [self.webView loadRequest:request];
    }];
}

#pragma mark - DRHistoryViewControllerDelegate
- (void)mvc:(DRHistoryViewController *)mvc selectedHistory:(WKBackForwardListItem *)history
{
    [mvc dismissViewControllerAnimated:YES completion:^{
        [self.webView goToBackForwardListItem:history];
    }];
}

@end
