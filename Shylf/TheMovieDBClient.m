//
//  TheMovieDBAPI.m
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TheMovieDBClient.h"
#import "TheMovieDBAPIKey.h"

#define TheMovieDBBaseURL @"https://api.themoviedb.org/3/"
#define TheMovieDBBaseImageURL @"https://image.tmdb.org/t/p/"

@interface TheMovieDBClient ()

@end

@implementation TheMovieDBClient

#pragma mark - Singleton

+ (instancetype)sharedClient {
    static TheMovieDBClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:TheMovieDBBaseURL]];
    });
    
    return _sharedClient;
}

#pragma mark - AFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

#pragma mark - Public

- (void)searchMoviesFromQuery:(NSString *)query success:(void(^)(NSArray *results))success failure:(void(^)(NSError *error))failure
{
    DDLogInfo(@"Searching for Movie: %@", query);
    
    NSDictionary *parameters = @{
                                 @"query" : query,
                                 @"api_key" : TheMovieDBAPIKey
                                 };
    
    [self GET:@"search/movie"
   parameters:parameters
      success:^(NSURLSessionDataTask *task, id responseObject) {
          if ([responseObject isKindOfClass:[NSDictionary class]]) {
              success(responseObject[@"results"]);
          } else {
              DDLogError(@"Movie search response was expected to be an NSDictionary, but was a %@", [responseObject class]);
          }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure(error);
      }];
}

@end
