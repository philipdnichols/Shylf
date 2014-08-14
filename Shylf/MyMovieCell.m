//
//  MyMovieCell.m
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MyMovieCell.h"

@implementation MyMovieCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MyMovieCell" bundle:nil];
}

+ (NSString *)identifier
{
    return @"MyMovie Cell";
}

@end
