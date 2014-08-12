//
//  TMDBCollection.m
//  Shylf
//
//  Created by Philip Nichols on 8/11/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBCollection.h"

@implementation TMDBCollection

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"identifier" : @"id",
             @"name" : @"name",
             @"posterPath" : @"poster_path",
             @"backdropPath" : @"backdrop_path"
             };
}

@end
