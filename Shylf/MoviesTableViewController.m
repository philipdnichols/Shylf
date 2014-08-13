//
//  MoviesTableViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "MovieSearchTableViewController.h"
#import "BarcodeScanViewController.h"
#import "UPCDatabaseClient.h"
#import "TheMovieDBClient.h"
#import "MyMovie.h"

@interface MoviesTableViewController () <UIActionSheetDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) UIActionSheet *addMovieActionSheet;

@end

@implementation MoviesTableViewController

#pragma mark - Properties

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [MyMovie MR_fetchAllSortedBy:@"title"
                                                       ascending:YES
                                                   withPredicate:nil
                                                         groupBy:nil
                                                        delegate:self];
    }
    return _fetchedResultsController;
}

- (UIActionSheet *)addMovieActionSheet
{
    if (!_addMovieActionSheet) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Movie"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Search", @"Scan Barcode", nil];
        _addMovieActionSheet = actionSheet;
    }
    return _addMovieActionSheet;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

#pragma mark - IBActions

- (IBAction)addMovie {
    [self.addMovieActionSheet showInView:self.view];
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

static NSString *MovieCellIdentifier = @"Movie Cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MovieCellIdentifier
                                                            forIndexPath:indexPath];
    
    MyMovie *myMovie = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = myMovie.title;
    cell.detailTextLabel.text = myMovie.tagline;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MyMovie *myMovie = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [myMovie MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if (!error) {
                
            } else {
                // TODO:
            }
        }];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

#pragma mark - Navigation

static NSString *ScanMovieBarcodeSegueIdentifier = @"Scan Movie Barcode";
static NSString *SearchMoviesSegueIdentifier = @"Search Movies";

- (void)prepareViewController:(id)viewController forSegue:(NSString *)segueIdentifier fromSender:(id)sender
{
    NSIndexPath *indexPath = nil;
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *uiNavigationController = (UINavigationController *)viewController;
        if ([[uiNavigationController.viewControllers firstObject] isKindOfClass:[BarcodeScanViewController class]]) {
            if (![segueIdentifier length] || [segueIdentifier isEqualToString:ScanMovieBarcodeSegueIdentifier]) {
//                BarcodeScanViewController *barcodeScanViewController = (BarcodeScanViewController *)[uiNavigationController.viewControllers firstObject];
                // No setup to do right now, maybe later.
            }
        }
    } else if ([viewController isKindOfClass:[MovieSearchTableViewController class]]) {
        if (![segueIdentifier length] || [segueIdentifier isEqualToString:SearchMoviesSegueIdentifier]) {
            MovieSearchTableViewController *mstvc = (MovieSearchTableViewController *)viewController;
            
            // Barcode search prep:
            if ([sender isKindOfClass:[NSString class]]) {
                mstvc.query = sender;
            }
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self prepareViewController:segue.destinationViewController
                       forSegue:segue.identifier
                     fromSender:sender];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    id detailViewController = [self.splitViewController.viewControllers lastObject];
//    if ([detailViewController isKindOfClass:[UINavigationController class]]) {
//        detailViewController = [((UINavigationController *)detailViewController).viewControllers firstObject];
//        [self prepareViewController:detailViewController
//                           forSegue:nil
//                      fromIndexPath:indexPath];
//    }
//}

#pragma mark - Unwinding

static NSString *BarcodeScannedSegueIdentifier = @"Barcode Scanned";

- (IBAction)scannedCode:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:BarcodeScannedSegueIdentifier]) {
        if ([segue.sourceViewController isKindOfClass:[BarcodeScanViewController class]]) {
            BarcodeScanViewController *barcodeScanViewController = (BarcodeScanViewController *)segue.sourceViewController;
            AVMetadataMachineReadableCodeObject *code = barcodeScanViewController.code;
            
            [[UPCDatabaseClient sharedClient]
             itemForUPC:code.stringValue
                success:^(UPCDBItem *item) {
                    NSString *query = [item.itemName length] ? item.itemName : item.descriptionOfItem;
                    [self performSegueWithIdentifier:SearchMoviesSegueIdentifier sender:query];
                }
                failure:^(NSError *error) {
                    DDLogError(@"Error retrieving UPC description for UPC %@: %@", code.stringValue, error.localizedDescription);
                }];
        }
    }
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Search"]) {
        [self performSegueWithIdentifier:SearchMoviesSegueIdentifier sender:self];
    } else if ([buttonTitle isEqualToString:@"Scan Barcode"]) {
        [self performSegueWithIdentifier:ScanMovieBarcodeSegueIdentifier sender:self];
    }
}

@end
