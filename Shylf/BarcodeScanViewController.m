//
//  BarcodeScanViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "BarcodeScanViewController.h"

@interface BarcodeScanViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) MTBBarcodeScanner *scanner;

@property (strong, nonatomic, readwrite) AVMetadataMachineReadableCodeObject *code;

@end

@implementation BarcodeScanViewController

#pragma mark - Properties

- (MTBBarcodeScanner *)scanner
{
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.view];
    }
    return _scanner;
}

#pragma mark - Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.scanner stopScanning];
    
    [super viewWillDisappear:animated];
}

static NSString *BarcodeScannedSegueIdentifier = @"Barcode Scanned";

- (void)startScanning
{
    if ([MTBBarcodeScanner scanningIsAvailable]) {
        [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
            [self.scanner stopScanning];
            AVMetadataMachineReadableCodeObject *code = [codes firstObject];
            self.code = code;
            [self performSegueWithIdentifier:BarcodeScannedSegueIdentifier sender:self];
        }];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Barcode Scan Unavailable"
                                    message:@"It looks like Barcode Scanning isn't available on your device. We're sorry about that."
                                   delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - IBActions

- (IBAction)cancel {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self cancel];
}

@end
