//
//  AddMovieForm.m
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "AddMovieForm.h"
#import "CustomImageCell.h"

@implementation AddMovieForm

// TODO: Can we reorder the fields in here and still have the custom attributes specified below?
//- (NSArray *)fields
//{
//    return @[];
//}

- (NSDictionary *)imageField
{
    return @{
             FXFormFieldCell : [CustomImageCell class],
             FXFormFieldHeader : @"",
             };
}

- (NSDictionary *)titleField
{
    return @{
             FXFormFieldHeader : @""
             };
}

@end
