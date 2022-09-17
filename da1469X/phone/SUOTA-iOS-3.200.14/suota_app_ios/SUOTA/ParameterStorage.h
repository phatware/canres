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
#import "SUOTAServiceManager.h"
#import "Defines.h"

@interface ParameterStorage : NSObject

+ (ParameterStorage*) getInstance;
- (id) init;

@property CBPeripheral *device;
@property SUOTAServiceManager *manager;

@property NSURL *file_url;
@property TYPE_SUOTA_OR_SPOTA type;

@property MEM_TYPE mem_type;
@property MEM_BANK mem_bank;
@property UInt16 block_size;

@property UInt16 patch_base_address;
@property UInt16 i2c_device_address;
@property UInt32 spi_device_address; // Is actually 24 bits

@property GPIO gpio_scl;
@property GPIO gpio_sda;
@property GPIO gpio_miso;
@property GPIO gpio_mosi;
@property GPIO gpio_cs;
@property GPIO gpio_sck;


@end
