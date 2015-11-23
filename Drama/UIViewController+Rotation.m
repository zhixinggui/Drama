// UIViewController+Rotation.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <AVKit/AVKit.h>
#import "UIViewController+Rotation.h"


@implementation UIViewController (Rotation)

#pragma mark - Rotate
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    id mvc = self.childViewControllers.lastObject;
    
    if([mvc isKindOfClass:[AVPlayerViewController class]] ||
        UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    }
    
    return UIInterfaceOrientationMaskPortrait;
    
}

@end
