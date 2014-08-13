//
//  TMDBConfiguration.m
//  Shylf
//
//  Created by Philip Nichols on 8/12/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "TMDBConfiguration.h"
#import "TMDBImagesConfiguration.h"

@implementation TMDBConfiguration

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"images" : @"images",
             @"changeKeys" : @"change_keys"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    if ([key isEqualToString:@"images"]) {
        return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMDBImagesConfiguration class]];
    }
    
    return nil;
}

@end
