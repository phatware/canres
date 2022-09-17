/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "FileTableViewController.h"
#import "Defines.h"
#import "ParameterStorage.h"
#import "BluetoothManager.h"

@interface FileTableViewController ()

@end

@implementation FileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"Select a file..."];
    [self.navigationItem.backBarButtonItem setTitle:@"Cancel"];

    self.fileArray = [self getFileListing];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fileArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fileCell" forIndexPath:indexPath];

    NSString *fileName = self.fileArray[indexPath.row];
    NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", [fileName stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLPathAllowedCharacterSet]]];
    NSNumber *fileSizeValue = nil;
    NSError *fileSizeError = nil;
    [fileURL getResourceValue:&fileSizeValue
                       forKey:NSURLFileSizeKey
                        error:&fileSizeError];

    NSArray *parts = [fileName componentsSeparatedByString:@"/"];
    NSString *baseName = parts[parts.count - 1];
    [cell.textLabel setText:baseName];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%d B", [fileSizeValue intValue]]];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fileName = self.fileArray[indexPath.row];
    NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", [fileName stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLPathAllowedCharacterSet]]];

    ParameterStorage *storage = [ParameterStorage getInstance];
    storage.file_url = fileURL;
}

- (NSMutableArray *)getFileListing {

    NSMutableArray *retval = [NSMutableArray array];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *publicDocumentsDir = paths[0];

    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:publicDocumentsDir error:&error];
    if (!files) {
        NSLog(@"Error reading contents of documents directory: %@", error.localizedDescription);
        return retval;
    }

    for (NSString *file in files) {
        if ([file.pathExtension compare:@"bin" options:NSCaseInsensitiveSearch] == NSOrderedSame || [file.pathExtension compare:@"img" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [publicDocumentsDir stringByAppendingPathComponent:file];
            [retval addObject:fullPath];
        }
    }

    return retval;
}

@end
