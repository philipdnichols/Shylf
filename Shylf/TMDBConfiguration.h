//
//  TMDBConfiguration.h
//  Shylf
//
//  Created by Philip Nichols on 8/12/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MTLModel.h"
#import "TMDBImagesConfiguration.h"

@interface TMDBConfiguration : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) TMDBImagesConfiguration *images;
@property (strong, nonatomic) NSArray *changeKeys;

@end
