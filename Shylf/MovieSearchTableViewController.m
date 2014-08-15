//
//  MovieSearchTableViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MovieSearchTableViewController.h"
#import "TheMovieDBClient.h"
#import "ArrayDataSource.h"
#import "TMDBMovieCell+Configure.h"
#import "TMDBMovie+CoreData.h"
#import "MovieSearchDetailViewController.h"

@interface MovieSearchTableViewController () <UISearchBarDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) ArrayDataSource *moviesArrayDataSource;
@property (nonatomic, copy) TableViewCellConfigureBlock movieCellConfigureBlock;

@end

@implementation MovieSearchTableViewController

#pragma mark - Properties

- (void)setMoviesArrayDataSource:(ArrayDataSource *)moviesArrayDataSource
{
    _moviesArrayDataSource = moviesArrayDataSource;
    
    self.tableView.dataSource = _moviesArrayDataSource;
    [self.tableView reloadData];
}

- (TableViewCellConfigureBlock)movieCellConfigureBlock
{
    if (!_movieCellConfigureBlock) {
        _movieCellConfigureBlock = ^(TMDBMovieCell *movieCell, TMDBMovie *movie) {
            [movieCell configureForTMDBMovie:movie];
        };
    }
    return _movieCellConfigureBlock;
}

- (void)setQuery:(NSString *)query
{
    _query = query;
    
    if (self.view.window) {
        [self updateUI];
    }
    
    [self searchMovies];
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self updateUI];
}

- (void)updateUI
{
    self.searchBar.text = self.query;
}

- (void)setupTableView
{
    [self.tableView registerNib:[TMDBMovieCell nib] forCellReuseIdentifier:[TMDBMovieCell identifier]];
}

- (void)searchMovies
{
    [[TheMovieDBClient sharedClient] searchMoviesFromQuery:self.query
           fullResults:YES
               success:^(NSArray *results) {
                   self.moviesArrayDataSource = [[ArrayDataSource alloc] initWithItems:results
                                                                        cellIdentifier:[TMDBMovieCell identifier]
                                                                    configureCellBlock:self.movieCellConfigureBlock];
               }
               failure:^(NSError *error) {
                   DDLogError(@"Error searching movies with query \"%@\": %@", self.query, [error localizedDescription]);
               }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMDBMovie *movie = [self.moviesArrayDataSource itemAtIndexPath:indexPath];
    
    // TODO: String contants for the alert stuff, even the uiactionsheets
    [[[UIAlertView alloc] initWithTitle:@"Add Movie"
                                message:[NSString stringWithFormat:@"Add \"%@\" to Movie Collection?", movie.title]
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"Add", @"Add and Continue", nil] show];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:SearchMovieDetailsSegueIdentifier sender:cell];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.moviesArrayDataSource = nil;
    self.query = searchBar.text;
    [searchBar resignFirstResponder];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Add"] || [buttonTitle isEqualToString:@"Add and Continue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TMDBMovie *movie = [self.moviesArrayDataSource itemAtIndexPath:indexPath];
        
        NSError *error = nil;
        [MTLManagedObjectAdapter managedObjectFromModel:movie
                                   insertingIntoContext:[NSManagedObjectContext MR_defaultContext]
                                                  error:&error];
        
        // TODO: I think this creates unique genre objects...maybe? This could be improved but isn't a huge deal.
        
        if (!error) {
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                if (!error) {
                    if (![buttonTitle isEqualToString:@"Add and Continue"]) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                } else {
                    DDLogError(@"There was a problem saving the context after inserting movie: %@", [error localizedDescription]);
                }
            }];
        } else {
            DDLogError(@"Error mapping movie to managed object: %@", [error localizedDescription]);
        }
    } else if ([buttonTitle isEqualToString:@"Cancel"]) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
}

#pragma mark - Navigation

static NSString * const SearchMovieDetailsSegueIdentifier = @"Search Movie Details";

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
    
    if ([viewController isKindOfClass:[MovieSearchDetailViewController class]]) {
        if (![segueIdentifier length] || [segueIdentifier isEqualToString:SearchMovieDetailsSegueIdentifier]) {
            if (indexPath) {
                MovieSearchDetailViewController *movieSearchDetailViewController = (MovieSearchDetailViewController *)viewController;
                movieSearchDetailViewController.movie = [self.moviesArrayDataSource itemAtIndexPath:indexPath];
            }
        }
    }
}

@end
