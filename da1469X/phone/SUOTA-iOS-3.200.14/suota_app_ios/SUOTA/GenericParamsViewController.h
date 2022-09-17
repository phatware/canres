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
#import "ActionSheetStringPicker.h"

@interface GenericParamsViewController : UIViewController

- (void) selectItemFromListForTextField:(UITextField*)textField withTitle:(NSString*)title;
- (void) gpioScannerWithString:(NSString*)gpio toInt:(unsigned*)output;

@end
