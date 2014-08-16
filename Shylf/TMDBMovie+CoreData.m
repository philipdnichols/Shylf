//
//  TMDBMovie+CoreData.m
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBMovie+CoreData.h"
#import "TheMovieDBClient.h"
#import "MyMovie.h"
#import "UIImage+IO.h"

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
             @"posterPath" : @"posterFileURL",
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

//+ (NSValueTransformer *)entityAttributeTransformerForKey:(NSString *)key
//{
//    if ([key isEqualToString:@"posterPath"]) {
//        [MTLValueTransformer reversibleTransformerWithForwardBlock:^NSString*(NSString *posterPath) {
//            NSString *posterFileURL = nil;
//            
//            NSURL *posterThumbnailURL = [[TheMovieDBClient sharedClient] posterThumbnailURLForPosterPath:posterPath];
//            NSURL *posterURL = [[TheMovieDBClient sharedClient] posterURLForPosterPath:posterPath];
//            
//            // Must block here
//            
//            return posterFileURL;
//        } reverseBlock:^id(NSString *pathFileURL) {
//            return @""; // Not supported
//        }];
//    }
//    
//    return nil;
//}

- (void)saveWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure
{
    NSError *error = nil;
    MyMovie *myMovie = [MTLManagedObjectAdapter managedObjectFromModel:self
                                                  insertingIntoContext:[NSManagedObjectContext MR_defaultContext]
                                                                 error:&error];
    
    // TODO: I think this creates unique genre objects...maybe? This could be improved but isn't a huge deal.
    
    if (!error) {
        NSURL *posterThumbnailURL = [[TheMovieDBClient sharedClient] posterThumbnailURLForPosterPath:self.posterPath];
        NSURL *posterURL = [[TheMovieDBClient sharedClient] posterURLForPosterPath:self.posterPath];
        
        // TODO: Use NSOperationQueue here
        dispatch_queue_t posterQ = dispatch_queue_create("Poster Q", NULL);
        dispatch_async(posterQ, ^{
            UIImage *posterThumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:posterThumbnailURL]];
            UIImage *posterImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:posterURL]];
            
            // TODO: String constants to use in the manual add process as well
            NSURL *posterThumbnailImageFileURL = [posterThumbnailImage saveToDiskWithName:@"moviePosterThumbnail"];
            NSURL *posterImageFileURL = [posterImage saveToDiskWithName:@"moviePoster"];
            
            if (posterThumbnailImageFileURL) {
                myMovie.thumbnailFileURL = [posterThumbnailImageFileURL path];
            }
            if (posterImageFileURL) {
                myMovie.posterFileURL = [posterImageFileURL path];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL succ, NSError *error) {
                    if (!error) {
                        success();
                    } else {
                        failure(error);
                    }
                }];
            });
        });
    } else {
        failure(error);
    }
    
    
    
    
    if (!error) {
        
    } else {
        failure(error);
    }
}

@end
