// DRWebViewController.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

/**
 *  網站首頁網址.
 */
extern NSString * const HomeWebSite;


/**
 *  Web Controller.
 */
@interface DRWebViewController : UIViewController


///-----------------------------------------------------------------------------
/// @name Properties
///-----------------------------------------------------------------------------

/**
 *  網站載入進度條.
 */
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;

/**
 *  網站 back 按鈕.
 */
@property (nonatomic, weak) IBOutlet UIButton *backButton;

/**
 *  網站 forward 按鈕.
 */
@property (nonatomic, weak) IBOutlet UIButton *forwardButton;

/**
 *  Web View.
 */
@property (nonatomic, strong) WKWebView *webView;

/**
 *  已經看過的影片歷史.
 */
@property (nonatomic, strong) NSMutableArray *watchHistory;

/**
 *  書籤列表.
 */
@property (nonatomic, strong) NSMutableArray *bookmarks;

/**
 *  Highlight Links JavaScript.
 */
@property (nonatomic, strong) NSString *linksHighlight;

@end
