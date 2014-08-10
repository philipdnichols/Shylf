//
//  UPCDBItem.h
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPCDBItem : NSObject

@property (strong, nonatomic, readonly) NSString *descriptionOfItem;
@property (strong, nonatomic, readonly) NSString *itemName;

- (instancetype)initWithDescriptionOfItem:(NSString *)descriptionOfItem itemName:(NSString *)itemName;

@end
