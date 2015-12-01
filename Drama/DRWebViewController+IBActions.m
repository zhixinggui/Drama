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

#pragma mark - Action clicked
- (IBAction)actionItemClicked:(id)sender
{
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:nil
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    // iPad 要用 POPOver 才能顯示 ActionSheet, 不然會 Crash.
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIPopoverPresentationController *pop = [alert popoverPresentationController];
        pop.sourceView = self.view;
        
        // 44 為 macigc number, 為最右邊的 UIBarButtonItem.
        // 千萬不要使用 pop.barButtonItem = sender,
        // 因為使用了當 Popover 出現時, 可以點擊其他 item 會造成 bug.
        pop.sourceRect = ({
            CGRect temp = CGRectZero;
            temp.origin.x = CGRectGetMaxX(self.navigationController.navigationBar.frame) - 44;
            temp.origin.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
            temp;
        });
    }
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    
    UIAlertAction *addToBookmarks =
    [UIAlertAction actionWithTitle:@"加入書籤"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * _Nonnull action) {
        [self __addToBookmarks];
    }];
    
    UIAlertAction *cleanWebCache =
    [UIAlertAction actionWithTitle:@"清除網頁快取"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * _Nonnull action) {
        [self __cleanWebCache];
    }];
    
    UIAlertAction *cleanWatchHistory =
    [UIAlertAction actionWithTitle:@"清除觀看紀錄"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * _Nonnull action) {
        [self __cleanWatchHistory];
    }];
    
    [alert addAction:cancel];
    [alert addAction:addToBookmarks];
    [alert addAction:cleanWebCache];
    [alert addAction:cleanWatchHistory];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Private
- (void)__addToBookmarks
{
    if(!self.webView.title.length || !self.webView.URL)
    {
        return;
    }
    
    NSString *title       = self.webView.title;
    NSString *urlString   = self.webView.URL.absoluteString;
    NSDictionary *webSite = @{@"title" : title, @"url"   : urlString};
    
    [self.bookmarks addObject:webSite];
    [[NSUserDefaults standardUserDefaults]setObject:self.bookmarks forKey:@"bookmarks"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *message = [NSString stringWithFormat:@"已將 %@ 加入書籤", title];
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"加入書籤"
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK =
    [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)__cleanWebCache
{
    NSSet *websiteDataTypes
    = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                            WKWebsiteDataTypeOfflineWebApplicationCache,
                            WKWebsiteDataTypeMemoryCache,
                            WKWebsiteDataTypeLocalStorage,
                            WKWebsiteDataTypeCookies,
                            WKWebsiteDataTypeSessionStorage,
                            WKWebsiteDataTypeIndexedDBDatabases,
                            WKWebsiteDataTypeWebSQLDatabases]];
    
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];

    [[WKWebsiteDataStore defaultDataStore]removeDataOfTypes:websiteDataTypes
                                              modifiedSince:dateFrom
                                          completionHandler:^{
        
    }];
}

- (void)__cleanWatchHistory
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"watchHistory"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.watchHistory removeAllObjects];
}

@end
