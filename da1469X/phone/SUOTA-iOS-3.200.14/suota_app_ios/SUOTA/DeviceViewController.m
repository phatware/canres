/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "DeviceViewController.h"
#import "Defines.h"
#import "DeviceStorage.h"
#import "BluetoothManager.h"
#import "ParameterStorage.h"
#import "SUOTAViewController.h"
#import "APLSlideMenuViewController.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CBPeripheral *device = [BluetoothManager getInstance].device;
    int index = [[DeviceStorage sharedInstance] indexOfDevice:device];
    self.serviceManager = [[DeviceStorage sharedInstance] deviceManagerForIndex:index];
    
    [containerView.deviceNameTextLabel setText:self.serviceManager.deviceName];
    [self.updateButton setHidden:NO];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDisconnectFromDevice:)
                                                 name:BluetoothManagerDisconnectedFromDevice
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdateValue:)
                                                 name:GenericServiceManagerDidReceiveValue
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(suotaServiceNotFound:)
                                                 name:SUOTAServiceNotFound
                                               object:nil];

    suotaServiceManager = [[SUOTAServiceManager alloc] initWithDevice:self.serviceManager.device];
    [suotaServiceManager discoverServices];
    
    ParameterStorage *storage = [ParameterStorage getInstance];
    storage.device = self.serviceManager.device;
    storage.manager = suotaServiceManager;
}

- (void) didDisconnectFromDevice:(NSNotification*)notification {
    if (![BluetoothManager getInstance].userDisconnect && ![self.navigationController.topViewController isKindOfClass:[SUOTAViewController class]]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Disconnected" message:@"The connection to the remote device was lost." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BluetoothManagerDisconnectedFromDevice object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GenericServiceManagerDidReceiveValue object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SUOTAServiceNotFound object:nil];
}

- (void) didUpdateValue:(NSNotification*)notification {
    CBCharacteristic *characteristic = (CBCharacteristic*)notification.object;
    
    switch ([BluetoothManager sigUUIDFromCBUUID:characteristic.UUID]) {
        case ORG_BLUETOOTH_CHARACTERISTIC_MANUFACTURER_NAME_STRING: {
            NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];            
            if ([value isEqualToString:@"Dialog Semi"]) {
                value = @"Dialog Semiconductor";
            }
            [containerView.manufacturerNameTextLabel setText:value];
            break;
        }
            
        case ORG_BLUETOOTH_CHARACTERISTIC_MODEL_NUMBER_STRING: {
            NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
            [containerView.modelNumberTextLabel setText:value];
            break;
        }
            
        case ORG_BLUETOOTH_CHARACTERISTIC_FIRMWARE_REVISION_STRING: {
            NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
            [containerView.firmwareRevisionTextLabel setText:value];
            break;
        }
            
        case ORG_BLUETOOTH_CHARACTERISTIC_SOFTWARE_REVISION_STRING: {
            NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
            [containerView.softwareRevisionTextLabel setText:value];
            break;
        }
    }
}

- (void) suotaServiceNotFound:(NSNotification*)notification {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This device does not appear to support the SUOTA service." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    [self.updateButton setHidden:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"containerView"]) {
        containerView = segue.destinationViewController;
    }
}


- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // Back button pressed, so disconnect device
        [self.serviceManager disconnect];
    }
}

- (IBAction)showMenu:(id)sender {
    [self.slideMenuController showLeftMenu:YES];
}

@end
