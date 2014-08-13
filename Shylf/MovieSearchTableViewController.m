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
#import "MovieSearchCell.h"
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
        // TODO: Should I be creating a local variable first?
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
    
    // TODO: Better place to put this?
    [self.tableView registerNib:[MovieSearchCell nib] forCellReuseIdentifier:[MovieSearchCell identifier]];
    
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
    MovieSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:[MovieSearchCell identifier]
                                                            forIndexPath:indexPath];
    
    TMDBMovie *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie.title;
    cell.releaseDateLabel.text = [self.dateFormatter stringFromDate:movie.releaseDate];
    
    NSURL *posterThumbnailURL = [[TheMovieDBClient sharedClient] posterThumbnailURLForMovie:movie];
    if (posterThumbnailURL) {
        __weak MovieSearchCell *weakCell = cell;
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
    
    [[[UIAlertView alloc] initWithTitle:@"Add Movie"
                                message:[NSString stringWithFormat:@"Add %@ to Movie Collection?", movie.title]
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"Yes", nil] show];
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
    
    if ([buttonTitle isEqualToString:@"Yes"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TMDBMovie *movie = self.movies[indexPath.row];
        
        MyMovie *myMovie = [MyMovie MR_createEntity];
        myMovie.title = movie.title;
        myMovie.overview = movie.overview;
        myMovie.releaseDate = movie.releaseDate;
        myMovie.rating = movie.voteAverage;
        myMovie.tagline = movie.tagline;
        myMovie.thumbnailURL = [[[TheMovieDBClient sharedClient] posterThumbnailURLForMovie:movie] absoluteString];
        myMovie.runtime = movie.runtime;
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if (!error) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                // TODO:
            }
        }];
        
        
    }
}

@end
