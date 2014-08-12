//
//  UPCDBItem.m
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "UPCDBItem.h"

@implementation UPCDBItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"valid" : @"valid",
             @"number" : @"number",
             @"itemName" : @"itemname",
             @"alias" : @"alias",
             @"descriptionOfItem" : @"description",
             @"averagePrice" : @"avg_price",
             @"rateUp" : @"rate_up",
             @"rateDown" : @"rate_down"
             };
}

+ (NSValueTransformer *)validJSONTransformer
{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                            @"true" : @YES,
                                                                            @"false" : @NO
                                                                            }];
}

@end
