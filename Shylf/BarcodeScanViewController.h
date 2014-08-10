//
//  BarcodeScanViewController.h
//  Shylf
//
//  Created by Philip Nichols on 8/9/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "MTBBarcodeScanner.h"

@interface BarcodeScanViewController : UIViewController

// Out
@property (strong, nonatomic, readonly) AVMetadataMachineReadableCodeObject *code;

@end
