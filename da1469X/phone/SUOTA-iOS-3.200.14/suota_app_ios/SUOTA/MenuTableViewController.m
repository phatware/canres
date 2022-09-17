/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "MenuTableViewController.h"
#import "AppDelegate.h"
#import "DeviceViewController.h"
#import "APLSlideMenuViewController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController* navigationController = (UINavigationController*)self.slideMenuController.contentViewController;
        UIViewController *vc;

        // Save DeviceViewController if it is the current view
        if (!self.suota && [navigationController.topViewController isKindOfClass:[DeviceViewController class]])
            self.suota = navigationController.topViewController;
        
        switch (indexPath.section) {
            case 0: {
                switch (indexPath.row) {
                    case 0:
                        if (!self.suota)
                            self.suota = [self.storyboard instantiateViewControllerWithIdentifier:@"DeviceViewController"];
                        vc = self.suota;
                        break;
                }
                break;
            }
                
            case 1: {
                switch (indexPath.row) {
                    case 0:
                        if (!self.info)
                            self.info = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
                        vc = self.info;
                        break;
                        
                    case 1:
                        if (!self.disclaimer)
                            self.disclaimer = [self.storyboard instantiateViewControllerWithIdentifier:@"DisclaimerViewController"];
                        vc = self.disclaimer;
                        break;
                }
                break;
            }
        }

        [navigationController setViewControllers:@[vc] animated:NO];
        [self.slideMenuController hideMenu:YES];
    });
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
