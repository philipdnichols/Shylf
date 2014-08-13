//
//  MovieSearchCell.h
//  Shylf
//
//  Created by Philip Nichols on 8/12/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieSearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;

+ (NSString *)identifier;
+ (UINib *)nib;

@end
