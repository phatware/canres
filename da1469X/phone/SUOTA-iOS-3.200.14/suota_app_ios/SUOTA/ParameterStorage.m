/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

#import "ParameterStorage.h"

@implementation ParameterStorage

static ParameterStorage* sharedParameterStorage = nil;

+ (ParameterStorage*) getInstance {
    if (sharedParameterStorage == nil) {
        sharedParameterStorage = [[ParameterStorage alloc] init];
    }
    return sharedParameterStorage;
}

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

@end
