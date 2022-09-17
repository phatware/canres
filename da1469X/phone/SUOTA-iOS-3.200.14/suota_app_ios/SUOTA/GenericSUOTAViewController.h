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
#import "Defines.h"

@interface GenericSUOTAViewController : UIViewController

- (NSString*) getErrorMessage:(SPOTA_STATUS_VALUES)status;

@end
