//
//  TMDBGenre.m
//  Shylf
//
//  Created by Philip Nichols on 8/11/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBGenre.h"

@implementation TMDBGenre

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"identifier" : @"id",
             @"name" : @"name"
             };
}

@end
