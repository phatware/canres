/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "DeviceTableViewCell.h"

@implementation DeviceTableViewCell

- (void) awakeFromNib {
    [super awakeFromNib];
    if (UIDevice.currentDevice.systemVersion.floatValue < 13) {
        self.deviceRangeViewTrailing.constant = 15;
    }
}

@end
