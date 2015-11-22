// DRBookmarksViewController.m
// 
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/22.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "DRBookmarksViewController.h"

@interface DRBookmarksViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end


@implementation DRBookmarksViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setup];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *bookmark    = _dataSource[indexPath.row];
    cell.textLabel.text       = bookmark[@"title"];
    cell.detailTextLabel.text = bookmark[@"url"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataSource removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:_dataSource forKey:@"bookmarks"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *bookmark = _dataSource[indexPath.row];
    
    [_delegate mvc:self selectedBookmark:bookmark];
}

#pragma mark - Private
- (void)__setup
{
    NSArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"bookmarks"];
    _dataSource   = [temp mutableCopy];
    
    if(!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
}

@end
