//
//  TheMovieDBAPI.m
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TheMovieDBClient.h"
#import "TheMovieDBAPIKey.h"
#import "TMDBConfiguration.h"

#define TheMovieDBBaseURL @"https://api.themoviedb.org/3/"

@interface TheMovieDBClient ()

@property (strong, nonatomic) TMDBConfiguration *configuration;

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

#pragma mark - Properties

- (TMDBConfiguration *)configuration
{
    if (!_configuration) {
        DDLogInfo(@"Retrieving configuration. This should only happen once per app launch. That's a safe and simple caching mechanism.");
        
        // This blocks but is neccessary because we NEED this configuration on demand:
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"configuration?api_key=%@", TheMovieDBAPIKey] relativeToURL:[self baseURL]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSError *error = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&error];
        
        if (!error) {
            TMDBConfiguration *configuration = [MTLJSONAdapter modelOfClass:[TMDBConfiguration class]
                                                         fromJSONDictionary:jsonDictionary
                                                                      error:&error];
            
            if (!error) {
                _configuration = configuration;
            } else {
                DDLogError(@"Error mapping configuration to entity: %@", [error localizedDescription]);
            }
        } else {
            DDLogError(@"Error parsing JSON from URL %@: %@", [url absoluteString], [error localizedDescription]);
        }
    }
    return _configuration;
}

#pragma mark - Public

- (void)searchMoviesFromQuery:(NSString *)query fullResults:(BOOL)fullResults success:(void(^)(NSArray *results))success failure:(void(^)(NSError *error))failure
{
    DDLogInfo(@"Searching for Movie: %@", query);
    
    NSDictionary *parameters = @{
                                 @"query" : query,
                                 @"api_key" : TheMovieDBAPIKey
                                 };
    
    [self GET:@"search/movie"
   parameters:parameters
      success:^(NSURLSessionDataTask *task, id responseObject) {
          // TODO: Handle multiple pages of data
          NSError *error = nil;
          NSArray *results = [MTLJSONAdapter modelsOfClass:[TMDBMovie class]
                                             fromJSONArray:responseObject[@"results"]
                                                     error:&error];
          
          if (!error) {
              if (fullResults) {
                  NSMutableArray *fullResults = [NSMutableArray array];
                  __block int counter = [results count];
                  for (TMDBMovie *movie in results) {
                      [self fetchMovieWithIdentifier:movie.identifier
                             success:^(TMDBMovie *movie) {
                                 [fullResults addObject:movie];
                                 counter--;
                                 if (counter == 0) {
                                     success(fullResults);
                                 }
                             }
                             failure:^(NSError *error) {
                                 failure(error);
                             }];
                  }
              } else {
                  success(results);
              }
          } else {
              failure(error);
          }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure(error);
      }];
}

- (NSURL *)posterThumbnailURLForMovie:(TMDBMovie *)movie
{
    NSURL *posterThumbnailURL = nil;
    
    if (movie.posterPath) {
        NSString *posterSize = [self.configuration.images.posterSizes firstObject];
        NSString *posterPath = [posterSize stringByAppendingPathComponent:movie.posterPath];
        posterThumbnailURL = [NSURL URLWithString:posterPath relativeToURL:self.configuration.images.secureBaseURL];
    }
    
    return posterThumbnailURL;
}

- (void)fetchMovieWithIdentifier:(NSUInteger)identifier success:(void(^)(TMDBMovie *movie))success failure:(void(^)(NSError *error))failure
{
    DDLogInfo(@"Fetching Movie with ID: %d", identifier);
    
    NSDictionary *parameters = @{
                                 @"api_key" : TheMovieDBAPIKey
                                 };
    
    [self GET:[NSString stringWithFormat:@"movie/%d", identifier]
   parameters:parameters
      success:^(NSURLSessionDataTask *task, id responseObject) {
          NSError *error = nil;
          TMDBMovie *movie = [MTLJSONAdapter modelOfClass:[TMDBMovie class]
                                       fromJSONDictionary:responseObject
                                                    error:&error];
          
          if (!error) {
              success(movie);
          } else {
              failure(error);
          }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure(error);
      }];
}

@end
