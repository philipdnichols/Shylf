//
//  TMDBCountry.h
//  Shylf
//
//  Created by Philip Nichols on 8/11/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MTLModel.h"

@interface TMDBCountry : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *iso31661;
@property (strong, nonatomic) NSString *name;

@end
