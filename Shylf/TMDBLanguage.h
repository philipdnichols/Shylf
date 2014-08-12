//
//  TMDBLanguage.h
//  Shylf
//
//  Created by Philip Nichols on 8/11/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MTLModel.h"

@interface TMDBLanguage : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *iso6391;
@property (strong, nonatomic) NSString *name;

@end
