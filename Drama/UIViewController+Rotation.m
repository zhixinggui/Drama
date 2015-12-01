// UIViewController+Rotation.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <AVKit/AVKit.h>
#import "UIViewController+Rotation.h"


@implementation UIViewController (Rotation)

#pragma mark - UIViewController
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    id mvc    = self.childViewControllers.lastObject;
    BOOL iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    
    if([mvc isKindOfClass:[AVPlayerViewController class]] || iPad)
    {
        return UIInterfaceOrientationMaskAll;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

@end
