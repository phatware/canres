/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "InfoViewController.h"
#import "APLSlideMenuViewController.h"
#import "DeviceStorage.h"
#import "Defines.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    //NSString * build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    [self.appVersionLabel setText:[NSString stringWithFormat:@"%@", version]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        /* define email address */
        NSString *mail = @"bluetooth.support@diasemi.com";
        NSString *subject = @"SUOTA application question";

        /* create the URL */
        NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"mailto:%@?subject=%@", mail,
                                                    [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];

        /* load the URL */
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)showMenu:(id)sender {
    [self.slideMenuController showLeftMenu:YES];
}

@end
