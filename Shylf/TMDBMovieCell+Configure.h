//
//  TMDBMovieCell+Configure.h
//  Shylf
//
//  Created by Philip Nichols on 8/14/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBMovieCell.h"

@class TMDBMovie;

@interface TMDBMovieCell (Configure)

- (void)configureForTMDBMovie:(TMDBMovie *)movie;

@end
