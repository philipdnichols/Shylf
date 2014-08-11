//
//  TheMovieDBAPI.m
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TheMovieDBAPI.h"
#import "TheMovieDBAPIKey.h"

#define TheMovieDBBaseURL @"https://api.themoviedb.org/3"
#define TheMovieDBBaseImageURL @"https://image.tmdb.org/t/p"

#define TheMovieDBMovieSearchResultsKey @"results"

@implementation TheMovieDBAPI

#pragma mark - Public

+ (void)searchMoviesFromQuery:(NSString *)query completionHandler:(void(^)(NSArray *searchMovies, NSError *error))completionHandler
{
    DDLogInfo(@"Searching for Movie: %@", query);
    
    NSURL *url = [TheMovieDBAPI URLForMovieQuery:query];
    dispatch_queue_t q = dispatch_queue_create("TheMovieDB API Movie Search", NULL);
    dispatch_async(q, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSError *error = nil;
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                options:0
                                                                  error:&error];
        
        NSArray *searchMovies = nil;
        if (!error) {
            searchMovies = results[TheMovieDBMovieSearchResultsKey];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionHandler) {
                completionHandler(searchMovies, error);
            }
        });
    });
}

//+ (void)searchMoviesFromModifiedQuery:(NSString *)query completionHandler:(void (^)(NSArray *, NSError *))completionHandler
//{
//    [TheMovieDBAPI searchMoviesFromQuery:[TheMovieDBAPI modifyQueryForMovieSearch:query]
//                       completionHandler:completionHandler];
//}

#pragma mark - Private

+ (NSURL *)URLForMovieQuery:(NSString *)query
{
    return [TheMovieDBAPI URLForQuery:query forEntity:@"movie"];
}

//+ (NSString *)modifyQueryForMovieSearch:(NSString *)query
//{
//    NSString *modifiedQuery = query;
//    
//    NSError *error = NULL;
//    NSString *regex = @"\\(.*\\)";
//    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regex
//                                                                                       options:NSRegularExpressionCaseInsensitive
//                                                                                         error:&error];
//    if (!error) {
//        modifiedQuery = [regularExpression stringByReplacingMatchesInString:modifiedQuery
//                                                                    options:0
//                                                                      range:NSMakeRange(0, [modifiedQuery length])
//                                                               withTemplate:@""];
//    } else {
//        DDLogError(@"There was an error building the regular expression %@: %@", regex, error.localizedDescription);
//    }
//    
//    return modifiedQuery;
//}

+ (NSURL *)URLForQuery:(NSString *)query forEntity:(NSString *)entity
{
    NSString *url = [NSString stringWithFormat:@"%@/search/%@?query=%@&api_key=%@", TheMovieDBBaseURL, entity, query, TheMovieDBAPIKey];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:url];
}

@end
