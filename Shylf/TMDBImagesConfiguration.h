//
//  TMDBImagesConfiguration.h
//  Shylf
//
//  Created by Philip Nichols on 8/12/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MTLModel.h"

@interface TMDBImagesConfiguration : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic) NSURL *secureBaseURL;
@property (strong, nonatomic) NSArray *backdropSizes;
@property (strong, nonatomic) NSArray *logoSizes;
@property (strong, nonatomic) NSArray *posterSizes;
@property (strong, nonatomic) NSArray *profileSizes;
@property (strong, nonatomic) NSArray *stillSizes;

@end
