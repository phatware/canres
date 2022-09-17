/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "SPOTAParamsViewController.h"
#import "SPOTAViewController.h"
#import "ParameterStorage.h"

@interface SPOTAParamsViewController ()

@end

@implementation SPOTAParamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ParameterStorage *storage = [ParameterStorage getInstance];
    NSArray *parts = [storage.file_url pathComponents];
    [self.fileTextField setText:[parts lastObject]];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"memoryType"])
        [self.memoryTypeControl setSelectedSegmentIndex:[[defaults objectForKey:@"memoryType"] integerValue]];
    
    if ([defaults objectForKey:@"i2cPatchBaseAddress"])
        self.i2cPatchBaseAddress.text = [defaults objectForKey:@"i2cPatchBaseAddress"];
    if ([defaults objectForKey:@"i2cAddress"])
        self.i2cAddress.text = [defaults objectForKey:@"i2cAddress"];
    if ([defaults objectForKey:@"i2cSDAGPIO"])
        self.i2cSDAGPIO.text = [defaults objectForKey:@"i2cSDAGPIO"];
    if ([defaults objectForKey:@"i2cSCLGPIO"])
        self.i2cSCLGPIO.text = [defaults objectForKey:@"i2cSCLGPIO"];
    
    if ([defaults objectForKey:@"spiPatchBaseAddress"])
        self.spiPatchBaseAddress.text = [defaults objectForKey:@"spiPatchBaseAddress"];
    if ([defaults objectForKey:@"spiMISOGPIO"])
        self.spiMISOGPIO.text = [defaults objectForKey:@"spiMISOGPIO"];
    if ([defaults objectForKey:@"spiMOSIGPIO"])
        self.spiMOSIGPIO.text = [defaults objectForKey:@"spiMOSIGPIO"];
    if ([defaults objectForKey:@"spiCSGPIO"])
        self.spiCSGPIO.text = [defaults objectForKey:@"spiCSGPIO"];
    if ([defaults objectForKey:@"spiSCKGPIO"])
        self.spiSCKGPIO.text = [defaults objectForKey:@"spiSCKGPIO"];
    
    [self onMemoryTypeChange:self];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.i2cSCLGPIO  ||
        textField == self.i2cSDAGPIO  ||
        textField == self.spiMOSIGPIO ||
        textField == self.spiMISOGPIO ||
        textField == self.spiCSGPIO   ||
        textField == self.spiSCKGPIO)
    {
        [self selectItemFromListForTextField:textField withTitle:@"Select a GPIO"];
        return NO;
    }
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    unsigned int patchAddress,
        i2cAddress, i2cSDA, i2cSCL,
        spiMOSI, spiMISO, spiCS, spiSCK = 0;
    
    SPOTAViewController *vc = (SPOTAViewController*) segue.destinationViewController;
    
    // Save default settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:self.memoryTypeControl.selectedSegmentIndex] forKey:@"memoryType"];
    
    if ([self.memoryTypeControl selectedSegmentIndex] == 2) { // I2C
        
        [[NSScanner scannerWithString:self.i2cPatchBaseAddress.text] scanHexInt:&patchAddress];
        [[NSScanner scannerWithString:self.i2cAddress.text] scanHexInt:&i2cAddress];
        [self gpioScannerWithString:self.i2cSDAGPIO.text toInt:&i2cSDA];
        [self gpioScannerWithString:self.i2cSCLGPIO.text toInt:&i2cSCL];
        
        vc.memoryType = MEM_TYPE_SPOTA_I2C;
        vc.patchBaseAddress = patchAddress;
        vc.i2cAddress = i2cAddress;
        vc.i2cSDAGPIO = i2cSDA;
        vc.i2cSCLGPIO = i2cSCL;
        
        [defaults setObject:self.i2cPatchBaseAddress.text forKey:@"i2cPatchBaseAddress"];
        [defaults setObject:self.i2cAddress.text forKey:@"i2cAddress"];
        [defaults setObject:self.i2cSDAGPIO.text forKey:@"i2cSDAGPIO"];
        [defaults setObject:self.i2cSCLGPIO.text forKey:@"i2cSCLGPIO"];
        
    } else if ([self.memoryTypeControl selectedSegmentIndex] == 3) { // SPI
        
        [[NSScanner scannerWithString:self.spiPatchBaseAddress.text] scanHexInt:&patchAddress];
        [self gpioScannerWithString:self.spiMISOGPIO.text toInt:&spiMISO];
        [self gpioScannerWithString:self.spiMOSIGPIO.text toInt:&spiMOSI];
        [self gpioScannerWithString:self.spiCSGPIO.text toInt:&spiCS];
        [self gpioScannerWithString:self.spiSCKGPIO.text toInt:&spiSCK];
        
        vc.memoryType = MEM_TYPE_SPOTA_SPI;
        vc.patchBaseAddress = patchAddress;
        vc.spiMISOGPIO = spiMISO;
        vc.spiMOSIGPIO = spiMOSI;
        vc.spiCSGPIO = spiCS;
        vc.spiSCKGPIO = spiSCK;
        
        [defaults setObject:self.spiPatchBaseAddress.text forKey:@"spiPatchBaseAddress"];
        [defaults setObject:self.spiMISOGPIO.text forKey:@"spiMISOGPIO"];
        [defaults setObject:self.spiMOSIGPIO.text forKey:@"spiMOSIGPIO"];
        [defaults setObject:self.spiCSGPIO.text forKey:@"spiCSGPIO"];
        [defaults setObject:self.spiSCKGPIO.text forKey:@"spiSCKGPIO"];
    }
}

- (IBAction) onMemoryTypeChange:(id)sender {
    if ([self.memoryTypeControl selectedSegmentIndex] == 2) {
        [self.i2cView setHidden:NO];
        [self.spiView setHidden:YES];
    } else if ([self.memoryTypeControl selectedSegmentIndex] == 3) {
        [self.i2cView setHidden:YES];
        [self.spiView setHidden:NO];
    } else {
        [self.i2cView setHidden:YES];
        [self.spiView setHidden:YES];
    }
}

@end
