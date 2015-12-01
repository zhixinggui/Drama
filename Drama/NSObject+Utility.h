// NSObject+Utility.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <Foundation/Foundation.h>

/**
 *  小工具.
 */
@interface NSObject (Utility)


///-----------------------------------------------------------------------------
/// @name Category methods.
///-----------------------------------------------------------------------------

/**
 *  將 NSArray 轉換成 JSON String.
 *
 *  @param array 要轉換的 NSarray.
 *
 *  @return 轉換完的 JSON String.
 */
+ (NSString *)utility_jsonStringFromNSArray:(NSArray *)array;

@end
