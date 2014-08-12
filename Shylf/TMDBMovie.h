//
//  TMDBMovie.h
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDBCollection.h"

@interface TMDBMovie : MTLModel <MTLJSONSerializing>

@property (nonatomic) BOOL adult;
@property (strong, nonatomic) NSString *backdropPath;
@property (strong, nonatomic) TMDBCollection *collection;
@property (strong, nonatomic) NSNumber *budget;
@property (strong, nonatomic) NSArray *genres; // of TMDBGenre
@property (strong, nonatomic) NSURL *homepage;
@property (nonatomic) NSUInteger identifier;
@property (strong, nonatomic) NSString *imdbId;
@property (strong, nonatomic) NSString *originalTitle;
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSNumber *popularity;
@property (strong, nonatomic) NSString *posterPath;
@property (strong, nonatomic) NSArray *productionCompanies; // of TMDBCompany
@property (strong, nonatomic) NSArray *productionCountries; // of TMDBCountry
@property (strong, nonatomic) NSDate *releaseDate;
@property (strong, nonatomic) NSNumber *revenue;
@property (strong, nonatomic) NSNumber *runtime;
@property (strong, nonatomic) NSArray *spokenLanguages; // of TMDBLanguage
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *tagline;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *voteAverage;
@property (nonatomic) NSUInteger voteCount;

@end
