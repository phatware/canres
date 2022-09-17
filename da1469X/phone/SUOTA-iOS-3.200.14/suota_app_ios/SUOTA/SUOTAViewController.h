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
#import "Defines.h"
#import "ParameterStorage.h"
#import "SUOTAServiceManager.h"
#import "GenericSUOTAViewController.h"

@interface SUOTAViewController : GenericSUOTAViewController <UIAlertViewDelegate> {
    int step, nextStep;
    int expectedValue;
    
    int chunkSize;
    int blockStartByte;
    
    ParameterStorage *storage;
    SUOTAServiceManager *manager;
    NSMutableData *fileData;
    NSDate *uploadStart;
}

@property uint8_t memoryType;
@property uint8_t memoryBank;
@property uint16_t blockSize;

@property uint16_t i2cAddress;
@property uint8_t i2cSDAGPIO;
@property uint8_t i2cSCLGPIO;

@property uint8_t spiMISOGPIO;
@property uint8_t spiMOSIGPIO;
@property uint8_t spiCSGPIO;
@property uint8_t spiSCKGPIO;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
