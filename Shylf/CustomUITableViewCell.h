//
//  CustomUITableViewCell.h
//  Shylf
//
//  Created by Philip Nichols on 8/13/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomUITableViewCell <NSObject>

+ (UINib *)nib;
+ (NSString *)identifier;

@end
