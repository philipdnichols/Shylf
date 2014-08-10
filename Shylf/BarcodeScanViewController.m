//
//  BarcodeScanViewController.m
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "BarcodeScanViewController.h"

@interface BarcodeScanViewController ()

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
    [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
        [self.scanner stopScanning];
        AVMetadataMachineReadableCodeObject *code = [codes firstObject];
        self.code = code;
        [self performSegueWithIdentifier:BarcodeScannedSegueIdentifier sender:self];
    }];
}

#pragma mark - IBActions

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
