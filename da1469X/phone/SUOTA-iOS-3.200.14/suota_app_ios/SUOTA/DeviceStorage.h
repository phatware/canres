/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "GenericServiceManager.h"
#import <UIKit/UIKit.h>

extern NSString * const DeviceStorageUpdated;

@interface DeviceStorage : NSObject

+ (DeviceStorage*) sharedInstance;
- (id) init;

- (CBPeripheral*) deviceForIndex: (int) index;
- (GenericServiceManager*) deviceManagerForIndex: (int)index;
- (GenericServiceManager*) deviceManagerWithIdentifier:(NSString*)identifier;
- (int) indexOfDevice:(CBPeripheral*) device;
- (int) indexOfIdentifier:(NSString*) identifier;

@property NSMutableArray* devices;

@end
