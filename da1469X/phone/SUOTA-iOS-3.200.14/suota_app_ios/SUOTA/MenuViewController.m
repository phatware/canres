/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "MenuViewController.h"
#import "BluetoothManager.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDisconnectFromDevice:)
                                                 name:BluetoothManagerDisconnectedFromDevice
                                               object:nil];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)disconnect:(id)sender {
    BluetoothManager *manager = [BluetoothManager getInstance];
    manager.userDisconnect = YES;
    [manager disconnectDevice];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) didDisconnectFromDevice:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BluetoothManagerDisconnectedFromDevice object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
