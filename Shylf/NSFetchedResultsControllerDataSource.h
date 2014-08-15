//
//  NSFetchedResultsControllerDataSource.h
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FetchedResultsCellConfigureBlock)(id cell, id item);
typedef void (^FetchedResultsCellDeleteBlock)(id item);

@interface NSFetchedResultsControllerDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                                  cellIdentifier:(NSString *)cellIdentifier
                              configureCellBlock:(FetchedResultsCellConfigureBlock)configureCellBlock;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                                  cellIdentifier:(NSString *)cellIdentifier
                              configureCellBlock:(FetchedResultsCellConfigureBlock)configureCellBlock
                                 deleteCellBlock:(FetchedResultsCellDeleteBlock)deleteCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
