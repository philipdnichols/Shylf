//
//  TMDBMovie+CoreData.m
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBMovie+CoreData.h"

@implementation TMDBMovie (CoreData)

+ (NSString *)managedObjectEntityName
{
    return @"MyMovie";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{
             @"adult" : [NSNull null],
             @"backdropPath" : [NSNull null],
             @"collection" : [NSNull null],
             @"budget" : [NSNull null],
             @"genres" : @"genres",
             @"homepage" : [NSNull null],
             @"identifier" : @"identifier",
             @"imdbId" : [NSNull null],
             @"originalTitle" : [NSNull null],
             @"overview" : @"overview",
             @"popularity" : [NSNull null],
             @"posterPath" : @"posterPath",
             @"productionCompanies" : [NSNull null],
             @"productionCountries" : [NSNull null],
             @"releaseDate" : @"releaseDate",
             @"revenue" : [NSNull null],
             @"runtime" : @"runtime",
             @"spokenLanguages" : [NSNull null],
             @"status" : [NSNull null],
             @"tagline" : @"tagline",
             @"title" : @"title",
             @"voteAverage" : @"rating",
             @"voteCount" : [NSNull null]
             };
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey
{
    return @{
             @"genres" : @"MyMovieGenre"
             };
}

@end
