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
import android.bluetooth.BluetoothGattCallback;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothProfile;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;

import com.dialog.suota.data.Statics;
import com.dialog.suota.fragments.SUOTAFragment;

import java.util.UUID;

public class Callback extends BluetoothGattCallback {
    public static String TAG = "Callback";

    private Context context;
    private Handler handler = new Handler();
    private boolean refreshDone;
    private int refreshAttempt;

    public Callback(Context context) {
        this.context = context;
    }

    @Override
    public void onConnectionStateChange(final BluetoothGatt gatt, int status,
                                        int newState) {
        Log.i(TAG, "le onConnectionStateChange [" + newState + "]");
        if (newState == BluetoothProfile.STATE_CONNECTED) {
            Log.i(TAG, "le device connected");
            gatt.discoverServices();
        } else if (newState == BluetoothProfile.STATE_DISCONNECTED) {
            Log.i(TAG, "le device disconnected");
            handler.removeCallbacksAndMessages(null);
        }
        Intent intent = new Intent();
        intent.setAction(Statics.CONNECTION_STATE_UPDATE);
        intent.putExtra("state", newState);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }

    @Override
    public void onMtuChanged(BluetoothGatt gatt, int mtu, int status) {
        if (status == BluetoothGatt.GATT_SUCCESS) {
            Log.d(TAG, "MTU changed to " + mtu);
            Intent intent = new Intent();
            intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
            intent.putExtra("suotaMtu", mtu);
            LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
        } else {
            Log.e(TAG, "MTU request failure, status=" + status);
        }
    }

    @Override
    public void onServicesDiscovered(BluetoothGatt gatt, int status) {
        Log.i(TAG, "onServicesDiscovered");
        if (status != BluetoothGatt.GATT_SUCCESS) {
            Intent intent = new Intent();
            intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
            intent.putExtra("error", Statics.ERROR_COMMUNICATION);
            LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
            return;
        }
        // Refresh device cache. This is the safest place to initiate the procedure.
        if (!refreshDone && ++refreshAttempt <= 10) {
            refreshDone = BluetoothManager.refresh(gatt); // should not fail
            if (refreshDone)
                Log.d(TAG, "restart discovery after refresh");
            gatt.discoverServices();
            return;
        }
        // Check for SUOTA support
        BluetoothGattService suota = gatt.getService(Statics.SPOTA_SERVICE_UUID);
        if (suota == null
            || suota.getCharacteristic(Statics.SPOTA_MEM_DEV_UUID) == null
            || suota.getCharacteristic(Statics.SPOTA_GPIO_MAP_UUID) == null
            || suota.getCharacteristic(Statics.SPOTA_MEM_INFO_UUID) == null
            || suota.getCharacteristic(Statics.SPOTA_PATCH_LEN_UUID) == null
            || suota.getCharacteristic(Statics.SPOTA_PATCH_DATA_UUID) == null
            || suota.getCharacteristic(Statics.SPOTA_SERV_STATUS_UUID) == null
            || suota.getCharacteristic(Statics.SPOTA_SERV_STATUS_UUID).getDescriptor(Statics.CLIENT_CONFIG_DESCRIPTOR) == null
            ) {
            Intent intent = new Intent();
            intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
            intent.putExtra("error", Statics.ERROR_SUOTA_NOT_FOUND);
            LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
            return;
        }
        Intent intent = new Intent();
        intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
        intent.putExtra("step", 0);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }

    @Override
    public void onCharacteristicRead(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
        boolean sendUpdate = true;
        int index = -1;
        int step = -1;
        String suotaInfo = null;
        int suotaInfoValue = -1;

        UUID uuid = characteristic.getUuid();
        if (uuid.equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_MANUFACTURER_NAME_STRING)) {
            index = 0;
        } else if (uuid.equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_MODEL_NUMBER_STRING)) {
            index = 1;
        } else if (uuid.equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_FIRMWARE_REVISION_STRING)) {
            index = 2;
        } else if (uuid.equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_SOFTWARE_REVISION_STRING)) {
            index = 3;
        } else if (uuid.equals(Statics.SUOTA_VERSION_UUID)) {
            suotaInfo = "suotaVersion";
            suotaInfoValue = characteristic.getIntValue(BluetoothGattCharacteristic.FORMAT_UINT8, 0);
        } else if (uuid.equals(Statics.SUOTA_PATCH_DATA_CHAR_SIZE_UUID)) {
            suotaInfo = "suotaPatchDataSize";
            suotaInfoValue = characteristic.getIntValue(BluetoothGattCharacteristic.FORMAT_UINT16, 0);
        } else if (uuid.equals(Statics.SUOTA_MTU_UUID)) {
            suotaInfo = "suotaMtu";
            suotaInfoValue = characteristic.getIntValue(BluetoothGattCharacteristic.FORMAT_UINT16, 0);
        } else if (uuid.equals(Statics.SUOTA_L2CAP_PSM_UUID)) {
            suotaInfo = "suotaL2capPsm";
            suotaInfoValue = characteristic.getIntValue(BluetoothGattCharacteristic.FORMAT_UINT16, 0);
        }
        // SPOTA
        else if (characteristic.getUuid().equals(Statics.SPOTA_MEM_INFO_UUID)) {
            //int memInfoValue = characteristic.getIntValue(BluetoothGattCharacteristic.FORMAT_UINT32, 0);
            //Log.d(TAG, "mem info: " + memInfoValue);
            //SUOTAFragment.getInstance().logMemInfoValue(memInfoValue);
            step = 5;
        } else {
            sendUpdate = false;
        }

        if (sendUpdate) {
            Log.d(TAG, "onCharacteristicRead: " + index);
            Intent intent = new Intent();
            intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
            if (index >= 0) {
                intent.putExtra("characteristic", index);
                intent.putExtra("value", new String(characteristic.getValue()));
            } else if (suotaInfo != null) {
                intent.putExtra(suotaInfo, suotaInfoValue);
            } else {
                intent.putExtra("step", step);
                intent.putExtra("value", characteristic.getIntValue(BluetoothGattCharacteristic.FORMAT_UINT32, 0));
            }
            LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
        }

        super.onCharacteristicRead(gatt, characteristic, status);
    }

    @Override
    public void onCharacteristicWrite(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
        Log.d(TAG, "onCharacteristicWrite: " + characteristic.getUuid().toString());

        if (status == BluetoothGatt.GATT_SUCCESS) {
            Log.i(TAG, "write succeeded");
            int step = -1;
            // Step 2 callback: write SPOTA_MEM_DEV_UUID value
            if (characteristic.getUuid().equals(Statics.SPOTA_MEM_DEV_UUID)) {
                int currStep = SUOTAFragment.getInstance().bluetoothManager.step;
                if (currStep == 2 || currStep == 3)
                    step = 3;
            }
            // Step 3 callback: write SPOTA_GPIO_MAP_UUID value
            else if (characteristic.getUuid().equals(Statics.SPOTA_GPIO_MAP_UUID)) {
                step = 4;
            }
            // Step 4 callback: set the patch length, default 240
            else if (characteristic.getUuid().equals(Statics.SPOTA_PATCH_LEN_UUID)) {
                step = SUOTAFragment.getInstance().bluetoothManager.type == SuotaManager.TYPE ? 5 : 7;
            }
            else if (characteristic.getUuid().equals(Statics.SPOTA_PATCH_DATA_UUID)
                    //&& SUOTAFragment.getInstance().bluetoothManager.type == SuotaManager.TYPE
                    && SUOTAFragment.getInstance().bluetoothManager.chunkCounter != -1
                    ) {
                //step = SUOTAFragment.getInstance().bluetoothManager.type == SuotaManager.TYPE ? 5 : 7;
                /*SUOTAFragment.getInstance().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        SUOTAFragment.getInstance().bluetoothManager.sendBlock();
                    }
                });*/
                SUOTAFragment.getInstance().bluetoothManager.sendBlock();
            }

            if (step > 0) {
                Intent intent = new Intent();
                intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
                intent.putExtra("step", step);
                LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
            }
        } else {
            Log.e(TAG, "write failed: " + status);
            // Suota on remote device doesn't send write response before reboot
            if (!SUOTAFragment.getInstance().bluetoothManager.rebootsignalSent) {
                Intent intent = new Intent();
                intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
                intent.putExtra("error", Statics.ERROR_COMMUNICATION);
                LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
            }
        }
        super.onCharacteristicWrite(gatt, characteristic, status);
    }

    @Override
    public void onDescriptorWrite(BluetoothGatt gatt, BluetoothGattDescriptor descriptor, int status) {
        super.onDescriptorWrite(gatt, descriptor, status);
        Log.d(TAG, "onDescriptorWrite");
        if (status != BluetoothGatt.GATT_SUCCESS) {
            Intent intent = new Intent();
            intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
            intent.putExtra("error", Statics.ERROR_COMMUNICATION);
            LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
            return;
        }
        if (descriptor.getCharacteristic().getUuid().equals(Statics.SPOTA_SERV_STATUS_UUID)) {
            int step = 2;

            Intent intent = new Intent();
            intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
            intent.putExtra("step", step);
            LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
        }
    }

    @Override
    public void onCharacteristicChanged(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic) {
        super.onCharacteristicChanged(gatt, characteristic);
        int value = characteristic.getIntValue(BluetoothGattCharacteristic.FORMAT_UINT8, 0);
        Log.d(TAG, String.format("SPOTA_SERV_STATUS notification: %#04x", value));

        int step = -1;
        int error = -1;
        int status = -1;
        boolean isSuota = SUOTAFragment.getInstance().bluetoothManager.type == SuotaManager.TYPE;

        // SUOTA image started
        if (value == 0x10) {
            step = 3;
        }
        // Successfully sent a block, send the next one
        else if (value == 0x02) {
            step = isSuota ? 5 : 8;
        }
        // SPOTA service status
        else if (!isSuota && (value == 0x01 || value == 0x03)) {
            status = value;
        } else {
            error = value;
        }
        if (step >= 0 || error >= 0 || status >= 0) {
            Intent intent = new Intent();
            intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
            intent.putExtra("step", step);
            intent.putExtra("error", error);
            intent.putExtra("status", status);
            LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
        }
    }
}
