/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

package com.dialog.suota.global;

/**
 * ScanItem object
 */
public class ScanItem {
    String scanName;
    String scanDescription;
    int scanSignal;
    boolean scanPaired;


    public ScanItem(String scanName, String scanDescription, int scanSignal, boolean scanPaired) {
        this.scanName = scanName;
        this.scanDescription = scanDescription;
        this.scanSignal = scanSignal;
        this.scanPaired = scanPaired;
    }
}