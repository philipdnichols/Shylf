//
//  AddMovieFormViewController.h
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyMovie;

static NSString * const MovieAddedSegueIdentifier = @"Movie Added";

@interface AddMovieFormViewController : UITableViewController <FXFormControllerDelegate>

// Out
@property (strong, nonatomic, readonly) MyMovie *addedMovie;

@end
