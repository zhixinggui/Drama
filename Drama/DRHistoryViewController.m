// DRHistoryViewController.m
// 
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/22.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <WebKit/WebKit.h>
#import "DRHistoryViewController.h"


@implementation DRHistoryViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell       = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    WKBackForwardListItem *item = _dataSource[indexPath.row];
    cell.textLabel.text         = item.title.length ? item.title : @"No Title";
    cell.detailTextLabel.text   = item.URL.absoluteString;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKBackForwardListItem *item = _dataSource[indexPath.row];
    
    [_delegate mvc:self selectedHistory:item];
}

@end
