//
//  TMDBGenre.h
//  Shylf
//
//  Created by Philip Nichols on 8/11/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MTLModel.h"

@interface TMDBGenre : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSUInteger identifier;
@property (strong, nonatomic) NSString *name;

@end
