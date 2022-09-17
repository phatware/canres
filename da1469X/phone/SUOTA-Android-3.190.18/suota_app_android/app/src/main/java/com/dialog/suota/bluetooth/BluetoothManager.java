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

import android.app.AlertDialog;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Build;
import android.os.PowerManager;
import android.util.Log;
import android.view.View;

import com.dialog.suota.R;
import com.dialog.suota.data.File;
import com.dialog.suota.data.Statics;
import com.dialog.suota.fragments.SUOTAFragment;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayDeque;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Queue;

public abstract class BluetoothManager {
    static final String TAG = "BluetoothManager";

    public static final int END_SIGNAL = 0xfe000000;
    public static final int REBOOT_SIGNAL = 0xfd000000;

    // Input values
    int memoryType;

    // SPI
    int MISO_GPIO;  // P0_5 (0x05)
    int MOSI_GPIO;  // P0_6 (0x06)
    int CS_GPIO;    // P0_3 (0x03)
    int SCK_GPIO;   // P0_0 (0x00)

    // I2C
    int I2CDeviceAddress;
    int SCL_GPIO;
    int SDA_GPIO;

    // SUOTA
    int imageBank;

    // SPOTA
    int patchBaseAddress;

    SUOTAFragment context;
    File file;
    String fileName;
    BluetoothDevice device;
    HashMap<Integer, String> errors;

    boolean lastBlock = false;
    boolean lastBlockSent = false;
    boolean preparedForLastBlock = false;
    boolean endSignalSent = false;
    boolean rebootsignalSent = false;
    boolean finished = false;
    boolean hasError = false;
    boolean refreshPending;
    public int type;
    int step = -1;
    int blockCounter = 0;
    int chunkCounter = -1;
    int gpioMapPrereq = 0;
    long uploadStart;
    PowerManager.WakeLock wakeLock;

    public Queue<BluetoothGattCharacteristic> characteristicsQueue;

    public BluetoothManager() {
        initErrorMap();
        characteristicsQueue = new ArrayDeque<>();
    }

    public void reset() {
        lastBlock = false;
        lastBlockSent = false;
        preparedForLastBlock = false;
        endSignalSent = false;
        rebootsignalSent = false;
        finished = false;
        hasError = false;
        blockCounter = 0;
        chunkCounter = -1;
        gpioMapPrereq = 0;
    }

    public abstract void processStep(Intent intent);

    public boolean isFinished() {
        return finished;
    }

    public boolean isRefreshPending() {
        return refreshPending;
    }

    public void setRefreshPending(boolean refreshPending) {
        this.refreshPending = refreshPending;
    }

    public boolean getError() {
        return hasError;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) throws IOException {
        this.file = file;
        this.file.setType(type);
    }

    public void setFileBlockSize(int fileBlockSize) {
        file.setFileBlockSize(fileBlockSize, Statics.DEFAULT_FILE_CHUNK_SIZE);
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setContext(SUOTAFragment context) {
        this.context = context;
    }

    public BluetoothDevice getDevice() {
        return device;
    }

    public void setDevice(BluetoothDevice device) {
        this.device = device;
    }

    public void setMemoryType(int memoryType) {
        this.memoryType = memoryType;
    }

    public void setPatchBaseAddress(int patchBaseAddress) {
        this.patchBaseAddress = patchBaseAddress;
    }

    public void setImageBank(int imageBank) {
        this.imageBank = imageBank;
    }

    public void setMISO_GPIO(int MISO_GPIO) {
        this.MISO_GPIO = MISO_GPIO;
    }

    public void setMOSI_GPIO(int MOSI_GPIO) {
        this.MOSI_GPIO = MOSI_GPIO;
    }

    public void setCS_GPIO(int CS_GPIO) {
        this.CS_GPIO = CS_GPIO;
    }

    public void setSCK_GPIO(int SCK_GPIO) {
        this.SCK_GPIO = SCK_GPIO;
    }

    public void setSCL_GPIO(int SCL_GPIO) {
        this.SCL_GPIO = SCL_GPIO;
    }

    public void setSDA_GPIO(int SDA_GPIO) {
        this.SDA_GPIO = SDA_GPIO;
    }

    public void setI2CDeviceAddress(int I2CDeviceAddress) {
        this.I2CDeviceAddress = I2CDeviceAddress;
    }

    public void enableNotifications() {
        String msg = "Enable SPOTA_SERV_STATUS notifications";
        Log.d(TAG, msg);
        context.log(msg);
        BluetoothGatt gatt = BluetoothGattSingleton.getGatt();
        BluetoothGattCharacteristic suotaStatus = gatt.getService(Statics.SPOTA_SERVICE_UUID).getCharacteristic(Statics.SPOTA_SERV_STATUS_UUID);
        gatt.setCharacteristicNotification(suotaStatus, true);
        BluetoothGattDescriptor clientConfigDescriptor = suotaStatus.getDescriptor(Statics.CLIENT_CONFIG_DESCRIPTOR);
        clientConfigDescriptor.setValue(BluetoothGattDescriptor.ENABLE_NOTIFICATION_VALUE);
        gatt.writeDescriptor(clientConfigDescriptor);
    }

    protected abstract int getSpotaMemDev();

    public void setSpotaMemDev() {
        BluetoothGattCharacteristic characteristic = BluetoothGattSingleton.getGatt().getService(Statics.SPOTA_SERVICE_UUID).getCharacteristic(Statics.SPOTA_MEM_DEV_UUID);
        int memType = getSpotaMemDev();
        characteristic.setValue(memType, BluetoothGattCharacteristic.FORMAT_UINT32, 0);
        BluetoothGattSingleton.getGatt().writeCharacteristic(characteristic);
        Log.d(TAG, "setSpotaMemDev: " + String.format("%#010x", memType));
        context.log("Set SPOTA_MEM_DEV: " + String.format("%#010x", memType));
    }

    /**
     * 0x05060300 when
     * mem_type:        "External SPI" (0x13)
     * MISO GPIO:       P0_5 (0x05)
     * MOSI GPIO:       P0_6 (0x06)
     * CS GPIO:         P0_3 (0x03)
     * SCK GPIO:        P0_0 (0x00)
     * image_bank:      "Oldest" (value: 0)
     */
    private int getMemParamsSPI() {
        return (MISO_GPIO << 24) | (MOSI_GPIO << 16) | (CS_GPIO << 8) | SCK_GPIO;
    }

    /**
     * 0x01230203 when
     * mem_type:			"External I2C" (0x12)
     * I2C device addr:		0x0123
     * SCL GPIO:			P0_2
     * SDA GPIO:			P0_3
     */
    private int getMemParamsI2C() {
        return (I2CDeviceAddress << 16) | (SCL_GPIO << 8) | SDA_GPIO;
    }

    // Step 8 in documentation
    public void setSpotaGpioMap() {
        int memInfoData = 0;
        boolean valid = false;
        switch (memoryType) {
            case Statics.MEMORY_TYPE_SPI:
                memInfoData = getMemParamsSPI();
                valid = true;
                break;
            case Statics.MEMORY_TYPE_I2C:
                memInfoData = getMemParamsI2C();
                valid = true;
                break;
        }
        if (valid) {
            Log.d(TAG, "setSpotaGpioMap: " + String.format("%#010x", memInfoData));
            context.log("Set SPOTA_GPIO_MAP: " + String.format("%#010x", memInfoData));
            BluetoothGattCharacteristic characteristic = BluetoothGattSingleton.getGatt().getService(Statics.SPOTA_SERVICE_UUID).getCharacteristic(Statics.SPOTA_GPIO_MAP_UUID);
            characteristic.setValue(memInfoData, BluetoothGattCharacteristic.FORMAT_UINT32, 0);
            BluetoothGattSingleton.getGatt().writeCharacteristic(characteristic);
        } else {
            Log.e(TAG, "Memory type not set.");
            context.log("Set SPOTA_GPIO_MAP: Memory type not set.");
        }
    }

    public void setPatchLength() {
        int blocksize = file.getFileBlockSize();
        if (lastBlock) {
            blocksize = file.getNumberOfBytes() % file.getFileBlockSize();
            preparedForLastBlock = true;
        }
        Log.d(TAG, "setPatchLength: " + blocksize + " - " + String.format("%#06x", blocksize));
        context.log("Set SPOTA_PATCH_LENGTH: " + blocksize);
        BluetoothGattCharacteristic characteristic = BluetoothGattSingleton.getGatt().getService(Statics.SPOTA_SERVICE_UUID).getCharacteristic(Statics.SPOTA_PATCH_LEN_UUID);
        characteristic.setValue(blocksize, BluetoothGattCharacteristic.FORMAT_UINT16, 0);
        BluetoothGattSingleton.getGatt().writeCharacteristic(characteristic);
    }

    public float sendBlock() {
        final float progress = ((float) (blockCounter + 1) / (float) file.getNumberOfBlocks()) * 100;
        if (!lastBlockSent) {
            context.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    sendProgressUpdate((int) progress);
                }
            });
            byte[][] block = file.getBlock(blockCounter);

            int i = ++chunkCounter;
            if (chunkCounter == 0)
                Log.d(TAG, "Current block: " + (blockCounter + 1) + " of " + file.getNumberOfBlocks());
            boolean lastChunk = false;
            if (chunkCounter == block.length - 1) {
                chunkCounter = -1;
                lastChunk = true;
            }
            byte[] chunk = block[i];

            final int chunkNumber = (blockCounter * file.getChunksPerBlockCount()) + i + 1;
            if (chunkNumber == 1)
                context.getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        context.log("Update procedure started");
                        context.progressChunk.setVisibility(View.VISIBLE);
                    }
                });
            context.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    context.progressChunk.setText("Sending chunk " + chunkNumber + " of " + file.getTotalChunkCount());
                }
            });
            String systemLogMessage = "Sending block " + (blockCounter + 1) + ", chunk " + (i + 1) + " of " + block.length + ", size " + chunk.length;
            Log.d(TAG, systemLogMessage);
            BluetoothGattCharacteristic characteristic = BluetoothGattSingleton.getGatt().getService(Statics.SPOTA_SERVICE_UUID).getCharacteristic(Statics.SPOTA_PATCH_DATA_UUID);
            characteristic.setValue(chunk);
            characteristic.setWriteType(BluetoothGattCharacteristic.WRITE_TYPE_NO_RESPONSE);
            boolean r = BluetoothGattSingleton.getGatt().writeCharacteristic(characteristic);
            Log.d(TAG, "writeCharacteristic: " + r);

            if (lastChunk) {

                // SUOTA
                if (file.getNumberOfBlocks() == 1) {
                    lastBlock = true;
                }
                if (!lastBlock) {
                    blockCounter++;
                } else {
                    lastBlockSent = true;
                }
                if (blockCounter + 1 == file.getNumberOfBlocks()) {
                    lastBlock = true;
                }

                // SPOTA
                if (type == SpotaManager.TYPE) {
                    lastBlockSent = true;
                }
            }
        }
        return progress;
    }

    public void sendEndSignal() {
        Log.d(TAG, "sendEndSignal");
        context.log("send SUOTA END command");
        BluetoothGattCharacteristic characteristic = BluetoothGattSingleton.getGatt().getService(Statics.SPOTA_SERVICE_UUID).getCharacteristic(Statics.SPOTA_MEM_DEV_UUID);
        characteristic.setValue(END_SIGNAL, BluetoothGattCharacteristic.FORMAT_UINT32, 0);
        BluetoothGattSingleton.getGatt().writeCharacteristic(characteristic);
        endSignalSent = true;
    }

    public void sendRebootSignal() {
        Log.d(TAG, "sendRebootSignal");
        context.log("send SUOTA REBOOT command");
        BluetoothGattCharacteristic characteristic = BluetoothGattSingleton.getGatt().getService(Statics.SPOTA_SERVICE_UUID).getCharacteristic(Statics.SPOTA_MEM_DEV_UUID);
        characteristic.setValue(REBOOT_SIGNAL, BluetoothGattCharacteristic.FORMAT_UINT32, 0);
        BluetoothGattSingleton.getGatt().writeCharacteristic(characteristic);
        rebootsignalSent = true;
        context.enableCloseButton();
    }

    public void queueReadDeviceInfo() {
        List<BluetoothGattService> services = BluetoothGattSingleton.getGatt().getServices();
        for (BluetoothGattService service : services) {
            List<BluetoothGattCharacteristic> characteristics = service.getCharacteristics();
            for (BluetoothGattCharacteristic characteristic : characteristics) {
                if (characteristic.getUuid().equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_MANUFACTURER_NAME_STRING)) {
                    characteristicsQueue.add(characteristic);
                } else if (characteristic.getUuid().equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_MODEL_NUMBER_STRING)) {
                    characteristicsQueue.add(characteristic);
                } else if (characteristic.getUuid().equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_FIRMWARE_REVISION_STRING)) {
                    characteristicsQueue.add(characteristic);
                } else if (characteristic.getUuid().equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_SOFTWARE_REVISION_STRING)) {
                    characteristicsQueue.add(characteristic);
                } else if (characteristic.getUuid().equals(Statics.SPOTA_MEM_INFO_UUID)) {
                    BluetoothGattSingleton.setSpotaMemInfoCharacteristic(characteristic);
                }
            }
        }
    }

    public void readNextCharacteristic() {
        if (characteristicsQueue.size() >= 1) {
            BluetoothGattCharacteristic characteristic = (BluetoothGattCharacteristic) characteristicsQueue.poll();
            BluetoothGattSingleton.getGatt().readCharacteristic(characteristic);
            Log.d(TAG, "readNextCharacteristic");
        }
    }

    private void sendProgressUpdate(int progress) {
        context.progressBarText.setText(String.valueOf(progress) + "%");
        context.progressBar.setProgress(progress);
    }

    public void disconnect() {
        if (wakeLock != null && wakeLock.isHeld()) {
            Log.d(TAG, "Release wake lock");
            wakeLock.release();
        }
        try {
            BluetoothGattSingleton.getGatt().disconnect();
            // Refresh device cache if update was successful
            if (refreshPending)
                refresh(BluetoothGattSingleton.getGatt());
            BluetoothGattSingleton.getGatt().close();
            context.log("Disconnect from device");
        } catch (Exception e) {
            e.printStackTrace();
            context.log("Error disconnecting from device");
        }
        if(file != null) {
            file.close();
        }
    }

    protected void onSuccess() {
        finished = true;
        refreshPending = true;
        double elapsed = (new Date().getTime() - uploadStart) / 1000.;
        context.log("Upload completed");
        context.log("Elapsed time: " + elapsed + " seconds");
        Log.d(TAG, "Upload completed in " + elapsed + " seconds");
        if (wakeLock.isHeld()) {
            Log.d(TAG, "Release wake lock");
            wakeLock.release();
        }
        if (Build.VERSION.SDK_INT >= 21) {
            Log.d(TAG, "Connection parameters update request (balanced)");
            BluetoothGattSingleton.getGatt().requestConnectionPriority(BluetoothGatt.CONNECTION_PRIORITY_BALANCED);
        }
        if (context.getActivity() == null || context.getActivity().isFinishing())
            return;
        new AlertDialog.Builder(context.getActivity())
                .setTitle("Upload completed")
                .setMessage("Reboot device?")
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        if (!context.isDisconnected()) {
                            sendRebootSignal();
                        }
                    }
                })
                .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        //context.switchView(0);
                        //disconnect();
                    }
                })
                .show();
    }

    public void onError(int errorCode) {
        String error = errors.get(errorCode);
        Log.d(TAG, "Error: " + errorCode + " " + error);
        if (hasError)
            return;
        hasError = true;
        disconnect();
        if (context.getActivity() == null || context.getActivity().isFinishing())
            return;
        context.log("Error: " + error);
        new AlertDialog.Builder(context.getActivity())
                .setTitle("An error occurred.")
                .setIcon(R.drawable.ic_error_outline_black_36dp)
                .setMessage(error)
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        context.getActivity().finish();
                    }
                })
                .setOnDismissListener(new DialogInterface.OnDismissListener() {
                    @Override
                    public void onDismiss(DialogInterface dialog) {
                        context.getActivity().finish();
                    }
                })
                .show();
    }

    private void initErrorMap() {
        errors = new HashMap<>();

        errors.put(0x03, "Forced exit of SPOTA service.");
        errors.put(0x04, "Patch Data CRC mismatch.");
        errors.put(0x05, "Received patch Length not equal to PATCH_LEN characteristic value.");
        errors.put(0x06, "External Memory Error. Writing to external device failed.");
        errors.put(0x07, "Internal Memory Error. Not enough internal memory space for patch.");
        errors.put(0x08, "Invalid memory device.");
        errors.put(0x09, "Application error.");

        // SUOTAR application specific error codes
        errors.put(0x01, "SPOTA service started instead of SUOTA.");
        errors.put(0x11, "Invalid image bank.");
        errors.put(0x12, "Invalid image header.");
        errors.put(0x13, "Invalid image size.");
        errors.put(0x14, "Invalid product header.");
        errors.put(0x15, "Same Image Error.");
        errors.put(0x16, "Failed to read from external memory device.");

        // Application error codes
        errors.put(Statics.ERROR_COMMUNICATION, "Communication error.");
        errors.put(Statics.ERROR_SUOTA_NOT_FOUND, "The remote device does not support SUOTA.");
    }

    protected void goToStep(int step) {
        Intent i = new Intent();
        i.putExtra("step", step);
        processStep(i);
    }

    public static boolean refresh(BluetoothGatt gatt) {
        try {
            Log.d(TAG, "refresh device cache");
            Method localMethod = gatt.getClass().getMethod("refresh", (Class[]) null);
            if (localMethod != null) {
                boolean result = (Boolean) localMethod.invoke(gatt, (Object[]) null);
                if (!result)
                    Log.d(TAG, "refresh failed");
                return result;
            }
        } catch (Exception e) {
            Log.e(TAG, "An exception occurred while refreshing device cache");
        }
        return false;
    }
}
