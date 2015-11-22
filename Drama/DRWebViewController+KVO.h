// DRWebViewController+KVO.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "DRWebViewController.h"

/**
 *  DRWebViewController category.
 *
 *  用來處理 KVO handle 的 category.
 */
@interface DRWebViewController (KVO)


///-----------------------------------------------------------------------------
/// @name Category methods
///-----------------------------------------------------------------------------

/**
 *  設置 KVO
 */
- (void)kvo_setup;

/**
 *  移除 KVO
 */
- (void)kvo_remove;

@end
