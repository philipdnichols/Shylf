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
#import "TMDBGenre.h"
#import "NSFetchedResultsControllerDataSource.h"
#import "MyMovieCell+Configure.h"
#import "AddMovieForm.h"
#import "AddMovieFormViewController.h"

@interface MoviesTableViewController () <UIActionSheetDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIActionSheet *addMovieActionSheet;
@property (strong, nonatomic) UIActionSheet *filterMovieGenresActionSheet;

@property (strong, nonatomic) UIAlertView *deleteMovieAlertView;

@property (strong, nonatomic) UIBarButtonItem *addMovieBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem *filterMovieGenresBarButtonItem;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) NSFetchRequest *request;
@property (strong, nonatomic) NSString *groupKeyPath;

@property (weak, nonatomic) MyMovie *movieToDelete;

@property (nonatomic, copy) FetchedResultsCellConfigureBlock movieCellConfigureBlock;
@property (nonatomic, copy) FetchedResultsCellDeleteBlock movieCellDeleteBlock;

@end

@implementation MoviesTableViewController

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
        _request = [MyMovie MR_requestAllSortedBy:@"title"
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

- (UIAlertView *)deleteMovieAlertView
{
    if (!_deleteMovieAlertView) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete Movie"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Yes", nil];
        _deleteMovieAlertView = alertView;
    }
    return _deleteMovieAlertView;
}

- (UIActionSheet *)addMovieActionSheet
{
    if (!_addMovieActionSheet) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Movie"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Add", @"Search", @"Scan Barcode", nil];
        _addMovieActionSheet = actionSheet;
    }
    return _addMovieActionSheet;
}

- (UIActionSheet *)filterMovieGenresActionSheet
{
    if (!_filterMovieGenresActionSheet) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Filter Genres"
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];
        
        NSArray *genres = [TheMovieDBClient sharedClient].genres;
        for (TMDBGenre *genre in genres) {
            [actionSheet addButtonWithTitle:genre.name];
        }
        [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
        _filterMovieGenresActionSheet = actionSheet;
    }
    return _filterMovieGenresActionSheet;
}

- (UIBarButtonItem *)addMovieBarButtonItem
{
    if (!_addMovieBarButtonItem) {
        _addMovieBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addMovie:)];
    }
    return _addMovieBarButtonItem;
}

- (UIBarButtonItem *)filterMovieGenresBarButtonItem
{
    if (!_filterMovieGenresBarButtonItem) {
        _filterMovieGenresBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(filterMovies:)];
    }
    return _filterMovieGenresBarButtonItem;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return _dateFormatter;
}

- (NSString *)cellIdentifier
{
    return [MyMovieCell identifier];
}

- (FetchedResultsCellConfigureBlock)fetchedResultsConfigureBlock
{
    return self.movieCellConfigureBlock;
}

- (FetchedResultsCellDeleteBlock)fetchedResultsDeleteBlock
{
    return self.movieCellDeleteBlock;
}

- (FetchedResultsCellConfigureBlock)movieCellConfigureBlock
{
    if (!_movieCellConfigureBlock) {
        _movieCellConfigureBlock = ^(MyMovieCell *movieCell, MyMovie *movie) {
            [movieCell configureForMyMovie:movie];
        };
    }
    return _movieCellConfigureBlock;
}

- (FetchedResultsCellDeleteBlock)movieCellDeleteBlock
{
    if (!_movieCellDeleteBlock) {
        __weak MoviesTableViewController *weakSelf = self;
        _movieCellDeleteBlock = ^(MyMovie *movie) {
            weakSelf.movieToDelete = movie;
            
            [weakSelf.deleteMovieAlertView setMessage:[NSString stringWithFormat:@"Are you sure you want to remove \"%@\" from your collection?", weakSelf.movieToDelete.title]];
            
            [weakSelf.deleteMovieAlertView show];
        };
    }
    return _movieCellDeleteBlock;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    
    self.navigationItem.rightBarButtonItems = @[self.addMovieBarButtonItem, self.filterMovieGenresBarButtonItem];
}

- (void)setupTableView
{
    [self.tableView registerNib:[MyMovieCell nib] forCellReuseIdentifier:[MyMovieCell identifier]];
}

#pragma mark - IBActions

- (IBAction)addMovie:(UIBarButtonItem *)sender {
    [self.addMovieActionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)filterMovies:(UIBarButtonItem *)sender {
    [self.filterMovieGenresActionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - Navigation

static NSString * const ScanMovieBarcodeSegueIdentifier = @"Scan Movie Barcode";
static NSString * const SearchMoviesSegueIdentifier = @"Search Movies";
static NSString * const AddMovieSegueIdentifier = @"Add Movie";

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self prepareViewController:segue.destinationViewController
                       forSegue:segue.identifier
                     fromSender:sender];
}

- (void)prepareViewController:(id)viewController forSegue:(NSString *)segueIdentifier fromSender:(id)sender
{
    NSIndexPath *indexPath = nil;
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *uiNavigationController = (UINavigationController *)viewController;
        UIViewController *firstVC = [uiNavigationController.viewControllers firstObject];
        if ([firstVC isKindOfClass:[BarcodeScanViewController class]]) {
            if (![segueIdentifier length] || [segueIdentifier isEqualToString:ScanMovieBarcodeSegueIdentifier]) {
                // No setup to do right now, maybe later.
            }
        } else if ([firstVC isKindOfClass:[AddMovieFormViewController class]]) {
            if (![segueIdentifier length] || [segueIdentifier isEqualToString:AddMovieSegueIdentifier]) {
                // TODO: Setup
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

#pragma mark - Unwinding

- (IBAction)scannedCode:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:BarcodeScannedSegueIdentifier]) {
        if ([segue.sourceViewController isKindOfClass:[BarcodeScanViewController class]]) {
            BarcodeScanViewController *barcodeScanViewController = (BarcodeScanViewController *)segue.sourceViewController;
            AVMetadataMachineReadableCodeObject *code = barcodeScanViewController.code;
            
            [SVProgressHUD showWithStatus:@"Processing" maskType:SVProgressHUDMaskTypeGradient];
            [[UPCDatabaseClient sharedClient]
                 itemForUPC:code.stringValue
                    success:^(UPCDBItem *item) {
                        [SVProgressHUD dismiss];
                        NSString *query = [item.itemName length] ? item.itemName : item.descriptionOfItem;
                        [self performSegueWithIdentifier:SearchMoviesSegueIdentifier sender:query];
                    }
                    failure:^(NSError *error) {
                        DDLogError(@"There was an error retrieving the UPC description for UPC %@: %@", code.stringValue, [error localizedDescription]);
                    }];
        }
    }
}

- (IBAction)addedMovie:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:MovieAddedSegueIdentifier]) {
        if ([segue.sourceViewController isKindOfClass:[AddMovieFormViewController class]]) {
            AddMovieFormViewController *addMovieFormViewController = (AddMovieFormViewController *)segue.sourceViewController;
            
            MyMovie *addedMovie = addMovieFormViewController.addedMovie;
            [addedMovie saveWithSuccess:^{
                // TODO: Use MBProgress hud to flash up a checkmark?, Possible with SVProgressHUD?
                [SVProgressHUD dismiss];
            } failure:^(NSError *error) {
                DDLogError(@"There was an error adding a new movie: %@", [error localizedDescription]);
            }];
        }
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (actionSheet == self.addMovieActionSheet) {
        if ([buttonTitle isEqualToString:@"Search"]) {
            [self performSegueWithIdentifier:SearchMoviesSegueIdentifier sender:self];
        } else if ([buttonTitle isEqualToString:@"Scan Barcode"]) {
            [self performSegueWithIdentifier:ScanMovieBarcodeSegueIdentifier sender:self];
        } else if ([buttonTitle isEqualToString:@"Add"]) {
            [self performSegueWithIdentifier:AddMovieSegueIdentifier sender:self];
        }
    } else if (actionSheet == self.filterMovieGenresActionSheet) {
        // TODO: Better interface
        // TODO: Icons for the genres
        if (![buttonTitle isEqualToString:@"Cancel"]) {
            self.request = [MyMovie fetchAllWithGenre:buttonTitle];
        }
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    
    if (alertView == self.deleteMovieAlertView) {
        if ([buttonTitle isEqualToString:@"Yes"]) {
            [SVProgressHUD showWithStatus:@"Deleting from Collection..." maskType:SVProgressHUDMaskTypeGradient];
            [self.movieToDelete deleteWithSuccess:^{
                [SVProgressHUD dismiss];
            } failure:^(NSError *error) {
                DDLogError(@"There was an error deleting the movie: %@", [error localizedDescription]);
            }];
        } else if ([buttonTitle isEqualToString:@"Cancel"]) {
            [self.tableView setEditing:NO animated:YES];
        }
        
        self.movieToDelete = nil;
        self.deleteMovieAlertView = nil;
    }
}

@end
