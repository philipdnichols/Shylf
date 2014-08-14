//
//  MyMovieCell.h
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUITableViewCell.h"

@interface MyMovieCell : UITableViewCell <CustomUITableViewCell>

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@end
