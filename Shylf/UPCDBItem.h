//
//  UPCDBItem.h
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPCDBItem : MTLModel <MTLJSONSerializing>

@property (nonatomic) BOOL valid;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *alias;
@property (strong, nonatomic) NSString *descriptionOfItem;
@property (strong, nonatomic) NSNumber *averagePrice;
@property (nonatomic) NSUInteger rateUp;
@property (nonatomic) NSUInteger rateDown;

@end
