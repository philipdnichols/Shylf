//
//  TMDBCountry.m
//  Shylf
//
//  Created by Philip Nichols on 8/11/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBCountry.h"

@implementation TMDBCountry

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"iso31661": @"iso_3166_1",
             @"name" : @"name"
             };
}

@end
