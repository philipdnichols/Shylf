//
//  MyMovieCell+Configure.m
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MyMovieCell+Configure.h"
#import "MyMovie.h"
#import "TheMovieDBClient.h"
#import "UIImageView+AFNetworking.h"

@implementation MyMovieCell (Configure)

- (void)configureForMyMovie:(MyMovie *)movie
{
    self.titleLabel.text = movie.title;
    self.taglineLabel.text = movie.tagline;
    
    // TODO: this should be saved into memory and retrieved that way
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
