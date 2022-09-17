/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

package com.dialog.suota.bluetooth;

import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattService;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.PowerManager;
import android.util.Log;
import android.view.View;

import com.dialog.suota.SuotaApplication;
import com.dialog.suota.data.Statics;
import com.dialog.suota.fragments.SUOTAFragment;

import java.io.File;
import java.util.Date;

public class SuotaManager extends BluetoothManager {
    public static final int TYPE = 1;

    public static final int MEMORY_TYPE_EXTERNAL_I2C = 0x12;
    public static final int MEMORY_TYPE_EXTERNAL_SPI = 0x13;

    static final String TAG = "SuotaManager";

    private int version = 0;
    private int mtu = Statics.DEFAULT_MTU;
    private int patchDataSize = Statics.DEFAULT_FILE_CHUNK_SIZE;
    private int fileChunkSize = Statics.DEFAULT_FILE_CHUNK_SIZE;
    private boolean mtuRequestSent = false;
    private boolean mtuReadAfterRequest = false;
    private int l2capPsm = 0;

    public SuotaManager() {
        context = SUOTAFragment.getInstance();
        type = SuotaManager.TYPE;
    }

    public void processStep(Intent intent) {
        int newStep = intent.getIntExtra("step", -1);
        int error = intent.getIntExtra("error", -1);
        if (error != -1) {
            onError(error);
            return;
        }
        // If a step is set, change the global step to this value
        if (newStep >= 0) {
            step = newStep;
        }
        // If no step is set, check if Bluetooth characteristic information is set
        else {
            int index = intent.getIntExtra("characteristic", -1);
            if (index != -1) {
                String value = intent.getStringExtra("value");
                context.setItemValue(index, value);
            } else {
                if (intent.hasExtra("suotaVersion")) {
                    version = intent.getIntExtra("suotaVersion", 0);
                    Log.d(TAG, "SUOTA version: " + version);
                } else if (intent.hasExtra("suotaPatchDataSize")) {
                    patchDataSize = intent.getIntExtra("suotaPatchDataSize", 0);
                    Log.d(TAG, "SUOTA patch data size: " + patchDataSize);
                    updateFileChunkSize();
                } else if (intent.hasExtra("suotaMtu")) {
                    int oldMtu = mtu;
                    mtu = intent.getIntExtra("suotaMtu", 0);
                    Log.d(TAG, "SUOTA MTU: " + mtu);
                    updateFileChunkSize();
                    // Read MTU again if required
                    if (mtuRequestSent && !mtuReadAfterRequest && mtu != oldMtu) {
                        mtuReadAfterRequest = true;
                        // Workaround for Xiaomi MTU issue
                        if (Build.MANUFACTURER.equals("Xiaomi") && new File("/system/lib/libbtsession.so").exists()) {
                            Log.d(TAG, "Workaround for Xiaomi MTU issue. Read MTU again.");
                            BluetoothGattCharacteristic mtuChar = BluetoothGattSingleton.getGatt().getService(Statics.SPOTA_SERVICE_UUID).getCharacteristic(Statics.SUOTA_MTU_UUID);
                            if (mtuChar != null)
                                characteristicsQueue.add(mtuChar);
                        }
                    }
                } else if (intent.hasExtra("suotaL2capPsm")) {
                    l2capPsm = intent.getIntExtra("suotaL2capPsm", 0);
                    Log.d(TAG, "SUOTA L2CAP PSM: " + l2capPsm);
                }
            }
            if (Build.VERSION.SDK_INT >= 21 && !mtuRequestSent && characteristicsQueue.isEmpty() && mtu == Statics.DEFAULT_MTU && mtu < patchDataSize + 3) {
                Log.d(TAG, "Sending MTU request");
                mtuRequestSent = true;
                BluetoothGattSingleton.getGatt().requestMtu(patchDataSize + 3);
            }
            readNextCharacteristic();
        }
        Log.d(TAG, "step " + step);
        switch (step) {
            case 0:
                queueReadDeviceInfo();
                queueReadSuotaInfo();
                readNextCharacteristic();
                step = -1;
                break;
            // Enable notifications
            case 1:
                if (Build.VERSION.SDK_INT >= 21) {
                    Log.d(TAG, "Connection parameters update request (high)");
                    BluetoothGattSingleton.getGatt().requestConnectionPriority(BluetoothGatt.CONNECTION_PRIORITY_HIGH);
                }
                reset();
                enableNotifications();
                break;
            // Init mem type
            case 2:
                context.progressText.setText("Uploading " + fileName + " to " + device.getName() + ".\n" +
                        "Please wait until the process is completed.");
                context.log(String.format("Firmware CRC: %#04x", file.getCrc() & 0xff));
                String fwSizeMsg = "Upload size: " + file.getNumberOfBytes() + " bytes";
                Log.d(TAG, fwSizeMsg);
                context.log(fwSizeMsg);
                String chunkSizeMsg = "Chunk size: " + fileChunkSize + " bytes";
                Log.d(TAG, chunkSizeMsg);
                context.log(chunkSizeMsg);
                // Acquire wake lock to keep CPU running during upload procedure
                Log.d(TAG, "Acquire wake lock");
                PowerManager pm = (PowerManager) context.getActivity().getSystemService(Context.POWER_SERVICE);
                wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "SUOTA");
                wakeLock.acquire();
                uploadStart = new Date().getTime();
                setSpotaMemDev();
                context.progressBar.setVisibility(View.VISIBLE);
                break;
            // Set mem_type for SPOTA_GPIO_MAP_UUID
            case 3:
                // After setting SPOTAR_MEM_DEV and SPOTAR_IMG_STARTED notification is received, we must set the GPIO map.
                // The order of the callbacks is unpredictable, so the notification may be received before the write response.
                // We don't have a GATT operation queue, so the SPOTA_GPIO_MAP write will fail if the SPOTAR_MEM_DEV hasn't finished yet.
                // Since this call is synchronized, we can wait for both broadcast intents from the callbacks before proceeding.
                // The order of the callbacks doesn't matter with this implementation.
                if (++gpioMapPrereq == 2)
                    setSpotaGpioMap();
                break;
            // Set SPOTA_PATCH_LEN_UUID
            case 4:
                setPatchLength();
                break;
            // Send a block containing blocks of 20 bytes until the patch length (default 240) has been reached
            // Wait for response and repeat this action
            case 5:
                if (!lastBlock) {
                    sendBlock();
                } else {
                    if (!preparedForLastBlock && file.getNumberOfBytes() % file.getFileBlockSize() != 0) {
                        setPatchLength();
                    } else if (!lastBlockSent) {
                        sendBlock();
                    } else if (!endSignalSent) {
                        context.progressChunk.setVisibility(View.GONE);
                        sendEndSignal();
                    } else {
                        onSuccess();
                    }
                }
                break;
        }
    }

    @Override
    protected int getSpotaMemDev() {
        int memTypeBase = -1;
        switch (memoryType) {
            case Statics.MEMORY_TYPE_SPI:
                memTypeBase = MEMORY_TYPE_EXTERNAL_SPI;
                break;
            case Statics.MEMORY_TYPE_I2C:
                memTypeBase = MEMORY_TYPE_EXTERNAL_I2C;
                break;
        }
        int memType = (memTypeBase << 24) | imageBank;
        return memType;
    }

    public void queueReadSuotaInfo() {
        BluetoothGattService suota = BluetoothGattSingleton.getGatt().getService(Statics.SPOTA_SERVICE_UUID);
        BluetoothGattCharacteristic characteristic;
        characteristic = suota.getCharacteristic(Statics.SUOTA_VERSION_UUID);
        if (characteristic != null) {
            Log.d(TAG, "Found SUOTA version characteristic");
            characteristicsQueue.add(characteristic);
        }
        characteristic = suota.getCharacteristic(Statics.SUOTA_PATCH_DATA_CHAR_SIZE_UUID);
        if (characteristic != null) {
            Log.d(TAG, "Found SUOTA patch data char size characteristic");
            characteristicsQueue.add(characteristic);
        }
        characteristic = suota.getCharacteristic(Statics.SUOTA_MTU_UUID);
        if (characteristic != null) {
            Log.d(TAG, "Found SUOTA MTU characteristic");
            characteristicsQueue.add(characteristic);
        }
        characteristic = suota.getCharacteristic(Statics.SUOTA_L2CAP_PSM_UUID);
        if (characteristic != null) {
            Log.d(TAG, "Found SUOTA L2CAP PSM characteristic");
            characteristicsQueue.add(characteristic);
        }
    }

    public void updateFileChunkSize() {
        fileChunkSize = Math.min(patchDataSize, mtu - 3);
        Log.d(TAG, "File chunk size set to " + fileChunkSize);
    }

    @Override
    public void setFileBlockSize(int fileBlockSize) {
        file.setFileBlockSize(fileBlockSize, fileChunkSize);
    }
}
