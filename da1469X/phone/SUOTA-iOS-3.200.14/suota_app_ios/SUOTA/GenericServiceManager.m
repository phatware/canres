/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "GenericServiceManager.h"
#import "BluetoothManager.h"
#import "Defines.h"

NSString * const GenericServiceManagerDidReceiveValue         = @"GenericServiceManagerDidReceiveValue";
NSString * const GenericServiceManagerDidSendValue            = @"GenericServiceManagerDidSendValue";
NSString * const GenericServiceManagerReadError               = @"GenericServiceManagerReadError";
NSString * const GenericServiceManagerWriteError              = @"GenericServiceManagerWriteError";

static CBUUID* SPOTA_SERVICE_CBUUID;
static CBUUID* SPOTA_MEM_DEV_CBUUID;
static CBUUID* SPOTA_GPIO_MAP_CBUUID;
static CBUUID* SPOTA_MEM_INFO_CBUUID;
static CBUUID* SPOTA_PATCH_LEN_CBUUID;
static CBUUID* SPOTA_PATCH_DATA_CBUUID;
static CBUUID* SPOTA_SERV_STATUS_CBUUID;
static CBUUID* SUOTA_VERSION_CBUUID;
static CBUUID* SUOTA_PATCH_DATA_CHAR_SIZE_CBUUID;
static CBUUID* SUOTA_MTU_CBUUID;
static CBUUID* SUOTA_L2CAP_PSM_CBUUID;

@implementation GenericServiceManager

@synthesize device, deviceName;

+ (void) initialize {
    if (self != [GenericServiceManager class])
        return;

    SPOTA_SERVICE_CBUUID = [BluetoothManager sigUUIDToCBUUID:SPOTA_SERVICE_UUID];
    SPOTA_MEM_DEV_CBUUID = [CBUUID UUIDWithString:SPOTA_MEM_DEV_UUID];
    SPOTA_GPIO_MAP_CBUUID = [CBUUID UUIDWithString:SPOTA_GPIO_MAP_UUID];
    SPOTA_MEM_INFO_CBUUID = [CBUUID UUIDWithString:SPOTA_MEM_INFO_UUID];
    SPOTA_PATCH_LEN_CBUUID = [CBUUID UUIDWithString:SPOTA_PATCH_LEN_UUID];
    SPOTA_PATCH_DATA_CBUUID = [CBUUID UUIDWithString:SPOTA_PATCH_DATA_UUID];
    SPOTA_SERV_STATUS_CBUUID = [CBUUID UUIDWithString:SPOTA_SERV_STATUS_UUID];
    SUOTA_VERSION_CBUUID = [CBUUID UUIDWithString:SUOTA_VERSION_UUID];
    SUOTA_PATCH_DATA_CHAR_SIZE_CBUUID = [CBUUID UUIDWithString:SUOTA_PATCH_DATA_CHAR_SIZE_UUID];
    SUOTA_MTU_CBUUID = [CBUUID UUIDWithString:SUOTA_MTU_UUID];
    SUOTA_L2CAP_PSM_CBUUID = [CBUUID UUIDWithString:SUOTA_L2CAP_PSM_UUID];
}

- (id) initWithDevice:(CBPeripheral*)_device {
    return [self initWithDevice:_device andManager:[BluetoothManager getInstance]];
}

- (id) initWithDevice:(CBPeripheral*)_device andManager:(BluetoothManager*)_manager {
    self = [super init];
    if (self) {
        manager = _manager;
        device = _device;
        device.delegate = self;

        self.deviceName = self.device.name;
        self.suotaVersion = 0;
        self.suotaMtu = DEFAULT_MTU;
        self.suotaPatchDataSize = DEFAULT_FILE_CHUNK_SIZE;
        self.suotaL2CapPsm = 0;
    }
    return self;
}

- (void) setDevice:(CBPeripheral*)_device {
    device = _device;
}

- (void) updateRSSI {
    if (self.device.state == CBPeripheralStateConnected)
        [self.device readRSSI];
}

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
    self.RSSI = RSSI.doubleValue;
    [self.delegate didUpdateData:self.device];
}

- (void) discoverServices {
    device.delegate = self;
    [device discoverServices:nil];
}

- (void) peripheral:(CBPeripheral *)_peripheral didDiscoverServices:(NSError *)error {
    NSArray *services = [_peripheral services];
    
    for (CBService *service in services) {
        NSLog(@"Services %@ (%@)", [service UUID], service);
        [device discoverCharacteristics:nil forService:service];
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"Characteristics for service %@ (%@)", service.UUID, service);
    // Read device info
    if ([BluetoothManager sigUUIDFromCBUUID:service.UUID] == ORG_BLUETOOTH_SERVICE_DEVICE_INFORMATION) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSLog(@" -- Characteristic %@ (%@)", characteristic.UUID, characteristic);
            switch ([BluetoothManager sigUUIDFromCBUUID:characteristic.UUID]) {
                case ORG_BLUETOOTH_CHARACTERISTIC_MANUFACTURER_NAME_STRING:
                case ORG_BLUETOOTH_CHARACTERISTIC_MODEL_NUMBER_STRING:
                case ORG_BLUETOOTH_CHARACTERISTIC_FIRMWARE_REVISION_STRING:
                case ORG_BLUETOOTH_CHARACTERISTIC_SOFTWARE_REVISION_STRING:
                    [self readValue:service.UUID characteristicUUID:characteristic.UUID];
                    break;
            }
        }
    }
    // Read SUOTA info
    if ([BluetoothManager sigUUIDFromCBUUID:service.UUID] == SPOTA_SERVICE_UUID) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSLog(@" -- Characteristic %@ (%@)", characteristic.UUID, characteristic);
            if ([characteristic.UUID isEqual:GenericServiceManager.SUOTA_VERSION_CBUUID]
                || [characteristic.UUID isEqual:GenericServiceManager.SUOTA_PATCH_DATA_CHAR_SIZE_CBUUID]
                || [characteristic.UUID isEqual:GenericServiceManager.SUOTA_MTU_CBUUID]
                || [characteristic.UUID isEqual:GenericServiceManager.SUOTA_L2CAP_PSM_CBUUID]) {
                [self readValue:service.UUID characteristicUUID:characteristic.UUID];
            }
        }
    }

    [self.delegate deviceReady:self.device];
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        NSLog(@"Value for %@ is %@", characteristic.UUID, characteristic.value);

        // Check for SUOTA info
        if ([characteristic.UUID isEqual:GenericServiceManager.SUOTA_VERSION_CBUUID]) {
            uint8_t value = 0;
            [characteristic.value getBytes:&value length:1];
            self.suotaVersion = value;
            NSLog(@"SUOTA version: %d", self.suotaVersion);
        } else if ([characteristic.UUID isEqual:GenericServiceManager.SUOTA_PATCH_DATA_CHAR_SIZE_CBUUID]) {
            uint8_t value[2] = { DEFAULT_FILE_CHUNK_SIZE, 0 };
            [characteristic.value getBytes:&value length:2];
            self.suotaPatchDataSize = (value[1] << 8) | value[0];
            NSLog(@"SUOTA patch data size: %d", self.suotaPatchDataSize);
        } else if ([characteristic.UUID isEqual:GenericServiceManager.SUOTA_MTU_CBUUID]) {
            uint8_t value[2] = { DEFAULT_MTU, 0 };
            [characteristic.value getBytes:&value length:2];
            self.suotaMtu = (value[1] << 8) | value[0];
            NSLog(@"SUOTA MTU: %d", self.suotaMtu);
        } else if ([characteristic.UUID isEqual:GenericServiceManager.SUOTA_L2CAP_PSM_CBUUID]) {
            uint8_t value[2] = { 0, 0 };
            [characteristic.value getBytes:&value length:2];
            self.suotaL2CapPsm = (value[1] << 8) | value[0];
            NSLog(@"SUOTA L2CAP PSM: %d", self.suotaL2CapPsm);
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:GenericServiceManagerDidReceiveValue object:characteristic];
    } else {
        NSLog(@"Failed to read characteristic %@", characteristic.UUID);
        [[NSNotificationCenter defaultCenter] postNotificationName:GenericServiceManagerReadError object:characteristic];
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        NSLog(@"Data written successfully");
        [[NSNotificationCenter defaultCenter] postNotificationName:GenericServiceManagerDidSendValue object:characteristic];
    } else {
        NSLog(@"Failed to write characteristic %@", characteristic.UUID);
        [[NSNotificationCenter defaultCenter] postNotificationName:GenericServiceManagerWriteError object:characteristic];
    }
}

- (void) connect {
    [manager connectToDevice:self.device];
}

- (void) disconnect {
    [manager disconnectDevice];
}

- (NSString *) deviceName {
    if (!deviceName)
        return self.device.name;
    return deviceName;
}

- (void) writeValue:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID data:(NSData*)data {
    [self writeValue:serviceUUID characteristicUUID:characteristicUUID data:data type:CBCharacteristicWriteWithResponse];
}

- (void) writeValueWithoutResponse:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID data:(NSData*)data {
    [self writeValue:serviceUUID characteristicUUID:characteristicUUID data:data type:CBCharacteristicWriteWithoutResponse];
}

- (void) writeValue:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID data:(NSData*)data type:(CBCharacteristicWriteType)responseType {
    CBService* service = [self findServiceWithUUID:serviceUUID];
    if (!service) {
        NSLog(@"Could not find service with UUID %@", serviceUUID.UUIDString);
        return;
    }

    CBCharacteristic* characteristic = [self findCharacteristicWithUUID:characteristicUUID forService:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %@", characteristicUUID.UUIDString);
        return;
    }

    [self.device writeValue:data forCharacteristic:characteristic type:responseType];
}

- (void) readValue:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID {
    CBService* service = [self findServiceWithUUID:serviceUUID];
    if (!service) {
        NSLog(@"Could not find service with UUID %@", serviceUUID.UUIDString);
        return;
    }

    CBCharacteristic* characteristic = [self findCharacteristicWithUUID:characteristicUUID forService:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %@", characteristicUUID.UUIDString);
        return;
    }

    [self.device readValueForCharacteristic:characteristic];
}

- (void) setNotifications:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID enable:(BOOL)enable {
    CBService* service = [self findServiceWithUUID:serviceUUID];
    if (!service) {
        NSLog(@"Could not find service with UUID %@", serviceUUID.UUIDString);
        return;
    }

    CBCharacteristic* characteristic = [self findCharacteristicWithUUID:characteristicUUID forService:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %@", characteristicUUID.UUIDString);
        return;
    }

    [self.device setNotifyValue:enable forCharacteristic:characteristic];
}

- (CBService*) findServiceWithUUID:(CBUUID*)UUID {
    for (CBService* service in self.device.services) {
        if ([service.UUID isEqual:UUID])
            return service;
    }
    return nil;
}

- (CBCharacteristic*) findCharacteristicWithUUID:(CBUUID*)UUID forService:(CBService*)service {
    for (CBCharacteristic* characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:UUID])
            return characteristic;
    }
    return nil;
}

+ (CBUUID*) SPOTA_SERVICE_CBUUID {
    return SPOTA_SERVICE_CBUUID;
}

+ (CBUUID*) SPOTA_MEM_DEV_CBUUID {
    return SPOTA_MEM_DEV_CBUUID;
}

+ (CBUUID*) SPOTA_GPIO_MAP_CBUUID {
    return SPOTA_GPIO_MAP_CBUUID;
}

+ (CBUUID*) SPOTA_MEM_INFO_CBUUID {
    return SPOTA_MEM_INFO_CBUUID;
}

+ (CBUUID*) SPOTA_PATCH_LEN_CBUUID {
    return SPOTA_PATCH_LEN_CBUUID;
}

+ (CBUUID*) SPOTA_PATCH_DATA_CBUUID {
    return SPOTA_PATCH_DATA_CBUUID;
}

+ (CBUUID*) SPOTA_SERV_STATUS_CBUUID {
    return SPOTA_SERV_STATUS_CBUUID;
}

+ (CBUUID*) SUOTA_VERSION_CBUUID {
    return SUOTA_VERSION_CBUUID;
}

+ (CBUUID*) SUOTA_PATCH_DATA_CHAR_SIZE_CBUUID {
    return SUOTA_PATCH_DATA_CHAR_SIZE_CBUUID;
}

+ (CBUUID*) SUOTA_MTU_CBUUID {
    return SUOTA_MTU_CBUUID;
}

+ (CBUUID*) SUOTA_L2CAP_PSM_CBUUID {
    return SUOTA_L2CAP_PSM_CBUUID;
}

@end
