//
//  TMDBMovie.m
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBMovie.h"
#import "TMDBGenre.h"
#import "TMDBCompany.h"
#import "TMDBCountry.h"
#import "TMDBLanguage.h"

@implementation TMDBMovie

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"adult" : @"adult",
             @"backdropPath" : @"backdrop_path",
             @"collection" : @"belongs_to_collection",
             @"budget" : @"budget",
             @"genres" : @"genres",
             @"homepage" : @"homepage",
             @"identifier" : @"id",
             @"imdbId" : @"imdb_id",
             @"originalTitle" : @"original_title",
             @"overview" : @"overview",
             @"popularity" : @"popularity",
             @"posterPath" : @"poster_path",
             @"productionCompanies" : @"production_companies",
             @"productionCountries" : @"production_countries",
             @"releaseDate" : @"release_date",
             @"revenue" : @"revenue",
             @"runtime" : @"runtime",
             @"spokenLanguages" : @"spoken_languages",
             @"status" : @"status",
             @"tagline" : @"tagline",
             @"title" : @"title",
             @"voteAverage" : @"vote_average",
             @"voteCount" : @"vote_count"
             };
}

+ (NSDateFormatter *)dateFormatter
{
    // TODO: Should I use dispatch once here?
    static NSDateFormatter *_dateFormater = nil;
    if (!_dateFormater) {
        _dateFormater = [[NSDateFormatter alloc] init];
        _dateFormater.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormater;
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    if ([key isEqualToString:@"releaseDate"]) {
        return [MTLValueTransformer
                reversibleTransformerWithForwardBlock:^(NSString *str) {
                    return [[self dateFormatter] dateFromString:str];
                }
                reverseBlock:^(NSDate *date) {
                    return [[self dateFormatter] stringFromDate:date];
                }];
    } else if ([key isEqualToString:@"homepage"]) {
        return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    } else if ([key isEqualToString:@"collection"]) {
        return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMDBCollection class]];
    } else if ([key isEqualToString:@"genres"]) {
        return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMDBGenre class]];
    } else if ([key isEqualToString:@"productionCompanies"]) {
        return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMDBCompany class]];
    } else if ([key isEqualToString:@"productionCountries"]) {
        return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMDBCountry class]];
    } else if ([key isEqualToString:@"spokenLanguages"]) {
        return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMDBLanguage class]];
    }
    
    return nil;
}

@end
