//
//  TMDBImagesConfiguration.m
//  Shylf
//
//  Created by Philip Nichols on 8/12/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBImagesConfiguration.h"

@implementation TMDBImagesConfiguration

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"baseURL" : @"base_url",
             @"secureBaseURL" : @"secure_base_url",
             @"backdropSizes" : @"backdrop_sizes",
             @"logoSizes" : @"logo_sizes",
             @"posterSizes" : @"poster_sizes",
             @"profileSizes" : @"profile_sizes",
             @"stillSizes" : @"still_sizes"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    if ([key isEqualToString:@"baseURL"] || [key isEqualToString:@"secureBaseURL"]) {
        return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    }
    
    return nil;
}

@end
