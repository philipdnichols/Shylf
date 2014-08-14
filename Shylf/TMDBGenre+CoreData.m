//
//  TMDBGenre+CoreData.m
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBGenre+CoreData.h"

@implementation TMDBGenre (CoreData)

+ (NSString *)managedObjectEntityName
{
    return @"MyMovieGenre";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{
             @"identifier" : @"identifier",
             @"name" : @"name"
             };
}

@end
