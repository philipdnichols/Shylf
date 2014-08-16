//
//  AddMovieForm.h
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddMovieForm : NSObject <FXForm>

@property (nonatomic, copy) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tagline;
@property (nonatomic, copy) NSNumber *rating;
@property (nonatomic, copy) NSDate *releaseDate;
@property (nonatomic, copy) NSNumber *runtime;
@property (nonatomic, copy) NSString *overview;

@end
