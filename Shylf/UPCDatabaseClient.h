//
//  UPCDatabaseAPI.h
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPCDBItem.h"

@interface UPCDatabaseClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)itemForUPC:(NSString *)upc success:(void(^)(UPCDBItem *item))success failure:(void(^)(NSError *error))failure;

@end
