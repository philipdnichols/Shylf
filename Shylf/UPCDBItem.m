//
//  UPCDBItem.m
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "UPCDBItem.h"

@interface UPCDBItem ()

@property (strong, nonatomic, readwrite) NSString *descriptionOfItem;
@property (strong, nonatomic, readwrite) NSString *itemName;

@end

@implementation UPCDBItem

#pragma mark - Initialization

- (instancetype)initWithDescriptionOfItem:(NSString *)descriptionOfItem itemName:(NSString *)itemName
{
    self = [super init];
    if (self) {
        self.descriptionOfItem = descriptionOfItem;
        self.itemName = itemName;
    }
    return self;
}

@end
