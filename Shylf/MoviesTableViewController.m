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
#import "UPCDatabaseAPI.h"
#import "TheMovieDBAPI.h"

@interface MoviesTableViewController () <UIActionSheetDelegate>

@property (strong, nonatomic) UIActionSheet *addMovieActionSheet;

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
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

static NSString *MovieCellIdentifier = @"Movie Cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MovieCellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
            
            [UPCDatabaseAPI itemForUPC:code.stringValue
                     completionHandler:^(UPCDBItem *item, NSError *error) {
                         if (!error) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 NSString *query = [item.itemName length] ? item.itemName : item.descriptionOfItem;
                                 [self performSegueWithIdentifier:SearchMoviesSegueIdentifier sender:query];
                             });
                         } else {
                             DDLogError(@"Error retrieving UPC description for UPC %@: %@", code.stringValue, error.localizedDescription);
                         }
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
