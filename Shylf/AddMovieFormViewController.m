//
//  AddMovieFormViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/15/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "AddMovieFormViewController.h"
#import "AddMovieForm.h"
#import "MyMovie.h"
#import "UIImage+IO.h"

@interface AddMovieFormViewController ()

@property (strong, nonatomic, readwrite) MyMovie *addedMovie;

@property (strong, nonatomic) FXFormController *formController;

@end

@implementation AddMovieFormViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.formController = [[FXFormController alloc] init];
    self.formController.tableView = self.tableView;
    self.formController.delegate = self;
    self.formController.form = [[AddMovieForm alloc] init];
}

#pragma mark - IBActions

- (IBAction)cancel {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:MovieAddedSegueIdentifier]) {
        // TODO: Add validation
    }
    
    return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:MovieAddedSegueIdentifier]) {
        [SVProgressHUD showWithStatus:@"Saving..."
                             maskType:SVProgressHUDMaskTypeGradient];
        
        MyMovie *movie = [MyMovie MR_createEntity];
        
        AddMovieForm *addMovieForm = (AddMovieForm *)self.formController.form;
        movie.title = addMovieForm.title;
        movie.tagline = addMovieForm.tagline;
        movie.rating = addMovieForm.rating;
        movie.releaseDate = addMovieForm.releaseDate;
        movie.runtime = addMovieForm.runtime;
        movie.overview = addMovieForm.overview;
        
        NSURL *posterFileURL = [addMovieForm.image saveToDiskWithName:@"moviePoster"];
        if (posterFileURL) {
            movie.posterFileURL = [posterFileURL path];
        }
        
        NSURL *thumbnailFileURL = [addMovieForm.image saveToDiskWithName:@"moviePosterThumbnail"];
        if (thumbnailFileURL) {
            movie.thumbnailFileURL = [thumbnailFileURL path]; // TODO: this should be improved eventually by scaling the image down
        }
        
        self.addedMovie = movie;
    }
}

@end
