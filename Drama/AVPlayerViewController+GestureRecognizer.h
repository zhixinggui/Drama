// AVPlayerViewController+GestureRecognizer.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <AVKit/AVKit.h>

/**
 *  Notification for AVPlayerViewController.
 *
 *  代表 User 已經使用 HTML5 Player, 並且已經全螢幕使用. 如果是 iPad 且沒有使用全螢幕將不會觸發.
 */
extern NSString * const AVPlayerViewControllerViewDidLoadNotification;


/**
 *  AVPlayerViewController category.
 *
 *  利用 Runtime 與 Category, 將自定義的手勢加入 AVPlayerViewController.
 */
@interface AVPlayerViewController (GestureRecognizer)

@end
