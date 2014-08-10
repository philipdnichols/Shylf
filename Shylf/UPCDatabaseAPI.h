//
//  UPCDatabaseAPI.h
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPCDBItem.h"

@interface UPCDatabaseAPI : NSObject

+ (void)itemForUPC:(NSString *)upc completionHandler:(void(^)(UPCDBItem *item, NSError *error))completionHandler;

@end
