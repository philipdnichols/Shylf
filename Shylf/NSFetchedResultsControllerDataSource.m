//
//  NSFetchedResultsControllerDataSource.m
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "NSFetchedResultsControllerDataSource.h"

@interface NSFetchedResultsControllerDataSource ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSString *cellIdentifier;
@property (nonatomic, copy) FetchedResultsCellConfigureBlock configureCellBlock;
@property (nonatomic, copy) FetchedResultsCellDeleteBlock deleteCellBlock;

@property (nonatomic) BOOL allowsDeletion;

@end

@implementation NSFetchedResultsControllerDataSource

#pragma mark - Initializers

- (id)init
{
    NSAssert(NO, @"'init' is not allowed for the NSFetchedResultsDataSource. Please use another initializer, such as 'initWithFetchedResultsController:cellIdentifier:configureCellBlock");
    return nil;
}

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                                  cellIdentifier:(NSString *)cellIdentifier
                              configureCellBlock:(FetchedResultsCellConfigureBlock)configureCellBlock
{
    self = [super init];
    if (self) {
        self.fetchedResultsController = fetchedResultsController;
        self.cellIdentifier = cellIdentifier;
        self.configureCellBlock = configureCellBlock;
        self.allowsDeletion = NO;
        self.deleteCellBlock = nil;
    }
    return self;
}

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                                  cellIdentifier:(NSString *)cellIdentifier
                              configureCellBlock:(FetchedResultsCellConfigureBlock)configureCellBlock
                                 deleteCellBlock:(FetchedResultsCellDeleteBlock)deleteCellBlock
{
    self = [self initWithFetchedResultsController:fetchedResultsController
                                   cellIdentifier:cellIdentifier
                               configureCellBlock:configureCellBlock];
    if (self) {
        self.allowsDeletion = YES;
        self.deleteCellBlock = deleteCellBlock;
    }
    return self;
}

#pragma mark - Public

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self.fetchedResultsController sections] count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        rows = [sectionInfo numberOfObjects];
    }
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.fetchedResultsController sectionIndexTitles];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allowsDeletion) {
        return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.allowsDeletion) {
            id item = [self itemAtIndexPath:indexPath];
            self.deleteCellBlock(item);
        }
    }
}

@end
