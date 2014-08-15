//
//  NSFetchedResultsTableViewController.h
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSFetchedResultsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchRequest *fetchedRequest;
@property (strong, nonatomic) NSString *fetchedGroupKeyPath;

- (NSManagedObject *)managedObjectAtIndexPath:(NSIndexPath *)indexPath;

@end
