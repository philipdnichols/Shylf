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
    self.posterImageView.image = [UIImage imageWithContentsOfFile:movie.thumbnailFileURL];
}

@end
