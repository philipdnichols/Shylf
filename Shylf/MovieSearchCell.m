//
//  MovieSearchCell.m
//  Shylf
//
//  Created by Philip Nichols on 8/12/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MovieSearchCell.h"

@implementation MovieSearchCell

+ (NSString *)identifier
{
    return @"Movie Search Cell";
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MovieSearchCell" bundle:nil];
}

@end
