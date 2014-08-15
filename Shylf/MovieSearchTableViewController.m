//
//  MovieSearchTableViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MovieSearchTableViewController.h"
#import "TheMovieDBClient.h"
#import "TMDBMovie.h"
#import "UIImageView+AFNetworking.h"
#import "TMDBMovieCell.h"
#import "TMDBMovie+CoreData.h"
#import "MovieSearchDetailViewController.h"
#import "MyMovie.h"

@interface MovieSearchTableViewController () <UISearchBarDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *movies;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation MovieSearchTableViewController

#pragma mark - Properties

@synthesize movies = _movies;

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return _dateFormatter;
}

- (void)setQuery:(NSString *)query
{
    _query = query;
    
    if (self.view.window) {
        [self updateUI];
    }
    
    [self searchMovies];
}

- (NSMutableArray *)movies
{
    if (!_movies) {
        _movies = [NSMutableArray array];
    }
    return _movies;
}

- (void)setMovies:(NSMutableArray *)movies
{
    _movies = movies;
    [self.tableView reloadData];
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[TMDBMovieCell nib] forCellReuseIdentifier:[TMDBMovieCell identifier]];
    
    [self updateUI];
}

- (void)updateUI
{
    self.searchBar.text = self.query;
}

- (void)searchMovies
{
    [[TheMovieDBClient sharedClient] searchMoviesFromQuery:self.query
           fullResults:YES
               success:^(NSArray *results) {
                   self.movies = [results mutableCopy];
               }
               failure:^(NSError *error) {
                   DDLogError(@"Error searching movies with query \"%@\": %@", self.query, [error localizedDescription]);
               }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMDBMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:[TMDBMovieCell identifier]
                                                            forIndexPath:indexPath];
    
    TMDBMovie *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie.title;
    cell.releaseDateLabel.text = [self.dateFormatter stringFromDate:movie.releaseDate];
    
    NSURL *posterThumbnailURL = [[TheMovieDBClient sharedClient] posterThumbnailURLForPosterPath:movie.posterPath];
    if (posterThumbnailURL) {
        __weak TMDBMovieCell *weakCell = cell;
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMDBMovie *movie = self.movies[indexPath.row];
    
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
    self.movies = nil;
    self.query = searchBar.text;
    [searchBar resignFirstResponder];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Add"] || [buttonTitle isEqualToString:@"Add and Continue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TMDBMovie *movie = self.movies[indexPath.row];
        
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
                movieSearchDetailViewController.movie = self.movies[indexPath.row];
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

@end
