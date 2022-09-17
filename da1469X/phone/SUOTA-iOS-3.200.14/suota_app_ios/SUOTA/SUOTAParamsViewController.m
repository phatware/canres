/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "SUOTAParamsViewController.h"
#import "SUOTAViewController.h"
#import "ParameterStorage.h"

@interface SUOTAParamsViewController ()

@end

@implementation SUOTAParamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ParameterStorage *storage = [ParameterStorage getInstance];
    NSArray *parts = [storage.file_url pathComponents];
    [self.fileTextField setText:[parts lastObject]];
    [self.deviceNameLabel setText:storage.device.name];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"memoryType"])
        [self.memoryTypeControl setSelectedSegmentIndex:[[defaults objectForKey:@"memoryType"] integerValue]];
    
    if ([defaults objectForKey:@"memoryBank"])
        [self.memoryBank setSelectedSegmentIndex:[[defaults objectForKey:@"memoryBank"] integerValue]];
    if ([defaults objectForKey:@"blockSize"])
        self.blockSize.text = [[defaults objectForKey:@"blockSize"] stringValue];
    
    if ([defaults objectForKey:@"i2cAddress"])
        self.i2cAddress.text = [defaults objectForKey:@"i2cAddress"];
    if ([defaults objectForKey:@"i2cSDAGPIO"])
        self.i2cSDAGPIO.text = [defaults objectForKey:@"i2cSDAGPIO"];
    if ([defaults objectForKey:@"i2cSCLGPIO"])
        self.i2cSCLGPIO.text = [defaults objectForKey:@"i2cSCLGPIO"];
    
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

- (IBAction) onMemoryTypeChange:(id)sender {
    if ([self.memoryTypeControl selectedSegmentIndex] == 0) {
        [self.spiView setHidden:YES];
        [self.i2cView setHidden:NO];
    } else if ([self.memoryTypeControl selectedSegmentIndex] == 1) {
        [self.spiView setHidden:NO];
        [self.i2cView setHidden:YES];
    }
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
    int blockSize;
    unsigned int i2cAddress, i2cSDA, i2cSCL,
                 spiMOSI, spiMISO, spiCS, spiSCK = 0;
    
    SUOTAViewController *vc = (SUOTAViewController*) segue.destinationViewController;
    
    // Save default settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:@(self.memoryTypeControl.selectedSegmentIndex) forKey:@"memoryType"];
    
    if ([self.memoryTypeControl selectedSegmentIndex] == 0) { // I2C
        
        [[NSScanner scannerWithString:self.i2cAddress.text] scanHexInt:&i2cAddress];
        [self gpioScannerWithString:self.i2cSDAGPIO.text toInt:&i2cSDA];
        [self gpioScannerWithString:self.i2cSCLGPIO.text toInt:&i2cSCL];
        
        vc.memoryType = MEM_TYPE_SUOTA_I2C;
        vc.i2cAddress = i2cAddress;
        vc.i2cSDAGPIO = i2cSDA;
        vc.i2cSCLGPIO = i2cSCL;
        
        [defaults setObject:self.i2cAddress.text forKey:@"i2cAddress"];
        [defaults setObject:self.i2cSDAGPIO.text forKey:@"i2cSDAGPIO"];
        [defaults setObject:self.i2cSCLGPIO.text forKey:@"i2cSCLGPIO"];
        
    } else if ([self.memoryTypeControl selectedSegmentIndex] == 1) { // SPI
        
        [self gpioScannerWithString:self.spiMISOGPIO.text toInt:&spiMISO];
        [self gpioScannerWithString:self.spiMOSIGPIO.text toInt:&spiMOSI];
        [self gpioScannerWithString:self.spiCSGPIO.text toInt:&spiCS];
        [self gpioScannerWithString:self.spiSCKGPIO.text toInt:&spiSCK];
        
        vc.memoryType = MEM_TYPE_SUOTA_SPI;
        vc.spiMISOGPIO = spiMISO;
        vc.spiMOSIGPIO = spiMOSI;
        vc.spiCSGPIO = spiCS;
        vc.spiSCKGPIO = spiSCK;
        
        [defaults setObject:self.spiMISOGPIO.text forKey:@"spiMISOGPIO"];
        [defaults setObject:self.spiMOSIGPIO.text forKey:@"spiMOSIGPIO"];
        [defaults setObject:self.spiCSGPIO.text forKey:@"spiCSGPIO"];
        [defaults setObject:self.spiSCKGPIO.text forKey:@"spiSCKGPIO"];
    }
    
    int memoryBank = (int) self.memoryBank.selectedSegmentIndex;
    [defaults setObject:@(memoryBank) forKey:@"memoryBank"];
    vc.memoryBank = memoryBank;
    
    [[NSScanner scannerWithString:self.blockSize.text] scanInt:&blockSize];
    [defaults setObject:@(blockSize) forKey:@"blockSize"];
    vc.blockSize = blockSize;
}

@end
