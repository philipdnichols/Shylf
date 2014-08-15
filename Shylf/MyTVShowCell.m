//
//  MyTVShowCell.m
//  Shylf
//
//  Created by Philip Nichols on 8/14/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "MyTVShowCell.h"

@implementation MyTVShowCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MyTVShowCell" bundle:nil];
}

+ (NSString *)identifier
{
    return @"MyTVShow Cell";
}

@end
