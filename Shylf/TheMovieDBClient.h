//
//  TheMovieDBAPI.h
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDBMovie.h"

@interface TheMovieDBClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)searchMoviesFromQuery:(NSString *)query fullResults:(BOOL)fullResults success:(void(^)(NSArray *results))success failure:(void(^)(NSError *error))failure;
- (void)fetchMovieWithIdentifier:(NSUInteger)identifier success:(void(^)(TMDBMovie *movie))success failure:(void(^)(NSError *error))failure;

- (NSURL *)posterThumbnailURLForMovie:(TMDBMovie *)movie;

@end
