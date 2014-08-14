//
//  MovieSearchDetailViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MovieSearchDetailViewController.h"
#import "TheMovieDBClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieSearchDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end

@implementation MovieSearchDetailViewController

#pragma mark - Properties

- (void)setMovie:(TMDBMovie *)movie
{
    _movie = movie;
    if (self.view.window) {
        [self updateUI];
    }
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateUI];
}

- (void)updateUI
{
    self.titleLabel.text = self.movie.title;
    [self.posterImageView setImageWithURL:[[TheMovieDBClient sharedClient] posterURLForPosterPath:self.movie.posterPath]];
}

@end
