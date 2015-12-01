// DRBookmarksViewController.m
// 
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/22.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "DRBookmarksViewController.h"


@implementation DRBookmarksViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bookmarks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *bookmark    = _bookmarks[indexPath.row];
    cell.textLabel.text       = bookmark[@"title"];
    cell.detailTextLabel.text = bookmark[@"url"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_bookmarks removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:_bookmarks forKey:@"bookmarks"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *bookmark = _bookmarks[indexPath.row];
    
    [_delegate mvc:self selectedBookmark:bookmark];
}

@end
