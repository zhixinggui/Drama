// NSObject+Utility.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "NSObject+Utility.h"


@implementation NSObject (Utility)

+ (NSString *)utility_jsonStringFromNSArray:(NSArray *)array
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    if(!data)
    {
        return nil;
    }
    
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
