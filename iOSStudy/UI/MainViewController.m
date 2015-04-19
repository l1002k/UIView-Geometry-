//
//  MainViewController.m
//  iOSStudy
//
//  Created by leikun on 15-4-16.
//  Copyright (c) 2015年 leikun. All rights reserved.
//

#import "MainViewController.h"
#import "ViewGemetryViewController.h"

@interface MainViewController ()
{
    NSMutableArray *_data;
    
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
    [self initData];
}

- (void)initSubviews {
    self.title = @"Main";
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)initData {
    _data = [NSMutableArray arrayWithObject:@"UIView Geometry"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *dataString = _data[indexPath.row];
    UIViewController *pushedVC = nil;
    if ([dataString isEqualToString:@"UIView Geometry"]) {
        ViewGemetryViewController *vc = [ViewGemetryViewController new];
        pushedVC = vc;
    }
    pushedVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushedVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MainTableViewCellIdentify = @"MainTableViewCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainTableViewCellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MainTableViewCellIdentify];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

@end
