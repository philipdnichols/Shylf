//
//  MyVideoGameCell.m
//  Shylf
//
//  Created by Philip Nichols on 8/14/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MyVideoGameCell.h"

@implementation MyVideoGameCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MyVideoGameCell" bundle:nil];
}

+ (NSString *)identifier
{
    return @"MyVideoGame Cell";
}

@end
