// DRBookmarksViewController.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/22.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <UIKit/UIKit.h>

@class DRBookmarksViewController;

/**
 *  DRBookmarksViewController protocol.
 */
@protocol DRBookmarksViewControllerDelegate <NSObject>


///-----------------------------------------------------------------------------
/// @name Required methods
///-----------------------------------------------------------------------------

/**
 *  DRBookmarksViewController 點中書籤後的 handle.
 *
 *  @param mvc      DRBookmarksViewController object.
 *  @param bookmark 點中的書籤.
 */
- (void)mvc:(DRBookmarksViewController *)mvc selectedBookmark:(NSDictionary *)bookmark;

@end


/**
 *  書籤列表.
 */
@interface DRBookmarksViewController : UITableViewController


///-----------------------------------------------------------------------------
/// @name Properties
///-----------------------------------------------------------------------------

/**
 *  書籤.
 */
@property (nonatomic, weak) NSMutableArray *bookmarks;

/**
 *  DRBookmarksViewControllerDelegate 的 delegation.
 */
@property (nonatomic, weak) id<DRBookmarksViewControllerDelegate>delegate;

@end
