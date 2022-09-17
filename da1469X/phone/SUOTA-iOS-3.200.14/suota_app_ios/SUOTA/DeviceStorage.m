/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "DeviceStorage.h"
#import "BluetoothManager.h"

NSString * const DeviceStorageUpdated = @"DeviceStorageUpdated";

@implementation DeviceStorage

static DeviceStorage* sharedDeviceStorage = nil;

+ (DeviceStorage*) sharedInstance {
    if (sharedDeviceStorage == nil) {
        sharedDeviceStorage = [[DeviceStorage alloc] init];
    }
    return sharedDeviceStorage;
}

- (id) init {
    if (self = [super init]) {
        self.devices = [[NSMutableArray alloc] init];
                
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDevices:)
                                                     name:BluetoothManagerReceiveDevices
                                                   object:nil];
    }
    return self;
}

- (void) receiveDevices:(NSNotification *) notification {
    [self.devices removeAllObjects];
    
    for (CBPeripheral *device in [notification object]) {
        GenericServiceManager *dm = [self deviceManagerWithIdentifier:[device.identifier UUIDString]];
        dm.device = device;
        
        if (!dm) {
            dm = [[GenericServiceManager alloc] initWithDevice:device andManager:[BluetoothManager getInstance]];
            [self.devices addObject:dm];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DeviceStorageUpdated object:self];
}

#pragma mark - Storage

- (CBPeripheral*) deviceForIndex: (int)index {
    GenericServiceManager *deviceManager = self.devices[index];
    return deviceManager.device;
}

- (GenericServiceManager*) deviceManagerForIndex: (int)index {
    GenericServiceManager *deviceManager = self.devices[index];
    return deviceManager;
}

- (GenericServiceManager*) deviceManagerWithIdentifier:(NSString*)identifier {
    for (GenericServiceManager *device in self.devices) {
        if ([device.identifier isEqualToString:identifier]) {
            return device;
        }
    }
    return nil;
}

- (int) indexOfDevice:(CBPeripheral*) device {
    for (int n=0; n < [self.devices count]; n++) {
        CBPeripheral *p = [self deviceForIndex:n];
        if (p == device)
            return n;
    }
    return -1;
}

- (int) indexOfIdentifier:(NSString*) identifier {
    for (int n=0; n < [self.devices count]; n++) {
        GenericServiceManager *p = [self deviceManagerForIndex:n];
        if ([p.identifier isEqualToString:identifier])
            return n;
    }
    return -1;
}

@end
