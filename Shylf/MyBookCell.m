//
//  MyBookCell.m
//  Shylf
//
//  Created by Philip Nichols on 8/14/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MyBookCell.h"

@implementation MyBookCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MyBookCell" bundle:nil];
}

+ (NSString *)identifier
{
    return @"MyBook Cell";
}

@end
