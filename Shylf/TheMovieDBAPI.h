//
//  TheMovieDBAPI.h
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheMovieDBAPI : NSObject

+ (void)searchMoviesFromQuery:(NSString *)query completionHandler:(void(^)(NSArray *searchMovies, NSError *error))completionHandler;
//+ (void)searchMoviesFromModifiedQuery:(NSString *)query completionHandler:(void(^)(NSArray *searchMovies, NSError *error))completionHandler;

@end
