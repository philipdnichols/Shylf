//
//  BookTableViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "BookTableViewController.h"
#import "MyBookCell.h"
#import "MyBook.h"

@interface BookTableViewController ()

@property (strong, nonatomic) NSFetchRequest *request;
@property (strong, nonatomic) NSString *groupKeyPath;

@end

@implementation BookTableViewController

#pragma mark - Properties

@synthesize request = _request;
@synthesize groupKeyPath = _groupKeyPath;

- (NSFetchRequest *)fetchedRequest
{
    return self.request;
}

- (NSString *)fetchedGroupKeyPath
{
    return self.groupKeyPath;
}

- (NSFetchRequest *)request
{
    if (!_request) {
        _request = [MyBook MR_requestAllSortedBy:@"title"
                                       ascending:YES];
    }
    return _request;
}

- (NSString *)groupKeyPath
{
    //    if (!_groupKeyPath) {
    //
    //    }
    return _groupKeyPath;
}

- (void)setRequest:(NSFetchRequest *)request
{
    _request = request;
    self.fetchedRequest = _request;
}

- (void)setGroupKeyPath:(NSString *)groupKeyPath
{
    _groupKeyPath = groupKeyPath;
    self.fetchedGroupKeyPath = _groupKeyPath;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[MyBookCell nib] forCellReuseIdentifier:[MyBookCell identifier]];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyBookCell identifier]
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
