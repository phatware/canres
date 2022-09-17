/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "SUOTAServiceManager.h"
#import "Defines.h"

NSString * const SUOTAServiceNotFound = @"SUOTAServiceNotFound";

@implementation SUOTAServiceManager

- (void) peripheral:(CBPeripheral *)_peripheral didDiscoverServices:(NSError *)error {
    NSArray *services = [_peripheral services];
    
    for (CBService *service in services) {
        if ([service.UUID isEqual:GenericServiceManager.SPOTA_SERVICE_CBUUID]) {
            self.suotaReady = TRUE;
        }
    }
    
    [super peripheral:_peripheral didDiscoverServices:error];
    
    if (!self.suotaReady) {
        // It appears this device does not support the SUOTA service.
        [[NSNotificationCenter defaultCenter] postNotificationName:SUOTAServiceNotFound object:_peripheral];
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSArray *characteristics = [service characteristics];
    for (CBCharacteristic *characteristic in characteristics) {
        NSLog(@"Characteristic UUID: %@", characteristic.UUID);
        if ([characteristic.UUID isEqual:GenericServiceManager.SPOTA_MEM_DEV_CBUUID]) {
            NSLog(@"MEM DEV FOUND!");
        }
    }
    
    [super peripheral:peripheral didDiscoverCharacteristicsForService:service error:error];
}

@end
