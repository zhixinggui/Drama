// DRWebViewController+CustomDelegate.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "DRWebViewController.h"
#import "DRHistoryViewController.h"
#import "DRBookmarksViewController.h"

/**
 *  DRWebViewController Category.
 *
 *  用來處理其他自定義的 Delegate handle 的 category.
 */
@interface DRWebViewController (CustomDelegate)
<
    DRHistoryViewControllerDelegate,
    DRBookmarksViewControllerDelegate
>

@end
