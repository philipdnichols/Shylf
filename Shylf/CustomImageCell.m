//
//  CustomImageCell.m
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "CustomImageCell.h"

@interface CustomImageCell () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) UIViewController *controllerToPresentImagePickerController;

@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

@end

// TODO: Implement the 'didCancel' delegate methods for other things - this is a system thing.

@implementation CustomImageCell

#pragma mark - Properties

- (UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.navigationController.navigationBar.translucent = NO;
    }
    return _imagePickerController;
}

- (UIActionSheet *)actionSheet
{
    if (!_actionSheet) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Image"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Photo Library", @"Saved Photos", @"Take Photo", nil];
        _actionSheet = actionSheet;
    }
    return _actionSheet;
}

#pragma mark - Initialization

- (void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setNeedsLayout];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - FXFormFieldCell

static CGFloat const Height = 250;

// TODO: could use the passed in "field" parameter to go into the object and get the size of the image
+ (CGFloat)heightForField:(FXFormField *)field width:(CGFloat)width
{
    return Height;
}

+ (CGFloat)heightForField:(FXFormField *)field
{
    return Height;
}

- (void)didSelectWithTableView:(UITableView *)tableView controller:(UIViewController *)controller
{
    [self becomeFirstResponder];
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
    
    self.controllerToPresentImagePickerController = controller;
    
    [self.actionSheet showInView:tableView];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.customImageView.image = info[UIImagePickerControllerOriginalImage];
    [self setNeedsLayout];
    
    self.field.value = self.customImageView.image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    // Hack to fix the UIImagePickerController messing up the status bar style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([navigationController isKindOfClass:[UIImagePickerController class]]) {
        viewController.navigationController.navigationBar.translucent = NO;
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    self.controllerToPresentImagePickerController = nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (actionSheet == self.actionSheet) {
        if ([buttonTitle isEqualToString:@"Photo Library"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [SVProgressHUD showWithStatus:@"Accessing Photo Library..." maskType:SVProgressHUDMaskTypeGradient];
                self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self.controllerToPresentImagePickerController presentViewController:self.imagePickerController animated:YES completion:^{
                    [SVProgressHUD dismiss];
                }];
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Photo Library Unavailable"
                                            message:@"It looks like your Photo Library isn't available. We're sorry about that."
                                           delegate:self
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil] show];
            }
        } else if ([buttonTitle isEqualToString:@"Saved Photos"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                [SVProgressHUD showWithStatus:@"Accessing Saved Photos" maskType:SVProgressHUDMaskTypeGradient];
                self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self.controllerToPresentImagePickerController presentViewController:self.imagePickerController animated:YES completion:^{
                    [SVProgressHUD dismiss];
                }];
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Saved Photos Unavailable"
                                            message:@"It looks like your Saved Photos Album isn't available. We're sorry about that."
                                           delegate:self
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil] show];
            }
        } else if ([buttonTitle isEqualToString:@"Take Photo"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [SVProgressHUD showWithStatus:@"Preparing Camera..." maskType:SVProgressHUDMaskTypeGradient];
                self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self.controllerToPresentImagePickerController presentViewController:self.imagePickerController animated:YES completion:^{
                    [SVProgressHUD dismiss];
                }];
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Camera Unavailable"
                                            message:@"It looks like your Camera isn't available. We're sorry about that."
                                           delegate:self
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil] show];
            }
        }
        
        self.controllerToPresentImagePickerController = nil;
    }
}

@end
