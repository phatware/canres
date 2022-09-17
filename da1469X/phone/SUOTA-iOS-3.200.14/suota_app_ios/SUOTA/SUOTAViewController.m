/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#define UIALERTVIEW_TAG_REBOOT 1

#import "SUOTAViewController.h"

@interface SUOTAViewController ()

@end

@implementation SUOTAViewController

@synthesize blockSize;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = @"";
    
    storage = [ParameterStorage getInstance];
    manager = storage.manager;
    
    [self.progressView setProgress:0];
    [self.progressTextLabel setText:[NSString stringWithFormat:@"%d%%", 0]];
    
    // Enable notifications on the status characteristic
    [manager setNotifications:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_SERV_STATUS_CBUUID enable:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    // Enable notifications for BLE events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDisconnectFromDevice:)
                                                 name:BluetoothManagerDisconnectedFromDevice
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdateValueForCharacteristic:)
                                                 name:GenericServiceManagerDidReceiveValue
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSendValueForCharacteristic:)
                                                 name:GenericServiceManagerDidSendValue
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onBleOperationError:)
                                                 name:GenericServiceManagerWriteError
                                               object:nil];

    step = 1;
    [self doStep];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].idleTimerDisabled = NO;

    // Disable notifications for BLE events
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BluetoothManagerDisconnectedFromDevice object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GenericServiceManagerDidReceiveValue object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GenericServiceManagerDidSendValue object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GenericServiceManagerWriteError object:nil];
}

- (void) didDisconnectFromDevice: (NSNotification*)notification {
    if (step != 8) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:step != 7 ? @"Upload Failed" : @"Device Disconnected"
                                                            message:@"The connection to the remote device was lost."
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void) didUpdateValueForCharacteristic: (NSNotification*)notification {
    CBCharacteristic *characteristic = (CBCharacteristic*) notification.object;
    if ([characteristic.UUID isEqual:GenericServiceManager.SPOTA_SERV_STATUS_CBUUID]) {
        char value;
        [characteristic.value getBytes:&value length:sizeof(char)];
        
        NSString *message = [self getErrorMessage:value];
        [self debug:message UILog:(value != SPOTAR_CMP_OK)];
        
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
    }
}

- (void) didSendValueForCharacteristic: (NSNotification*)notification {
    if (step && step != 7) {
        [self doStep];
    }
}

- (void) onBleOperationError: (NSNotification*)notification {
    [self debug:[NSString stringWithFormat:@"Error in BLE operation on characteristic %@", ((CBCharacteristic*)notification.object).UUID] UILog:YES];
    if (step != 8) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upload Failed"
                                                            message:@"The firmware upload procedure encountered an error."
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void) doStep {
    [self debug:[NSString stringWithFormat:@"*** Next step: %d", step] UILog:NO];
    
    switch (step) {
        case 1: {
            // Step 1: Set memory type
            step = 0;
            expectedValue = 0x10;
            nextStep = 2;
            uploadStart = [NSDate date];

            uint32_t _memDevData = (self.memoryType << 24) | self.memoryBank;
            [self debug:[NSString stringWithFormat:@"Set SPOTA_MEM_DEV: %#010x", _memDevData] UILog:YES];
            NSData *memDevData = [NSData dataWithBytes:&_memDevData length:sizeof(uint32_t)];
            [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_MEM_DEV_CBUUID data:memDevData];
            break;
        }
            
        case 2: {
            // Step 2: Set memory params
            uint32_t _memInfoData = 0;
            if (self.memoryType == MEM_TYPE_SUOTA_SPI) {
                _memInfoData = (self.spiMISOGPIO << 24) | (self.spiMOSIGPIO << 16) | (self.spiCSGPIO << 8) | self.spiSCKGPIO;
            } else if (self.memoryType == MEM_TYPE_SUOTA_I2C) {
                _memInfoData = (self.i2cAddress << 16) | (self.i2cSCLGPIO << 8) | self.i2cSDAGPIO;
            }
            [self debug:[NSString stringWithFormat:@"Set SPOTA_GPIO_MAP: %#010x", _memInfoData] UILog:YES];
            NSData *memInfoData = [NSData dataWithBytes:&_memInfoData length:sizeof(uint32_t)];
            
            step = 3;
            [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_GPIO_MAP_CBUUID data:memInfoData];
            break;
        }
            
        case 3: {
            // Load patch data
            [self debug:[NSString stringWithFormat:@"Loading data from %@", storage.file_url.absoluteString.stringByRemovingPercentEncoding] UILog:YES];
            fileData = [[NSData dataWithContentsOfURL:storage.file_url] mutableCopy];
            [self appendChecksum];
            [self debug:[NSString stringWithFormat:@"Upload size: %d bytes", (int) [fileData length]] UILog:YES];
            
            // Step 3: Set patch length
            chunkSize = MIN(manager.suotaPatchDataSize, manager.suotaMtu - 3);
            blockSize = MAX(blockSize, chunkSize);
            if (blockSize > fileData.length) {
                blockSize = fileData.length;
                if (chunkSize > blockSize)
                    chunkSize = blockSize;
            }
            blockStartByte = 0;
            [self debug:[NSString stringWithFormat:@"Chunk size: %d bytes", chunkSize] UILog:YES];

            step = 4;
            [self doStep];
            break;
        }
            
        case 4: {
            // Set patch length
            [self debug:[NSString stringWithFormat:@"Set SPOTA_PATCH_LEN: %d", blockSize] UILog:YES];
            NSData *patchLengthData = [NSData dataWithBytes:&blockSize length:sizeof(uint16_t)];
            
            step = 5;
            
            [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_PATCH_LEN_CBUUID data:patchLengthData];
            break;
        }
            
        case 5: {
            // Send current block in chunks of 20 bytes
            if (blockStartByte == 0)
                [self debug:@"Upload procedure started" UILog:YES];

            step = 0;
            expectedValue = 0x02;
            nextStep = 5;
            
            int dataLength = (int) [fileData length];
            int chunkStartByte = 0;
            
            while (chunkStartByte < blockSize) {
                
                // Check if we have less than current block-size bytes remaining
                int bytesRemaining = blockSize - chunkStartByte;
                int currChunkSize = bytesRemaining >= chunkSize ? chunkSize : bytesRemaining;

                [self debug:[NSString stringWithFormat:@"Sending bytes %d to %d (%d/%d) of %d", blockStartByte + chunkStartByte + 1, blockStartByte + chunkStartByte + currChunkSize, chunkStartByte + currChunkSize, blockSize, dataLength] UILog:NO];
                
                double progress = (double)(blockStartByte + chunkStartByte + currChunkSize) / (double)dataLength;
                [self.progressView setProgress:progress];
                [self.progressTextLabel setText:[NSString stringWithFormat:@"%d%%", (int)(100 * progress)]];
                
                // Step 4: Send next n bytes of the patch
                char bytes[currChunkSize];
                [fileData getBytes:bytes range:NSMakeRange(blockStartByte + chunkStartByte, currChunkSize)];
                NSData *byteData = [NSData dataWithBytes:bytes length:currChunkSize];
                
                // On to the chunk
                chunkStartByte += currChunkSize;
                
                // Check if we are passing the current block
                if (chunkStartByte >= blockSize) {
                    // Prepare for next block
                    blockStartByte += blockSize;
                    
                    int bytesRemaining = dataLength - blockStartByte;
                    if (bytesRemaining == 0) {
                        nextStep = 6;
                        
                    } else if (bytesRemaining < blockSize) {
                        blockSize = bytesRemaining;
                        nextStep = 4; // Back to step 4, setting the patch length
                    }
                }
            
                [manager writeValueWithoutResponse:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_PATCH_DATA_CBUUID data:byteData];
            }
            
            break;
        }
            
        case 6: {
            // Send SUOTA END command
            step = 0;
            expectedValue = 0x02;
            nextStep = 7;

            uint32_t suotaEnd = 0xFE000000;
            [self debug:[NSString stringWithFormat:@"Send SUOTA END command: %#010x", suotaEnd] UILog:YES];
            NSData *suotaEndData = [NSData dataWithBytes:&suotaEnd length:sizeof(uint32_t)];
            [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_MEM_DEV_CBUUID data:suotaEndData];
            break;
        }
            
        case 7: {
            [self debug:@"Upload completed" UILog:YES];
            NSTimeInterval elapsed = [[NSDate date] timeIntervalSinceDate:uploadStart];
            [self debug:[NSString stringWithFormat:@"Elapsed time: %.3f", elapsed] UILog:YES];
            // Wait for user to confirm reboot
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Device has been updated" message:@"Do you wish to reboot the device?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes, reboot", nil];
            [alert setTag:UIALERTVIEW_TAG_REBOOT];
            [alert show];
            break;
        }
            
        case 8: {
            // Go back to overview of devices
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == UIALERTVIEW_TAG_REBOOT) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            // Send reboot signal to device
            step = 8;
            uint32_t suotaReboot = 0xFD000000;
            [self debug:[NSString stringWithFormat:@"Send SUOTA REBOOT command: %#010x", suotaReboot] UILog:YES];
            NSData *suotaRebootData = [NSData dataWithBytes:&suotaReboot length:sizeof(uint32_t)];
            [manager writeValue:GenericServiceManager.SPOTA_SERVICE_CBUUID characteristicUUID:GenericServiceManager.SPOTA_MEM_DEV_CBUUID data:suotaRebootData];
        }
    }
}

- (void) debug:(NSString*)message UILog:(BOOL)uiLog {
    if (uiLog) {
        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"\n%@", message]];
        [self.textView scrollRangeToVisible:NSMakeRange([self.textView.text length], 0)];
    }
    NSLog(@"%@", message);
}

- (void) appendChecksum {
    uint8_t crc_code = 0;
    
    const char *bytes = [fileData bytes];
    for (int i = 0; i < [fileData length]; i++) {
        crc_code ^= bytes[i];
    }
    
    [self debug:[NSString stringWithFormat:@"Checksum for file: %#4x", crc_code] UILog:YES];
    
    [fileData appendBytes:&crc_code length:sizeof(uint8_t)];
}

@end
