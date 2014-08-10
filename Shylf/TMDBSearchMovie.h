//
//  TMDBMovie.h
//  Shylf
//
//  Created by Philip Nichols on 8/10/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDBSearchMovie : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *releaseDate;
@property (strong, nonatomic, readonly) NSString *posterPath;

@end
