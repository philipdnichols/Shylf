//
//  UPCDatabaseAPI.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "UPCDatabaseClient.h"
#import "UPCDatabaseAPIKey.h"

#define UPCDatabaseBaseURL @"http://api.upcdatabase.org/json/"

@implementation UPCDatabaseClient

#pragma mark - Singleton

+ (instancetype)sharedClient {
    static UPCDatabaseClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:UPCDatabaseBaseURL]];
    });
    
    return _sharedClient;
}

#pragma mark - AFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

#pragma mark - Public

- (void)itemForUPC:(NSString *)upc success:(void(^)(UPCDBItem *item))success failure:(void(^)(NSError *error))failure;
{
    DDLogInfo(@"Searching for UPC %@", upc);
    
    [self GET:[NSString stringWithFormat:@"%@/%@", UPCDatabaseAPIKey, upc]
   parameters:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
          NSString *descriptionOfItem = responseObject[@"description"];
          NSString *itemName = responseObject[@"itemname"];
          UPCDBItem *item = [[UPCDBItem alloc] initWithDescriptionOfItem:descriptionOfItem
                                                                itemName:itemName];
          success(item);
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure(error);
      }];
}

@end
