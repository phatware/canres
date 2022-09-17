/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "GenericServiceManager.h"
#import "SUOTAServiceManager.h"
#import "DeviceInfoViewController.h"

@interface DeviceViewController : UIViewController {
    SUOTAServiceManager *suotaServiceManager;
    DeviceInfoViewController *containerView;
}

@property (strong) GenericServiceManager *serviceManager;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;

- (IBAction)showMenu:(id)sender;

@end
