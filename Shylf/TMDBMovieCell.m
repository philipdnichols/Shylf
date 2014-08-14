//
//  MovieSearchCell.m
//  Shylf
//
//  Created by Philip Nichols on 8/12/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBMovieCell.h"

@implementation TMDBMovieCell

+ (NSString *)identifier
{
    return @"TMDBMovie Cell";
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"TMDBMovieCell" bundle:nil];
}

@end
