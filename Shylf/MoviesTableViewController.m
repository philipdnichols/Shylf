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
#import "MyMovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesTableViewController () <UIActionSheetDelegate>

@property (strong, nonatomic) UIActionSheet *addMovieActionSheet;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation MoviesTableViewController

#pragma mark - Properties

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

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        // TODO: Should I be creating a local variable first?
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return _dateFormatter;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: Better place to put this?
    [self.tableView registerNib:[MyMovieCell nib] forCellReuseIdentifier:[MyMovieCell identifier]];
    
    [self setupFetchedResultsController];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)setupFetchedResultsController
{
    self.fetchedResultsController = [MyMovie MR_fetchAllSortedBy:@"title"
                                                       ascending:YES
                                                   withPredicate:nil
                                                         groupBy:nil
                                                        delegate:self];
}

#pragma mark - IBActions

- (IBAction)addMovie {
    [self.addMovieActionSheet showInView:self.view];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyMovieCell identifier]
                                                        forIndexPath:indexPath];
    
    MyMovie *myMovie = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.titleLabel.text = myMovie.title;
    cell.taglineLabel.text = myMovie.tagline;
    
    NSURL *posterThumbnailURL = [[TheMovieDBClient sharedClient] posterThumbnailURLForPosterPath:myMovie.posterPath];
    if (posterThumbnailURL) {
        __weak MyMovieCell *weakCell = cell;
        [cell.posterImageView setImageWithURLRequest:[NSURLRequest requestWithURL:posterThumbnailURL]
                                    placeholderImage:[UIImage imageNamed:@"movies"]
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                 weakCell.posterImageView.image = image;
                                                 [weakCell setNeedsLayout];
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                 DDLogError(@"Error downloading image from %@: %@", [[request URL] absoluteString], [error localizedDescription]);
                                             }];
    } else {
        cell.posterImageView.image = nil;
    }
    
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
