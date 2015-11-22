// DRWebViewController+IBActions.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "DRWebViewController+IBActions.h"


@implementation DRWebViewController (IBActions)

#pragma mark - UnwindSegue for exit clicked
- (IBAction)unwidSegueForExitItemClicked:(UIStoryboardSegue *)sender
{
    
}

#pragma mark - BackButton clicked
- (IBAction)backButtonClicked:(id)sender
{
    [self.webView goBack];
}

#pragma mark - BackButton long press
- (IBAction)backButtonLongPressed:(UILongPressGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        NSArray *history = self.webView.backForwardList.backList;
        
        [self performSegueWithIdentifier:@"toDRHistoryViewController" sender:history];
    }
}

#pragma mark - ForwardButton clicked
- (IBAction)forwardButtonClicked:(id)sender
{
    [self.webView goForward];
}

#pragma mark - ForwardButton long press
- (IBAction)forwardButtonLongPressed:(UILongPressGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        NSArray *history = self.webView.backForwardList.forwardList;
        
        [self performSegueWithIdentifier:@"toDRHistoryViewController" sender:history];
    }
}

#pragma mark - 加入書籤 clicked
- (IBAction)addItemClicked:(id)sender
{
    if(!self.webView.title.length || !self.webView.URL) {
        return;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *temp               = [userDefault objectForKey:@"bookmarks"];
    NSMutableArray *bookmarks   = [temp mutableCopy];
    
    if(!bookmarks) {
        bookmarks = [NSMutableArray array];
    }
    
    NSString *title       = self.webView.title;
    NSString *urlString   = self.webView.URL.absoluteString;
    NSDictionary *webSite = @{@"title" : title,
                              @"url"   : urlString};
    
    [bookmarks addObject:webSite];
    [userDefault setObject:bookmarks forKey:@"bookmarks"];
    [userDefault synchronize];
    
    NSString *message = [NSString stringWithFormat:@"已將 %@ 加入書籤", title];
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"Succeed"
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

@end
