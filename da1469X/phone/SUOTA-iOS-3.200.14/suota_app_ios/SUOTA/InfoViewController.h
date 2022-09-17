/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import <UIKit/UIKit.h>
#import "GenericServiceManager.h"

@interface InfoViewController : UITableViewController {
    GenericServiceManager *serviceManager;
}

@property (weak, nonatomic) IBOutlet UILabel *supportMailLabel;
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;

- (IBAction)showMenu:(id)sender;

@end
