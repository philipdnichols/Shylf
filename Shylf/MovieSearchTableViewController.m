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

@interface MovieSearchTableViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *movies;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation MovieSearchTableViewController

#pragma mark - Properties

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

- (void)setMovies:(NSArray *)movies
{
    _movies = movies;
    [self.tableView reloadData];
}

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateUI];
}

- (void)updateUI
{
    self.searchBar.text = self.query;
}

- (void)searchMovies
{
    [[TheMovieDBClient sharedClient]
     searchMoviesFromQuery:self.query
                   success:^(NSArray *results) {
                       self.movies = results;
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

static NSString *MovieSearchCellIdentifier = @"Movie Search Cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MovieSearchCellIdentifier
                                                            forIndexPath:indexPath];
    
    TMDBMovie *movie = self.movies[indexPath.row];
    cell.textLabel.text = movie.title;
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:movie.releaseDate];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.query = searchBar.text;
    [searchBar resignFirstResponder];
}

@end
