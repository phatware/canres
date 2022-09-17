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

extern NSString * const BluetoothManagerReceiveDevices;
extern NSString * const BluetoothManagerConnectingToDevice;
extern NSString * const BluetoothManagerConnectedToDevice;
extern NSString * const BluetoothManagerDisconnectedFromDevice;
extern NSString * const BluetoothManagerConnectionFailed;

@interface BluetoothManager : NSObject <CBCentralManagerDelegate> {
    CBCentralManager *manager;
    CBUUID *mainServiceUUID;
    CBUUID *homekitUUID;
    NSMutableArray *knownPeripherals;
}

@property BOOL bluetoothReady;
@property BOOL userDisconnect;
@property (nonatomic, retain) CBPeripheral *device;

+ (BluetoothManager*) getInstance;
+ (void) destroyInstance;

- (void) connectToDevice: (CBPeripheral*) device;
- (void) disconnectDevice;

- (void) startScanning;
- (void) stopScanning;

- (void) centralManagerDidUpdateState:(CBCentralManager *)central;
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;
- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
- (void) centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;

+ (uint16_t) sigUUIDFromCBUUID:(CBUUID*)UUID;
+ (CBUUID*) sigUUIDToCBUUID:(uint16_t)UUID;

@end
