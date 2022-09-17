/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "DeviceTableViewController.h"
#import "BluetoothManager.h"
#import "DeviceStorage.h"
#import "DeviceViewController.h"
#import "DeviceTableViewCell.h"

#import "APLSlideMenuViewController.h"
#import "MBProgressHUD.h"

@interface DeviceTableViewController () {
    NSTimer *scanTimer;
    NSTimer *connectTimer;
    int selected;
}
@end

@implementation DeviceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [BluetoothManager getInstance];
    selected = -1;

    if ([DeviceStorage sharedInstance].devices.count == 0)
        [self onRefresh];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor colorWithRed:0.2 green:0.48 blue:0.72 alpha:1];
    [self.refreshControl addTarget:self
                            action:@selector(onRefresh)
                  forControlEvents:UIControlEventValueChanged];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdateDeviceList:)
                                                 name:DeviceStorageUpdated
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didConnectToDevice:)
                                                 name:BluetoothManagerConnectedToDevice
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFailToConnectToDevice:)
                                                 name:BluetoothManagerConnectionFailed
                                               object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopScanning];
    [self cancelConnection];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DeviceStorageUpdated object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BluetoothManagerConnectedToDevice object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BluetoothManagerConnectionFailed object:nil];
}

- (void) didUpdateDeviceList:(NSNotification*)notification {
    NSLog(@"Retrieved devices: %@", notification.object);
    [self.tableView reloadData];
}

- (void) didConnectToDevice:(NSNotification*)notification {
    selected = -1;
    if (connectTimer && connectTimer.isValid) {
        [connectTimer invalidate];
        connectTimer = nil;
    }
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [self performSegueWithIdentifier:@"showConnected" sender:self];
}

- (void) didFailToConnectToDevice:(NSNotification*)notification {
    [self cancelConnection];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failure" message:@"Failed to connect to device." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *devices = [DeviceStorage sharedInstance].devices;
    return [devices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeviceTableViewCell *cell = (DeviceTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"DeviceCell" forIndexPath:indexPath];
    
    GenericServiceManager *deviceManager = [[DeviceStorage sharedInstance] deviceManagerForIndex:(int)indexPath.row];
    CBPeripheral *peripheral = deviceManager.device;
    [cell.deviceNameLabel setText:peripheral.name];
    [cell.versionLabel setText:peripheral.identifier.UUIDString];
    
    NSNumber *RSSI = [peripheral valueForKey:@"RSSI"];
    if (RSSI) {
        cell.deviceRangeView.rssi = RSSI.intValue;
        cell.rssiLabel.text = [NSString stringWithFormat:@"%d dB", RSSI.intValue];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selected != -1)
        return;
    selected = (int) indexPath.row;
    [self stopScanning];
    CBPeripheral *device = [[DeviceStorage sharedInstance] deviceForIndex:selected];
    [self.manager connectToDevice:device];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.userInteractionEnabled = false;
    hud.labelText = @"Connecting";
    connectTimer = [NSTimer scheduledTimerWithTimeInterval:30
                                                 target:self
                                               selector:@selector(connectionTimeout:)
                                               userInfo:nil
                                                repeats:NO];
}

- (void) onRefresh {
    [self cancelConnection];
    [self stopScanning];
    [self.manager startScanning];

    scanTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                                 target:self
                                               selector:@selector(scanTimerFired:)
                                               userInfo:nil
                                                repeats:NO];
}

- (void) stopScanning {
    if (scanTimer && scanTimer.isValid) {
        [scanTimer invalidate];
        scanTimer = nil;
    }
    
    [self.refreshControl endRefreshing];
    [self.manager stopScanning];
}

- (void) scanTimerFired:(NSTimer*)timer {
    scanTimer = nil;
    [self.manager stopScanning];
}

- (void) connectionTimeout:(NSTimer*)timer {
    NSLog(@"Connection timeout");
    connectTimer = nil;
    [self cancelConnection];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failure" message:@"Failed to connect to device." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void) cancelConnection {
    if (selected == -1)
        return;
    NSLog(@"Cancel pending connection");
    selected = -1;
    if (connectTimer && connectTimer.isValid) {
        [connectTimer invalidate];
        connectTimer = nil;
    }
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [self.manager disconnectDevice];
}

@end
