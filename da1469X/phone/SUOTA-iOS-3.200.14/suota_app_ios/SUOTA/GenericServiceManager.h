/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BluetoothManager.h"

extern NSString * const GenericServiceManagerDidReceiveValue;
extern NSString * const GenericServiceManagerDidSendValue;
extern NSString * const GenericServiceManagerReadError;
extern NSString * const GenericServiceManagerWriteError;

@protocol GenericServiceDelegate
- (void) deviceReady:(id)device;
- (void) didUpdateData:(id)device;
@end

@interface GenericServiceManager : NSObject <CBPeripheralDelegate> {
    BluetoothManager* manager;
}

@property (weak, nonatomic) id<GenericServiceDelegate> delegate;
@property (weak, nonatomic) CBPeripheral* device;
@property double RSSI;
@property (nonatomic) NSString* deviceName;
@property (nonatomic) NSString* identifier;
@property int suotaVersion;
@property int suotaMtu;
@property int suotaPatchDataSize;
@property int suotaL2CapPsm;

- (id) initWithDevice:(CBPeripheral*)_device;
- (id) initWithDevice:(CBPeripheral*)device andManager:(BluetoothManager*)manager;

- (void) connect;
- (void) disconnect;
- (void) discoverServices;

- (void) writeValue:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID data:(NSData*)data;
- (void) writeValueWithoutResponse:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID data:(NSData*)data;
- (void) readValue:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID;
- (void) setNotifications:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID enable:(BOOL)enable;

@property (class, readonly) CBUUID* SPOTA_SERVICE_CBUUID;
@property (class, readonly) CBUUID* SPOTA_MEM_DEV_CBUUID;
@property (class, readonly) CBUUID* SPOTA_GPIO_MAP_CBUUID;
@property (class, readonly) CBUUID* SPOTA_MEM_INFO_CBUUID;
@property (class, readonly) CBUUID* SPOTA_PATCH_LEN_CBUUID;
@property (class, readonly) CBUUID* SPOTA_PATCH_DATA_CBUUID;
@property (class, readonly) CBUUID* SPOTA_SERV_STATUS_CBUUID;
@property (class, readonly) CBUUID* SUOTA_VERSION_CBUUID;
@property (class, readonly) CBUUID* SUOTA_PATCH_DATA_CHAR_SIZE_CBUUID;
@property (class, readonly) CBUUID* SUOTA_MTU_CBUUID;
@property (class, readonly) CBUUID* SUOTA_L2CAP_PSM_CBUUID;

@end
