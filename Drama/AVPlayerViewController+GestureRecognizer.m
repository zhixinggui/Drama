// AVPlayerViewController+GestureRecognizer.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <objc/runtime.h>
#import "AVPlayerViewController+GestureRecognizer.h"

NSString * const AVPlayerViewControllerViewDidLoadNotification = @"swizzling_viewDidLoad";


@implementation AVPlayerViewController (GestureRecognizer)

#pragma mark - LifeCycle
+ (void)load
{
    // Method swizzling
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(swizzling_viewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)swizzling_viewDidLoad
{
    [self swizzling_viewDidLoad];
    [self __addSwipeGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:AVPlayerViewControllerViewDidLoadNotification object:nil];
}

#pragma mark - Private
- (void)__addSwipeGestureRecognizer
{
    // 將左滑右滑手勢加到 containerView.
    // 因為內建的手勢都加到 containerView, 所以順勢將左滑右滑手勢加入.
    
    @try {
        UIView *containerView = [self valueForKey:@"containerView"];
        
        UISwipeGestureRecognizer *swipeLeft =
        [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(__swipeLeftHandle:)];
        
        UISwipeGestureRecognizer *swipeRight =
        [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(__swipeRightHandle:)];
        
        swipeLeft.direction  = UISwipeGestureRecognizerDirectionLeft;
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        
        [containerView addGestureRecognizer:swipeLeft];
        [containerView addGestureRecognizer:swipeRight];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

- (void)__swipeLeftHandle:(UISwipeGestureRecognizer *)sender
{
    // 左滑手勢 Handle, 後退 10 秒.
    
    @try {
        NSInvocation *invocation = ({
            id playerController          = [self valueForKey:@"playerController"];
            SEL seekToTime               = NSSelectorFromString(@"seekToTime:");
            NSMethodSignature *signature = [playerController methodSignatureForSelector:seekToTime];
            NSInvocation *temp           = [NSInvocation invocationWithMethodSignature:signature];
            temp.selector                = seekToTime;
            temp.target                  = playerController;
            temp;
        });
        
        NSInteger currentTimeInSeconds = [self __currentTimeInSeconds];
        double back10Seconds           = currentTimeInSeconds - 10.0;
        
        [invocation setArgument:&back10Seconds atIndex:2];
        [invocation invoke];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

- (void)__swipeRightHandle:(UISwipeGestureRecognizer *)sender
{
    // 右滑手勢 Handle, 前進 10 秒.
    
    @try {
        NSInvocation *invocation = ({
            id playerController          = [self valueForKey:@"playerController"];
            SEL seekToTime               = NSSelectorFromString(@"seekToTime:");
            NSMethodSignature *signature = [playerController methodSignatureForSelector:seekToTime];
            NSInvocation *temp           = [NSInvocation invocationWithMethodSignature:signature];
            temp.selector                = seekToTime;
            temp.target                  = playerController;
            temp;
        });
        
        NSInteger currentTimeInSeconds = [self __currentTimeInSeconds];
        double forward10Seconds        = currentTimeInSeconds + 10.0;
        
        [invocation setArgument:&forward10Seconds atIndex:2];
        [invocation invoke];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

- (NSInteger)__currentTimeInSeconds
{
    // 取回目前播放時間.
    // 嘗試幾種方式取回, 最後只能利用控制面板的播放進度 UILabel 取回.
    
    NSInteger currentTimeInSeconds = 0;
    
    @try {
        id controller             = [self valueForKey:@"playbackControlsViewController"];
        UILabel *currentTimeLabel = [controller valueForKey:@"elapsedTimeLabel"];
        NSString *timeString      = currentTimeLabel.text;
        NSArray *times            = [timeString componentsSeparatedByString:@":"];
        
        for (int i = 0; i != times.count; i++) {
            currentTimeInSeconds = 60 * currentTimeInSeconds + [times[i]integerValue];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    
    return currentTimeInSeconds;
}

@end
