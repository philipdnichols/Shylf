//
//  UPCDatabaseAPI.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "UPCDatabaseAPI.h"
#import "UPCDatabaseAPIKey.h"

#define UPCDatabaseBaseURL @"http://api.upcdatabase.org/json"

#define UPCDatabaseUpcDescriptionKey @"description"
#define UPCDatabaseUpcItemNameKey @"itemname"

@implementation UPCDatabaseAPI

#pragma mark - Public

+ (void)itemForUPC:(NSString *)upc completionHandler:(void (^)(UPCDBItem *, NSError *))completionHandler
{
    NSLog(@"Searching for UPC %@", upc);
    NSURL *url = [UPCDatabaseAPI URLforUPC:upc];
    dispatch_queue_t q = dispatch_queue_create("UPCDatabase API Description Fetch", NULL);
    dispatch_async(q, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSError *error = nil;
        NSDictionary *upcInfo = [NSJSONSerialization JSONObjectWithData:data
                                                                options:0
                                                                  error:&error];
        
        UPCDBItem *item = nil;
        if (!error) {
            NSString *descriptionOfItem = upcInfo[UPCDatabaseUpcDescriptionKey];
            NSString *itemName = upcInfo[UPCDatabaseUpcItemNameKey];
            item = [[UPCDBItem alloc] initWithDescriptionOfItem:descriptionOfItem
                                                       itemName:itemName];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionHandler) {
                completionHandler(item, error);
            }
        });
    });
}
                             
#pragma mark - Private
                             
+ (NSURL *)URLforUPC:(NSString *)upc
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@", UPCDatabaseBaseURL, UPCDatabaseAPIKey, upc]];
}

@end
