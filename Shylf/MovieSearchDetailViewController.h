//
//  MovieSearchDetailViewController.h
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMDBMovie.h"

@interface MovieSearchDetailViewController : UIViewController

@property (strong, nonatomic) TMDBMovie *movie;

@end
