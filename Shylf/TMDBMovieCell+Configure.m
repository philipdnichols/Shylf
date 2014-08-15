//
//  TMDBMovieCell+Configure.m
//  Shylf
//
//  Created by Philip Nichols on 8/14/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBMovieCell+Configure.h"
#import "TMDBMovie.h"
#import "TheMovieDBClient.h"
#import "UIImageView+AFNetworking.h"

@implementation TMDBMovieCell (Configure)

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return dateFormatter;
}

- (void)configureForTMDBMovie:(TMDBMovie *)movie
{
    self.titleLabel.text = movie.title;
    self.releaseDateLabel.text = [self.dateFormatter stringFromDate:movie.releaseDate];
    
    NSURL *posterThumbnailURL = [[TheMovieDBClient sharedClient] posterThumbnailURLForPosterPath:movie.posterPath];
    if (posterThumbnailURL) {
        [self.posterImageView setImageWithURLRequest:[NSURLRequest requestWithURL:posterThumbnailURL]
                                    placeholderImage:[UIImage imageNamed:@"movies"]
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                 self.posterImageView.image = image;
                                                 [self setNeedsLayout];
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                 DDLogError(@"Error downloading image from %@: %@", [[request URL] absoluteString], [error localizedDescription]);
                                             }];
    } else {
        self.posterImageView.image = nil;
    }
}

@end
