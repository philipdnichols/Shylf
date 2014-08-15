//
//  MyMovieCell+Configure.h
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MyMovieCell.h"

@class MyMovie;

@interface MyMovieCell (Configure)

- (void)configureForMyMovie:(MyMovie *)movie;

@end
