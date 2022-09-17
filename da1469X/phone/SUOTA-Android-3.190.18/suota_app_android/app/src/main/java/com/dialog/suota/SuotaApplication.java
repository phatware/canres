/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

package com.dialog.suota;

import android.app.Application;
import android.bluetooth.BluetoothDevice;

/**
 * Application wide values
 */
public class SuotaApplication extends Application {
    public BluetoothDevice device;
    public String infoManufacturer = "Unknown";
    public String infoModelNumber = "Unknown";
    public String infoFirmwareVersion = "Unknown";
    public String infoSoftwareRevision = "Unknown";

    public void resetToDefaults() {
        device = null;
        infoManufacturer = "Unknown";
        infoModelNumber = "Unknown";
        infoFirmwareVersion = "Unknown";
        infoSoftwareRevision = "Unknown";
    }
}
