//
//  TMDBLanguage.m
//  Shylf
//
//  Created by Philip Nichols on 8/11/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBLanguage.h"

@implementation TMDBLanguage

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"iso6391" : @"iso_639_1",
             @"name" : @"name"
             };
}

@end
