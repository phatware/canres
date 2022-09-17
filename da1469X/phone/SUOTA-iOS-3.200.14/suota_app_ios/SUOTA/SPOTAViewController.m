/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "SPOTAViewController.h"

#define UIALERTVIEW_TAG_ABORT 1

@interface SPOTAViewController ()

@end

@implementation SPOTAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = @"";
    
    storage = [ParameterStorage getInstance];
    manager = storage.manager;
    
    [self.progressView setProgress:0];
    [self.progressTextLabel setText:[NSString stringWithFormat:@"%d%%", 0]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdateValueForCharacteristic:)
                                                 name:GenericServiceManagerDidReceiveValue
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSendValueForCharacteristic:)
                                                 name:GenericServiceManagerDidSendValue
                                               object:nil];
    
    // Enable notifications on the status characteristic
    [manager setNotifications:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_SERV_STATUS_CBUUID enable:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    step = 1;
    [self doStep];
}

- (void) didUpdateValueForCharacteristic: (NSNotification*)notification {
    CBCharacteristic *characteristic = (CBCharacteristic*) notification.object;
    if ([characteristic.UUID isEqual:GenericServiceManager.SPOTA_SERV_STATUS_CBUUID]) {
        char value;
        [characteristic.value getBytes:&value length:sizeof(char)];
        
        NSString *message = [self getErrorMessage:value];
        //[self debug:[NSString stringWithFormat:@"Received value: %#4x, expected %#4x", value, expectedValue]];
        [self debug:message];
        
        if (expectedValue != 0) {
            // Check if value equals the expected value
            if (value == expectedValue) {
                // If so, continue with the next step
                step = nextStep;
                
                expectedValue = 0; // Reset
                
                [self doStep];
            } else {
                // Else display an error message
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                
                expectedValue = 0; // Reset
            }
        }
    } else if ([characteristic.UUID isEqual:GenericServiceManager.SPOTA_MEM_INFO_CBUUID]) {
        UInt32 data;
        char patches, patchsize;
        [characteristic.value getBytes:&data length:sizeof(UInt32)];
        patches = (data >> 16) & 0xff;
        patchsize = data & 0xff;
        
        [self debug:[NSString stringWithFormat:@"Patch Memory Info:\n  Number of patches: %d\n  Size of patches: %d (%d)", patches, (int) ceil((double)(patchsize)/4), patchsize]];
        
        if (step) {
            [self doStep];
        }
    }
}

- (void) didSendValueForCharacteristic: (NSNotification*)notification {
    //CBCharacteristic *characteristic = (CBCharacteristic*) notification.object;
    
    if (step) {
        [self doStep];
    }
}

- (void) doStep {
    [self debug:[NSString stringWithFormat:@"*** Next step: %d", step]];
    
    switch (step) {
        case 1: {
            // Step 1: Set memory type
            step = 0;
            expectedValue = 0x1;
            nextStep = 2;
            
            uint32_t _memDevData = (self.memoryType << 24) | (self.patchBaseAddress & 0xFFFFFF);
            [self debug:[NSString stringWithFormat:@"Sending data: %#10x", _memDevData]];
            NSData *memDevData = [NSData dataWithBytes:&_memDevData length:sizeof(uint32_t)];
            [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_MEM_DEV_CBUUID data:memDevData];
            break;
        }
        
        case 2: {
            // TODO: Check for memory type
            if (self.memoryType == MEM_TYPE_SPOTA_I2C || self.memoryType == MEM_TYPE_SPOTA_SPI) {
                // Step 2: Set memory params
                uint32_t _memInfoData = 0;
                
                if (self.memoryType == MEM_TYPE_SPOTA_I2C) {
                    _memInfoData = (self.i2cAddress << 16) | (self.i2cSCLGPIO << 8) | self.i2cSDAGPIO;
                } else if (self.memoryType == MEM_TYPE_SPOTA_SPI) {
                    _memInfoData = (self.spiMISOGPIO << 24) | (self.spiMOSIGPIO << 16) | (self.spiCSGPIO << 8) | self.spiSCKGPIO;
                }
                
                [self debug:[NSString stringWithFormat:@"Sending data: %#10x", _memInfoData]];
                NSData *memInfoData = [NSData dataWithBytes:&_memInfoData length:sizeof(uint32_t)];
                
                step = 3;
                [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_GPIO_MAP_CBUUID data:memInfoData];
                break;
            } else {
                step = 3;
                [self doStep];
                break;
            }
        }
            
        case 3: {
            step = 4;
            [manager readValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_MEM_INFO_CBUUID];
            break;
        }
            
        case 4: {
            // Load patch data
            [self debug:[NSString stringWithFormat:@"Loading data from %@", [storage.file_url absoluteString]]];
            fileData = [[NSData dataWithContentsOfURL:storage.file_url] mutableCopy];
            
            // Step 3: Set patch length
            chunkSize = 20;
            chunkStartByte = 0;
            
            step = 5;
            [self doStep];
            break;
        }
            
        case 5: {
            // Set patch length
            uint16_t dataLength = (uint16_t) [fileData length];
            [self debug:[NSString stringWithFormat:@"Sending data: %#10x", dataLength]];
            NSData *patchLengthData = [NSData dataWithBytes:&dataLength length:sizeof(uint16_t)];
            
            step = 6;
            
            [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_PATCH_LEN_CBUUID data:patchLengthData];
            break;
        }
            
        case 6: {
            // Send current block in chunks of 20 bytes
            step = 0;
            expectedValue = 0x02;
            nextStep = 7;
            
            int dataLength = (int) [fileData length];
            int bytesRemaining = dataLength;
            
            while (bytesRemaining > 0) {
                // Check if we have less than current block-size bytes remaining
                if (bytesRemaining < chunkSize) {
                    chunkSize = bytesRemaining;
                }
                
                [self debug:[NSString stringWithFormat:@"Sending bytes %d to %d of %d", chunkStartByte, chunkStartByte + chunkSize, dataLength]];
                
                double progress = (double)(chunkStartByte + chunkSize) / (double)dataLength;
                [self.progressView setProgress:progress];
                [self.progressTextLabel setText:[NSString stringWithFormat:@"%d%%", (int)(100 * progress)]];
                
                // Step 4: Send next n bytes of the patch
                char bytes[chunkSize];
                [fileData getBytes:bytes range:NSMakeRange(chunkStartByte, chunkSize)];
                NSData *byteData = [NSData dataWithBytes:&bytes length:sizeof(char)*chunkSize];
                
                // On to the next chunk
                chunkStartByte += chunkSize;
                bytesRemaining = dataLength - chunkStartByte;
                
                [manager writeValueWithoutResponse:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_PATCH_DATA_CBUUID data:byteData];
            }
            
            break;
        }
            
        case 7: {
            step = 8;
            [manager readValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_MEM_INFO_CBUUID];
            break;
        }
            
        case 8: {
            // Wait for user to confirm reboot
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Device has been patched" message:@"Do you wish to send the abort signal?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes, send it", nil];
            [alert setTag:UIALERTVIEW_TAG_ABORT];
            [alert show];
            break;
        }
            
        case 9: {
            // Go back to overview of devices
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == UIALERTVIEW_TAG_ABORT) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            // Send SPOTA ABORT command
            step = 9;
            uint32_t spotaAbort = 0xFF000000;
            [self debug:[NSString stringWithFormat:@"Sending data: %#10x", spotaAbort]];
            NSData *spotaAbortData = [NSData dataWithBytes:&spotaAbort length:sizeof(uint32_t)];
            [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_MEM_DEV_CBUUID data:spotaAbortData];
        }
    }
}

- (void) debug:(NSString*)message {
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss.SSS"];
    
    //Get the string date
    NSString* dateString = [formatter stringFromDate:date];
    self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"\n%@: %@", dateString, message]];
    [self.textView scrollRangeToVisible:NSMakeRange([self.textView.text length], 0)];
    NSLog(@"%@", message);
}

@end
