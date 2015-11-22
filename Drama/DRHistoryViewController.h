// DRHistoryViewController.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/22.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <UIKit/UIKit.h>

@class WKBackForwardListItem;
@class DRHistoryViewController;

/**
 *  DRHistoryViewController protocol.
 */
@protocol DRHistoryViewControllerDelegate <NSObject>


///-----------------------------------------------------------------------------
/// @name Required methods
///-----------------------------------------------------------------------------

/**
 *  DRHistoryViewController 點中歷史紀錄的 handle.
 *
 *  @param mvc     DRHistoryViewController object.
 *  @param history 點中的歷史紀錄.
 */
- (void)mvc:(DRHistoryViewController *)mvc selectedHistory:(WKBackForwardListItem *)history;

@end


/**
 *  網站歷史紀錄.
 */
@interface DRHistoryViewController : UITableViewController


///-----------------------------------------------------------------------------
/// @name Properties
///-----------------------------------------------------------------------------

/**
 *  歷史紀錄 data.
 */
@property (nonatomic, strong) NSArray *dataSource;

/**
 *  DRHistoryViewControllerDelegate 的 delegation.
 */
@property (nonatomic, weak) id<DRHistoryViewControllerDelegate>delegate;

@end
