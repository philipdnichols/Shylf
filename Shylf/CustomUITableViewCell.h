//
//  CustomUITableViewCell.h
//  Shylf
//
//  Created by Philip Nichols on 8/14/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomUITableViewCell : UITableViewCell

+ (UINib *)nib;
+ (NSString *)identifier;

@end
