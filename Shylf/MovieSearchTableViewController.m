//
//  MovieSearchTableViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MovieSearchTableViewController.h"
#import "TheMovieDBAPI.h"

@interface MovieSearchTableViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *movies;

@end

@implementation MovieSearchTableViewController

#pragma mark - Properties

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
    [TheMovieDBAPI searchMoviesFromQuery:self.query
                       completionHandler:^(NSArray *searchMovies, NSError *error) {
                           if (!error) {
                               self.movies = searchMovies;
                           } else {
                               DDLogError(@"Error searching movies with query \"%@\": %@", self.query, error.localizedDescription);
                           }
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
    
    NSDictionary *movieSearch = self.movies[indexPath.row];
    cell.textLabel.text = movieSearch[@"original_title"];
    cell.detailTextLabel.text = movieSearch[@"release_date"];
    
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
