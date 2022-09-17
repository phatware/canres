/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "BluetoothManager.h"
#import "Defines.h"
#import "DeviceStorage.h"

NSString * const BluetoothManagerReceiveDevices         = @"BluetoothManagerReceiveDevices";
NSString * const BluetoothManagerConnectingToDevice     = @"BluetoothManagerConnectingToDevice";
NSString * const BluetoothManagerConnectedToDevice      = @"BluetoothManagerConnectedToDevice";
NSString * const BluetoothManagerDisconnectedFromDevice = @"BluetoothManagerDisconnectedFromDevice";
NSString * const BluetoothManagerConnectionFailed       = @"BluetoothManagerConnectionFailed";

static BluetoothManager *instance;

@implementation BluetoothManager

@synthesize bluetoothReady, device;

+ (BluetoothManager*) getInstance {
    if (!instance)
        instance = [[BluetoothManager alloc] init];
    return instance;
}

+ (void) destroyInstance {
    instance = nil;
}

- (id) init {
    self = [super init];
    if (self) {
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
        mainServiceUUID = [BluetoothManager sigUUIDToCBUUID:SPOTA_SERVICE_UUID];
        homekitUUID = [BluetoothManager sigUUIDToCBUUID:HOMEKIT_UUID];
        knownPeripherals = [[NSMutableArray alloc] init];
        instance = self;
    }
    
    return self;
}

- (void) connectToDevice: (CBPeripheral*) _device {
    self.device = _device;
    
    NSDictionary *options = @{CBConnectPeripheralOptionNotifyOnDisconnectionKey: @TRUE};
    [manager connectPeripheral:_device options:options];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BluetoothManagerConnectingToDevice object:_device];
}

- (void) disconnectDevice {
    if (self.device.state != CBPeripheralStateConnected && self.device.state != CBPeripheralStateConnecting) {
        return;
    }
    [manager cancelPeripheralConnection:self.device];
}

- (void) startScanning {
    if (!self.bluetoothReady) {
        NSLog(@"Bluetooth not yet ready, trying again in a few seconds...");
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startScanning) object:nil];
        [self performSelector:@selector(startScanning) withObject:nil afterDelay:1.0];
        return;
    }

    NSLog(@"Started scanning for devices ...");
    
    knownPeripherals = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:BluetoothManagerReceiveDevices object:knownPeripherals];
    
    NSArray* uuids = @[ mainServiceUUID, homekitUUID ];
    NSDictionary* options = @{ CBCentralManagerScanOptionAllowDuplicatesKey : @NO };
    
    [manager scanForPeripheralsWithServices:uuids options:options];
}

- (void) stopScanning {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startScanning) object:nil];
    [manager stopScan];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    bluetoothReady = FALSE;
    switch (manager.state) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CoreBluetooth BLE hardware is powered off");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
            self.bluetoothReady = TRUE;
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CoreBluetooth BLE hardware is resetting");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"CoreBluetooth BLE state is unauthorized");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CoreBluetooth BLE state is unknown");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
            break;
        default:
            NSLog(@"Unknown state");
            break;
    }
}

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Discovered item %@ (advertisement: %@)", peripheral, advertisementData);
    
    NSArray *services = [advertisementData valueForKey:CBAdvertisementDataServiceUUIDsKey];
    NSArray *servicesOvfl = [advertisementData valueForKey:CBAdvertisementDataOverflowServiceUUIDsKey];
    if ([services containsObject:mainServiceUUID] || [servicesOvfl containsObject:mainServiceUUID]) {
        NSLog(@"%@ [%@]: Found SUOTA service UUID in advertising data", peripheral.name, peripheral.identifier.UUIDString);
    }
    if ([services containsObject:homekitUUID] || [servicesOvfl containsObject:homekitUUID]) {
        NSLog(@"%@ [%@]: Found HomeKit service UUID in advertising data", peripheral.name, peripheral.identifier.UUIDString);
    }

    [peripheral setValue:RSSI forKey:@"RSSI"];
    if (![knownPeripherals containsObject:peripheral]) {
        [knownPeripherals addObject:peripheral];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BluetoothManagerReceiveDevices object:knownPeripherals];
}

- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Did connect device: %@", peripheral);
    
    self.userDisconnect = NO;
    GenericServiceManager *m = [[DeviceStorage sharedInstance] deviceManagerWithIdentifier:[peripheral.identifier UUIDString]];
    if (m == nil) {
        m = [[GenericServiceManager alloc] initWithDevice:peripheral andManager:self];
    }
    [m setDevice:peripheral];

    [[NSNotificationCenter defaultCenter] postNotificationName:BluetoothManagerConnectedToDevice object:peripheral];
}

- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Disconnected device");
    [[NSNotificationCenter defaultCenter] postNotificationName:BluetoothManagerDisconnectedFromDevice object:peripheral];
}

- (void) centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Error connecting device");
    [[NSNotificationCenter defaultCenter] postNotificationName:BluetoothManagerConnectionFailed object:peripheral];
}

+ (uint16_t) sigUUIDFromCBUUID:(CBUUID*)UUID {
    const uint8_t* b = UUID.data.bytes;
    return UUID.data.length == 2 ? (b[0] << 8) | b[1] : (uint16_t) 0;
}

+ (CBUUID*) sigUUIDToCBUUID:(uint16_t)UUID {
    uint8_t b[2] = { (UUID >> 8) & 0xff, UUID & 0xff };
    return [CBUUID UUIDWithData:[NSData dataWithBytes:b length:2]];
}

@end
