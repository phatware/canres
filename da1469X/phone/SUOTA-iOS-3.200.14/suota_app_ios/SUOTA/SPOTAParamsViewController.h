/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import <UIKit/UIKit.h>
#import "GenericParamsViewController.h"

@interface SPOTAParamsViewController : GenericParamsViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *fileTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *memoryTypeControl;

@property (weak, nonatomic) IBOutlet UIView *i2cView;
@property (weak, nonatomic) IBOutlet UITextField *i2cPatchBaseAddress;
@property (weak, nonatomic) IBOutlet UITextField *i2cAddress;
@property (weak, nonatomic) IBOutlet UITextField *i2cSDAGPIO;
@property (weak, nonatomic) IBOutlet UITextField *i2cSCLGPIO;

@property (weak, nonatomic) IBOutlet UIView *spiView;
@property (weak, nonatomic) IBOutlet UITextField *spiPatchBaseAddress;
@property (weak, nonatomic) IBOutlet UITextField *spiMISOGPIO;
@property (weak, nonatomic) IBOutlet UITextField *spiMOSIGPIO;
@property (weak, nonatomic) IBOutlet UITextField *spiCSGPIO;
@property (weak, nonatomic) IBOutlet UITextField *spiSCKGPIO;

- (IBAction) onMemoryTypeChange:(id)sender;

@end
