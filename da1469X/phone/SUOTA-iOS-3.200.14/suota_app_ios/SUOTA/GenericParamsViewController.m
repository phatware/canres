/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "GenericParamsViewController.h"
#import "BluetoothManager.h"

static NSArray<NSString*>* gpioTitles;
static NSArray<NSNumber*>* gpioValues;

@implementation GenericParamsViewController

+ (void) initialize {
    if (self != [GenericParamsViewController class])
        return;

    gpioTitles = @[
            @"P0_0", @"P0_1", @"P0_2", @"P0_3", @"P0_4", @"P0_5", @"P0_6", @"P0_7", @"P0_8", @"P0_9", @"P0_10", @"P0_11",
            @"P1_0", @"P1_1", @"P1_2", @"P1_3",
            @"P2_0", @"P2_1", @"P2_2", @"P2_3", @"P2_4", @"P2_5", @"P2_6", @"P2_7", @"P2_8", @"P2_9",
            @"P3_0", @"P3_1", @"P3_2", @"P3_3", @"P3_4", @"P3_5", @"P3_6", @"P3_7"
    ];

    gpioValues = @[
            @0x00, @0x01, @0x02, @0x03, @0x04, @0x05, @0x06, @0x07, @0x08, @0x09, @0x0A, @0x0B,
            @0x10, @0x11, @0x12, @0x13,
            @0x20, @0x21, @0x22, @0x23, @0x24, @0x25, @0x26, @0x27, @0x28, @0x29,
            @0x30, @0x31, @0x32, @0x33, @0x34, @0x35, @0x36, @0x37
    ];
}

- (void) selectItemFromListForTextField:(UITextField*)textField withTitle:(NSString*)title {
    NSInteger initialSelection = 0;
    for (int n = 0; n < gpioTitles.count; n++) {
        if ([textField.text isEqualToString:gpioTitles[n]]) {
            initialSelection = n;
            break;
        }
    }

    [ActionSheetStringPicker showPickerWithTitle:title
                                            rows:gpioTitles
                                initialSelection:initialSelection
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [textField setText:gpioTitles[selectedIndex]];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                     }
                                          origin:textField];
}

- (void) gpioScannerWithString:(NSString*)gpio toInt:(unsigned*)output {
    for (int n = 0; n < gpioTitles.count; n++) {
        if ([gpio isEqualToString:gpioTitles[n]]) {
            *output = gpioValues[n].unsignedIntValue;
            break;
        }
    }
}

@end
