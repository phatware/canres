/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

package com.dialog.suota.activities;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.AlertDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.le.BluetoothLeScanner;
import android.bluetooth.le.ScanCallback;
import android.bluetooth.le.ScanResult;
import android.bluetooth.le.ScanSettings;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.provider.Settings;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.widget.Toast;

import com.dialog.suota.R;
import com.dialog.suota.RuntimePermissionChecker;
import com.dialog.suota.data.File;
import com.dialog.suota.data.Statics;
import com.dialog.suota.data.Uuid;
import com.dialog.suota.global.ScanAdapter;
import com.dialog.suota.global.ScanItem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

public class ScanActivity extends SuotaActivity implements OnItemClickListener {
    private final static String TAG = "ScanActivity";
    private final static int REQUEST_ENABLE_BT = 1;
    private static final int REQUEST_LOCATION_PERMISSION = 1;
    private static final int REQUEST_STORAGE_PERMISSION = 2;

    private Boolean locationServicesRequired;
    private boolean locationServicesSkipCheck;
    private RuntimePermissionChecker permissionChecker;

    private boolean isScanning = false;
    private boolean showBondedDevices;

    private BluetoothAdapter mBluetoothAdapter;
    private ScannerApi scannerApi;
    private HashMap<String, BluetoothDevice> scannedDevices;

    private ArrayList<BluetoothDevice> bluetoothDeviceList;
    private ScanAdapter bluetoothScanAdapter;
    private ArrayList<ScanItem> deviceNameList;
    private ListView deviceListView;

    private Handler handler;
    private Runnable scanTimer;

    private BluetoothAdapter.LeScanCallback mLeScanCallback = new BluetoothAdapter.LeScanCallback() {
        @Override
        public void onLeScan(final BluetoothDevice device, final int rssi, final byte[] scanRecord) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    List<UUID> uuids = Uuid.parseFromAdvertisementData(scanRecord);
                    for (UUID uuid : uuids) {
                        if (uuid.equals(Statics.SPOTA_SERVICE_UUID) && !scannedDevices.containsKey(device.getAddress())) {
                            scannedDevices.put(device.getAddress(), device);
                            if (bluetoothDeviceList.contains(device)) {
                                deviceNameList.set(bluetoothDeviceList.indexOf(device), new ScanItem(device.getName(), device.getAddress(), rssi, true));
                            } else {
                                bluetoothDeviceList.add(device);
                                deviceNameList.add(new ScanItem(device.getName(), device.getAddress(), rssi, mBluetoothAdapter.getBondedDevices().contains(device)));
                            }
                            bluetoothScanAdapter.notifyDataSetChanged();
                        }
                    }
                }
            });
        }
    };

    private interface ScannerApi {
        void startScanning();
        void stopScanning();
    }

    @SuppressWarnings("deprecation")
    private ScannerApi scannerApi19 = new ScannerApi() {
        @Override
        public void startScanning() {
            mBluetoothAdapter.startLeScan(mLeScanCallback);
        }

        @Override
        public void stopScanning() {
            mBluetoothAdapter.stopLeScan(mLeScanCallback);
        }
    };

    private ScannerApi scannerApi21 = new ScannerApi() {
        BluetoothLeScanner scanner;
        ScanCallback callback;
        ScanSettings settings;

        @TargetApi(21)
        @Override
        public void startScanning() {
            if (scanner == null) {
                scanner = mBluetoothAdapter.getBluetoothLeScanner();
                settings = new ScanSettings.Builder().setScanMode(ScanSettings.SCAN_MODE_LOW_LATENCY).setReportDelay(0).build();
                callback = new ScanCallback() {
                    @Override
                    public void onScanResult(int callbackType, ScanResult result) {
                        mLeScanCallback.onLeScan(result.getDevice(), result.getRssi(), result.getScanRecord().getBytes());
                    }

                    @Override
                    public void onBatchScanResults(List<ScanResult> results) {
                        for (ScanResult result : results)
                            mLeScanCallback.onLeScan(result.getDevice(), result.getRssi(), result.getScanRecord().getBytes());
                    }
                };
            }
            scanner.startScan(null, settings, callback);
        }

        @TargetApi(21)
        @Override
        public void stopScanning() {
            if (scanner != null && mBluetoothAdapter.isEnabled())
                scanner.stopScan(callback);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scan);

        permissionChecker = new RuntimePermissionChecker(this, savedInstanceState);
        permissionChecker.setRationaleIcon(R.drawable.ic_info_outline_black_36dp);
        if (getPreferences(MODE_PRIVATE).getBoolean("oneTimePermissionRationale", true)) {
            getPreferences(MODE_PRIVATE).edit().putBoolean("oneTimePermissionRationale", false).apply();
            permissionChecker.setOneTimeRationale(getString(R.string.permission_rationale));
        }
        permissionChecker.registerPermissionRequestCallback(REQUEST_LOCATION_PERMISSION, new RuntimePermissionChecker.PermissionRequestCallback() {
            @Override
            public void onPermissionRequestResult(int requestCode, String[] permissions, String[] denied) {
                if (denied == null)
                    startDeviceScan();
            }
        });
        permissionChecker.registerPermissionRequestCallback(REQUEST_STORAGE_PERMISSION, new RuntimePermissionChecker.PermissionRequestCallback() {
            @Override
            public void onPermissionRequestResult(int requestCode, String[] permissions, String[] denied) {
                if (denied == null) {
                    createFirmwareDirectory();
                } else {
                    Log.e(TAG, "Missing required permission");
                    new AlertDialog.Builder(ScanActivity.this)
                            .setTitle(R.string.storage_permission_denied_title)
                            .setIcon(R.drawable.ic_error_outline_black_36dp)
                            .setMessage(R.string.storage_permission_denied_msg)
                            .setPositiveButton(android.R.string.ok, null)
                            .setOnDismissListener(new DialogInterface.OnDismissListener() {
                                @Override
                                public void onDismiss(DialogInterface dialog) {
                                    finish();
                                }
                            })
                            .show();
                }
            }
        });

        scanTimer = new Runnable() {
            @Override
            public void run() {
                stopDeviceScan();
            }
        };
        deviceNameList = new ArrayList<>();
        bluetoothScanAdapter = new ScanAdapter(this, R.layout.scan_item_row, deviceNameList);
        String prevShowBondedDevices = Statics.getPreviousInput(this, R.id.menu_show_bonded_devices);
        showBondedDevices = prevShowBondedDevices != null && Boolean.parseBoolean(prevShowBondedDevices);
        initialize();
        createFirmwareDirectory();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_ENABLE_BT) {
            if (resultCode == Activity.RESULT_OK) {
                startDeviceScan();
            }
        }
    }

    @Override
    protected void onDestroy() {
        stopDeviceScan();
        super.onDestroy();
    }

    private void initialize() {
        // Initialize layout variables
        setTitle(getResources().getString(R.string.app_devices_title));
        deviceListView = (ListView) findViewById(R.id.device_list);
        scannedDevices = new HashMap<>();
        bluetoothDeviceList = new ArrayList<>();

        // Initialize Bluetooth adapter
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (mBluetoothAdapter == null || !getPackageManager().hasSystemFeature(PackageManager.FEATURE_BLUETOOTH_LE)) {
            // Device does not support Bluetooth Low Energy
            Log.e(TAG, "Bluetooth Low Energy not supported.");
            Toast.makeText(getApplicationContext(), "Bluetooth Low Energy is not supported on this device", Toast.LENGTH_LONG).show();
            finish();
        }

        scannerApi = Build.VERSION.SDK_INT < 21 ? scannerApi19 : scannerApi21;
        handler = new Handler();
        if (!mBluetoothAdapter.isEnabled()) {
            startActivityForResult(new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE), REQUEST_ENABLE_BT);
        } else {
            startDeviceScan();
        }
        deviceListView.setAdapter(bluetoothScanAdapter);
    }

    @Override
    protected void onResume() {
        super.onResume();
        deviceListView.setOnItemClickListener(this);
    }

    private void createFirmwareDirectory() {
        if (!permissionChecker.checkPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE, R.string.storage_permission_rationale, REQUEST_STORAGE_PERMISSION))
            return;
        if (Statics.fileDirectoriesCreated(this))
            return;
        Log.d(TAG, "Create firmware directory");
        if (File.createFileDirectories(this))
            Statics.setFileDirectoriesCreated(this);
        else
            Log.e(TAG, "Firmware directory creation failed");
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        permissionChecker.saveState(outState);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        permissionChecker.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }

    private boolean checkLocationServices() {
        if (Build.VERSION.SDK_INT < 23 || locationServicesSkipCheck)
            return true;
        // Check if location services are required by reading the setting from Bluetooth app.
        if (locationServicesRequired == null) {
            locationServicesRequired = true;
            try {
                Resources res = getPackageManager().getResourcesForApplication("com.android.bluetooth");
                int id = res.getIdentifier("strict_location_check", "bool", "com.android.bluetooth");
                locationServicesRequired = res.getBoolean(id);
            } catch (PackageManager.NameNotFoundException | Resources.NotFoundException e) {
                Log.e(TAG, "Failed to read location services requirement setting", e);
            }
            Log.d(TAG, "Location services requirement setting: " + locationServicesRequired);
        }
        if (!locationServicesRequired)
            return true;
        // Check location services setting. Prompt the user to enable them.
        if (Settings.Secure.getInt(getContentResolver(), Settings.Secure.LOCATION_MODE, Settings.Secure.LOCATION_MODE_OFF) != Settings.Secure.LOCATION_MODE_OFF)
            return true;
        Log.d(TAG, "Location services disabled");
        new AlertDialog.Builder(this)
                .setIcon(R.drawable.ic_info_outline_black_36dp)
                .setTitle(R.string.no_location_services_title)
                .setMessage(R.string.no_location_services_msg)
                .setPositiveButton(R.string.enable_location_services, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        startActivity(new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS));
                    }
                })
                .setNegativeButton(R.string.no_location_services_scan, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        locationServicesSkipCheck = true;
                        startDeviceScan();
                    }
                })
                .show();
        return false;
    }

    private void startDeviceScan() {
        if (!mBluetoothAdapter.isEnabled()) {
            startActivityForResult(new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE), REQUEST_ENABLE_BT);
            return;
        }
        if (!permissionChecker.checkPermission(Manifest.permission.ACCESS_COARSE_LOCATION, R.string.location_permission_rationale, REQUEST_LOCATION_PERMISSION)
                || !checkLocationServices()) {
            updateBondedDevices();
            return;
        }
        isScanning = true;
        bluetoothDeviceList.clear();
        scannedDevices.clear();
        deviceNameList.clear();
        bluetoothScanAdapter.clear();
        bluetoothScanAdapter.notifyDataSetChanged();
        Log.d(TAG, "Start scanning");
        updateBondedDevices();
        scannerApi.startScanning();
        handler.postDelayed(scanTimer, 10000);
        invalidateOptionsMenu();
    }

    private void stopDeviceScan() {
        if (isScanning) {
            isScanning = false;
            handler.removeCallbacks(scanTimer);
            Log.d(TAG, "Stop scanning");
            scannerApi.stopScanning();
            invalidateOptionsMenu();
        }
    }

    private void updateBondedDevices() {
        if (showBondedDevices) {
            for (BluetoothDevice device : mBluetoothAdapter.getBondedDevices()) {
                if (!bluetoothDeviceList.contains(device)) {
                    bluetoothDeviceList.add(device);
                    deviceNameList.add(new ScanItem(device.getName(), device.getAddress(), -900, true));
                }
            }
        } else {
            // Remove bonded devices that were not found during scan
            for (BluetoothDevice device : mBluetoothAdapter.getBondedDevices()) {
                if (!scannedDevices.containsKey(device.getAddress()) && bluetoothDeviceList.contains(device)) {
                    deviceNameList.remove(bluetoothDeviceList.indexOf(device));
                    bluetoothDeviceList.remove(device);
                }
            }
        }
        bluetoothScanAdapter.notifyDataSetChanged();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        super.onCreateOptionsMenu(menu);
        MenuItem menuItemScan = menu.findItem(R.id.menu_scan);
        menuItemScan.setTitle(isScanning ? R.string.menu_stop_scan : R.string.menu_scan);
        menuItemScan.setVisible(true);
        MenuItem menuItemShowBonded = menu.findItem(R.id.menu_show_bonded_devices);
        menuItemShowBonded.setVisible(true);
        menuItemShowBonded.setChecked(showBondedDevices);
        MenuItem menuItemAbout = menu.findItem(R.id.menu_info);
        menuItemAbout.setVisible(true);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        switch (id) {
            case R.id.menu_scan:
                if (isScanning) {
                    stopDeviceScan();
                } else {
                    startDeviceScan();
                }
                break;

            case R.id.menu_show_bonded_devices:
                showBondedDevices = !showBondedDevices;
                Statics.setPreviousInput(this, R.id.menu_show_bonded_devices, String.valueOf(showBondedDevices));
                item.setChecked(showBondedDevices);
                updateBondedDevices();
                break;

            case R.id.menu_info:
                Intent intent = new Intent(ScanActivity.this, com.dialog.suota.activities.InfoActivity.class);
                startActivity(intent);
                break;
        }
        return super.onOptionsItemSelected(item);
    }

    /**
     * On click listener for scanned devices
     */
    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        stopDeviceScan();
        deviceListView.setOnItemClickListener(null);
        BluetoothDevice device = bluetoothDeviceList.get(position);
        Intent intent = new Intent(ScanActivity.this, DeviceActivity.class);
        intent.putExtra("device", device);
        startActivity(intent);
    }
}
