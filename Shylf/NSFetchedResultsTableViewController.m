//
//  NSFetchedResultsTableViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "NSFetchedResultsTableViewController.h"

@interface NSFetchedResultsTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic, readwrite) NSFetchedResultsControllerDataSource *fetchedResultsControllerDataSource;

@end

@implementation NSFetchedResultsTableViewController

#pragma mark - Properties

- (void)setFetchedRequest:(NSFetchRequest *)fetchedRequest
{
    _fetchedRequest = fetchedRequest;
    self.fetchedResultsController = nil;
    
    [self reloadFetchedResultsController];
}

- (void)setFetchedGroupKeyPath:(NSString *)fetchedGroupKeyPath
{
    _fetchedGroupKeyPath = fetchedGroupKeyPath;
    self.fetchedResultsController = nil;
    
    [self reloadFetchedResultsController];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {

        _fetchedResultsController = [[NSManagedObject class] MR_fetchController:self.fetchedRequest
                                                                       delegate:self
                                                                   useFileCache:NO
                                                                      groupedBy:self.fetchedGroupKeyPath
                                                                      inContext:[NSManagedObjectContext MR_defaultContext]];
        
        self.fetchedResultsControllerDataSource = [[NSFetchedResultsControllerDataSource alloc]
                                                   initWithFetchedResultsController:_fetchedResultsController
                                                   cellIdentifier:self.cellIdentifier
                                                   configureCellBlock:self.fetchedResultsConfigureBlock
                                                   deleteCellBlock:self.fetchedResultsDeleteBlock];
        self.tableView.dataSource = self.fetchedResultsControllerDataSource;
        
        [self reloadFetchedResultsController];
    }
    return _fetchedResultsController;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reloadFetchedResultsController];
}

#pragma mark - Private

- (void)reloadFetchedResultsController
{
    [[NSManagedObject class] MR_performFetch:self.fetchedResultsController];
    [self.tableView reloadData];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            // hide cell, because animations are broken on ios7
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//                [self.tableView cellForRowAtIndexPath:indexPath].alpha = 0.0;
//            }
            
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
