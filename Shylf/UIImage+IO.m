//
//  UIImage+IO.m
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "UIImage+IO.h"

@implementation UIImage (IO)

- (NSURL *)saveToDiskWithName:(NSString *)name
{
    // Make sure each image is unique:
    NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString] ;
    NSString *uniqueName = [NSString stringWithFormat:@"%@_%@", name, guid];
    
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", uniqueName]];
    
    if (![fileManager createFileAtPath:fullPath contents:data attributes:nil]) {
        DDLogError(@"There was an error saving the image to the path \"%@\"", fullPath);
        return nil;
    }
    
    return [NSURL fileURLWithPath:fullPath];
}

+ (BOOL)deleteFromDiskWithFilePathURL:(NSURL *)filePathURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[filePathURL path]]) {
        NSError *error = nil;
        if (![fileManager removeItemAtURL:filePathURL error:&error]) {
            DDLogError(@"There was an error removing the image from the path \"%@\": %@", [filePathURL path], [error localizedDescription]);
            return NO;
        }
    } else {
        DDLogInfo(@"The file could not be found at the specified URL, so it can't be deleted.");
    }
    
    return YES;
}

@end
