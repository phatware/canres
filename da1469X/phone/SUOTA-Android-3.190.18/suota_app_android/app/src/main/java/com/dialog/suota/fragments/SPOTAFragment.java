/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

package com.dialog.suota.fragments;

import android.app.AlertDialog;
import android.app.Fragment;
import android.app.ProgressDialog;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattService;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.RadioButton;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.ViewFlipper;

import com.dialog.suota.R;
import com.dialog.suota.SuotaApplication;
import com.dialog.suota.activities.SuotaActivity;
import com.dialog.suota.bluetooth.BluetoothGattReceiver;
import com.dialog.suota.bluetooth.BluetoothGattSingleton;
import com.dialog.suota.bluetooth.SpotaManager;
import com.dialog.suota.bluetooth.SuotaManager;
import com.dialog.suota.data.File;
import com.dialog.suota.data.Statics;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class SPOTAFragment extends Fragment implements AdapterView.OnItemClickListener, View.OnClickListener, AdapterView.OnItemSelectedListener {
    private static final String TAG = "SPOTAFragment";
    BroadcastReceiver bluetoothGattReceiver, progressUpdateReceiver;
    String[] viewTitles;
    ArrayList<String> filesList = new ArrayList<>();
    LayoutInflater inflater;
    public ListView fileListView;
    ArrayAdapter<String> mArrayAdapter;
    boolean disconnected = false;
    boolean showDisconnectMenu = true;
    SuotaApplication application;

    ProgressDialog dialog;

    // Container which holds all the views
    ViewFlipper deviceContainer;
    // All layout views used in this activity
    View deviceFileListView, deviceMain, deviceParameterSettings, progressLayout;

    // Progress layout attributes
    public ProgressBar progressBar;
    public TextView progressText;
    public TextView progressChunk;
    ScrollView scroll;
    TextView logWindow;

    // Layout attributes for device main view
    LinearLayout mainItemsView;
    Button patchDevice, updateDevice;
    RelativeLayout manufacturerItem, modelNumberItem, firmWareVersionItem, softwareRevisionItem;

    // Layout attributes for parameter settings view
    RadioButton memoryTypeSPI, memoryTypeI2C, memoryTypeSystemRam, memoryTypeRetentionRam;
    LinearLayout imageBankContainer, patchBaseAddressContainer, blockSizeContainer;
    View parameterI2cView, parameterSpiView;
    Spinner sclGpioSpinner, sdaGpioSpinner, misoGpioSpinner, mosiGpioSpinner, csGpioSpinner, sckGpioSpinner, imageBankSpinner;
    EditText patchBaseAddress, I2CDeviceAddress, blockSize;
    Button sendToDeviceButton, closeButton;

    int memoryType;

    public com.dialog.suota.bluetooth.BluetoothManager bluetoothManager;

    static SPOTAFragment instance;

    @Override
    public View onCreateView(final LayoutInflater inflater, final ViewGroup container, final Bundle savedInstanceState) {
        instance = this;
        bluetoothManager = new SuotaManager();
        View fragmentView = inflater.inflate(R.layout.device_container, container, false);

        viewTitles = getResources().getStringArray(R.array.app_device_titles);
        application = (SuotaApplication) getActivity().getApplication();
        this.bluetoothGattReceiver = new BluetoothGattReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                super.onReceive(context, intent);
                bluetoothManager.processStep(intent);
            }
        };

        this.progressUpdateReceiver = new BluetoothGattReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                super.onReceive(context, intent);
                int progress = intent.getIntExtra("progress", 0);
                progressBar.setProgress(progress);
            }
        };

        getActivity().registerReceiver(
                this.bluetoothGattReceiver,
                new IntentFilter(Statics.BLUETOOTH_GATT_UPDATE));

        getActivity().registerReceiver(
                this.progressUpdateReceiver,
                new IntentFilter(Statics.PROGRESS_UPDATE));

        dialog = new ProgressDialog(getActivity());
        dialog.setMessage("Connecting, please wait...");
        //dialog.setCancelable(false);
        dialog.setCanceledOnTouchOutside(false);
        dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
            @Override
            public void onCancel(DialogInterface dialog) {
                //bluetoothManager.disconnect();
                getActivity().finish();
            }
        });
        dialog.show();

        deviceContainer = (ViewFlipper) fragmentView.findViewById(R.id.deviceLayoutContainer);
        deviceMain = inflater.inflate(R.layout.device_main, deviceContainer, true);
        deviceFileListView = inflater.inflate(R.layout.device_file_list, deviceContainer, true);
        deviceParameterSettings = inflater.inflate(R.layout.device_parameter_settings, deviceContainer, true);
        progressLayout = inflater.inflate(R.layout.progress, deviceContainer, true);
        switchView(0);
        progressText = (TextView) progressLayout.findViewById(R.id.progress_text);
        progressChunk = (TextView) progressLayout.findViewById(R.id.progress_chunk);
        progressBar = (ProgressBar) progressLayout.findViewById(R.id.progress_bar);
        scroll = (ScrollView) progressLayout.findViewById(R.id.logScroll);
        logWindow = (TextView) progressLayout.findViewById(R.id.logWindow);
        logWindow.setText(null, TextView.BufferType.EDITABLE);
        progressBar.setProgress(0);
        progressBar.setMax(100);
        initMainScreen();
        return fragmentView;
    }

    public static SPOTAFragment getInstance() {
        return SPOTAFragment.instance;
    }

    @Override
    public void onDestroy() {
        Log.d(TAG, "onDestroy");
        bluetoothManager.disconnect();
        try {
            getActivity().unregisterReceiver(this.bluetoothGattReceiver);
            getActivity().unregisterReceiver(this.progressUpdateReceiver);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
        super.onDestroy();
    }

    public boolean onBackPressed() {
        if (this.deviceContainer.getDisplayedChild() == 3) {
            if (bluetoothManager.isFinished() && closeButton.getVisibility() != View.VISIBLE && !disconnected)
                switchView(0);
            return true;
        }
        if (this.deviceContainer.getDisplayedChild() >= 1) {
            switchView(this.deviceContainer.getDisplayedChild() - 1);
            return true;
        } else {
            return false;
        }

    }

    public void initMainScreen() {
        Log.d(TAG, "initMainScreen");
        mainItemsView = (LinearLayout) deviceMain.findViewById(R.id.mainItemsList);
        manufacturerItem = (RelativeLayout) inflater.inflate(R.layout.device_info_item, null);
        modelNumberItem = (RelativeLayout) inflater.inflate(R.layout.device_info_item, null);
        firmWareVersionItem = (RelativeLayout) inflater.inflate(R.layout.device_info_item, null);
        softwareRevisionItem = (RelativeLayout) inflater.inflate(R.layout.device_info_item, null);

        TextView itemName = (TextView) manufacturerItem.findViewById(R.id.itemName);
        itemName.setText("Manufacturer");
        itemName = (TextView) modelNumberItem.findViewById(R.id.itemName);
        itemName.setText("Model number");
        itemName = (TextView) firmWareVersionItem.findViewById(R.id.itemName);
        itemName.setText("Firmware revision");
        itemName = (TextView) softwareRevisionItem.findViewById(R.id.itemName);
        itemName.setText("Software revision");

        if (mainItemsView.getChildCount() == 0) {
            mainItemsView.addView(manufacturerItem);
            mainItemsView.addView(modelNumberItem);
            mainItemsView.addView(firmWareVersionItem);
            mainItemsView.addView(softwareRevisionItem);
        }
        initMainScreenItems();

        updateDevice = (Button) deviceMain.findViewById(R.id.updateButton);
        patchDevice = (Button) deviceMain.findViewById(R.id.patchButton);
        updateDevice.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                BluetoothDevice device = bluetoothManager.getDevice();
                boolean refreshPending = bluetoothManager.isRefreshPending();
                bluetoothManager = new SuotaManager();
                bluetoothManager.setDevice(device);
                bluetoothManager.setRefreshPending(refreshPending);
                initFileList();
                switchView(1);
            }
        });
        patchDevice.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // TODO: Dirty fix to switch to the SpotaManager
                BluetoothDevice device = bluetoothManager.getDevice();
                bluetoothManager = new SpotaManager();
                bluetoothManager.setDevice(device);
                initFileList();
                switchView(1);
            }
        });

        if (this.dialog.isShowing()) {
            this.dialog.dismiss();
        }

    }

    private void initMainScreenItems() {
        Log.d(TAG, "initMainScreenItems");
        List<BluetoothGattService> services = BluetoothGattSingleton.getGatt().getServices();
        for (BluetoothGattService service : services) {
            List<BluetoothGattCharacteristic> characteristics = service.getCharacteristics();
            for (BluetoothGattCharacteristic characteristic : characteristics) {
                if (characteristic.getUuid().equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_MANUFACTURER_NAME_STRING)) {
                    bluetoothManager.characteristicsQueue.add(characteristic);
                } else if (characteristic.getUuid().equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_MODEL_NUMBER_STRING)) {
                    bluetoothManager.characteristicsQueue.add(characteristic);
                } else if (characteristic.getUuid().equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_FIRMWARE_REVISION_STRING)) {
                    bluetoothManager.characteristicsQueue.add(characteristic);
                } else if (characteristic.getUuid().equals(Statics.ORG_BLUETOOTH_CHARACTERISTIC_SOFTWARE_REVISION_STRING)) {
                    bluetoothManager.characteristicsQueue.add(characteristic);
                } else if (characteristic.getUuid().equals(Statics.SPOTA_MEM_INFO_UUID)) {
                    BluetoothGattSingleton.setSpotaMemInfoCharacteristic(characteristic);
                }
            }
        }
        bluetoothManager.readNextCharacteristic();
    }

    public void setItemValue(int index, String value) {
        if (index >= 0) {
            Log.d("test", value);
            RelativeLayout item = (RelativeLayout) mainItemsView.getChildAt(index);
            TextView itemValue = (TextView) item.findViewById(R.id.itemValue);
            itemValue.setText(value);
        }
    }

    private void initFileList() {
        fileListView = (ListView) deviceFileListView.findViewById(R.id.file_list);

        mArrayAdapter = new ArrayAdapter<>(SPOTAFragment.instance.getActivity(), android.R.layout.simple_list_item_1);

        filesList = File.list();
        Iterator<String> it = filesList.iterator();
        fileListView.setAdapter(mArrayAdapter);
        fileListView.setOnItemClickListener(SPOTAFragment.instance);
        while (it.hasNext()) {
            mArrayAdapter.add(it.next());
        }
    }

    private void initParameterSettings() {
        int gpioValuesId = R.array.gpio_values;

        memoryTypeSystemRam = (RadioButton) deviceParameterSettings.findViewById(R.id.memoryTypeSystemRam);
        memoryTypeSystemRam.setOnClickListener(SPOTAFragment.instance);
        memoryTypeRetentionRam = (RadioButton) deviceParameterSettings.findViewById(R.id.memoryTypeRetentionRam);
        memoryTypeRetentionRam.setOnClickListener(SPOTAFragment.instance);
        memoryTypeSPI = (RadioButton) deviceParameterSettings.findViewById(R.id.memoryTypeSPI);
        memoryTypeSPI.setOnClickListener(SPOTAFragment.instance);
        memoryTypeI2C = (RadioButton) deviceParameterSettings.findViewById(R.id.memoryTypeI2C);
        memoryTypeI2C.setOnClickListener(SPOTAFragment.instance);

        closeButton = (Button) deviceParameterSettings.findViewById(R.id.buttonClose);
        closeButton.setOnClickListener(SPOTAFragment.instance);

        // SUOTA ONLY
        imageBankContainer = (LinearLayout) deviceParameterSettings.findViewById(R.id.imageBankContainer);
        blockSizeContainer = (LinearLayout) deviceParameterSettings.findViewById(R.id.blockSizeContainer);
        blockSize = (EditText) deviceParameterSettings.findViewById(R.id.blockSize);

        // SPOTA ONLY
        patchBaseAddressContainer = (LinearLayout) deviceParameterSettings.findViewById(R.id.patchBaseAddressContainer);

        if (bluetoothManager.type == SpotaManager.TYPE) {
            patchBaseAddressContainer.setVisibility(View.VISIBLE);
            imageBankContainer.setVisibility(View.GONE);
            memoryTypeSystemRam.setVisibility(View.VISIBLE);
            memoryTypeRetentionRam.setVisibility(View.VISIBLE);
            blockSizeContainer.setVisibility(View.GONE);
        } else if (bluetoothManager.type == SuotaManager.TYPE) {
            patchBaseAddressContainer.setVisibility(View.GONE);
            imageBankContainer.setVisibility(View.VISIBLE);
            memoryTypeSystemRam.setVisibility(View.GONE);
            memoryTypeRetentionRam.setVisibility(View.GONE);
            blockSizeContainer.setVisibility(View.VISIBLE);
            String previousText = Statics.getPreviousInput(SPOTAFragment.instance.getActivity(), R.id.blockSize);
            if (previousText == null || previousText.isEmpty()) {
                previousText = Statics.DEFAULT_BLOCK_SIZE_VALUE;
            }
            blockSize.setText(previousText);
            blockSize.addTextChangedListener(new TextWatcher() {
                @Override
                public void afterTextChanged(Editable s) {
                    Statics.setPreviousInput(getActivity(), R.id.blockSize, blockSize.getText().toString());
                }

                @Override
                public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                }

                @Override
                public void onTextChanged(CharSequence s, int start, int before, int count) {
                }
            });
        }

        // Different views for memory types
        parameterI2cView = deviceParameterSettings.findViewById(R.id.pI2cContainer);
        parameterSpiView = deviceParameterSettings.findViewById(R.id.pSpiContainer);

        // SPOTA patch base address
        patchBaseAddress = (EditText) deviceParameterSettings.findViewById(R.id.patchBaseAddress);
        if (Statics.getPreviousInput(getActivity(), R.id.patchBaseAddress) != null) {
            patchBaseAddress.setText(Statics.getPreviousInput(getActivity(), R.id.patchBaseAddress));
        }

        // SUOTA image bank
        imageBankSpinner = (Spinner) deviceParameterSettings.findViewById(R.id.imageBank);
        ArrayAdapter<CharSequence> imageBankAdapter = ArrayAdapter.createFromResource(getActivity(),
                R.array.image_bank_addresses, android.R.layout.simple_spinner_item);
        imageBankAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        imageBankSpinner.setAdapter(imageBankAdapter);
        imageBankSpinner.setOnItemSelectedListener(SPOTAFragment.instance);
        int position = imageBankAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.imageBank));
        if (position == -1) {
            position = Statics.DEFAULT_MEMORY_BANK;
        }
        imageBankSpinner.setSelection(position);

        // I2C Device address
        I2CDeviceAddress = (EditText) deviceParameterSettings.findViewById(R.id.I2CDeviceAddress);
        String previousText = Statics.getPreviousInput(getActivity(), R.id.I2CDeviceAddress);
        if (previousText == null || previousText.isEmpty()) {
            previousText = Statics.DEFAULT_I2C_DEVICE_ADDRESS;
        }
        I2CDeviceAddress.setText(previousText);
        I2CDeviceAddress.addTextChangedListener(new TextWatcher() {
            @Override
            public void afterTextChanged(Editable s) {
                try {
                    int I2CDeviceAddressValue = Integer.decode(I2CDeviceAddress.getText().toString());
                    Statics.setPreviousInput(getActivity(), R.id.I2CDeviceAddress, String.format("%#04x", I2CDeviceAddressValue));
                } catch (NumberFormatException nfe) {
                }
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }
        });

        // Spinners for I2C
        sclGpioSpinner = (Spinner) deviceParameterSettings.findViewById(R.id.sclGpioSpinner);
        sdaGpioSpinner = (Spinner) deviceParameterSettings.findViewById(R.id.sdaGpioSpinner);

        // Spinners for SPI
        misoGpioSpinner = (Spinner) deviceParameterSettings.findViewById(R.id.misoGpioSpinner);
        mosiGpioSpinner = (Spinner) deviceParameterSettings.findViewById(R.id.mosiGpioSpinner);
        csGpioSpinner = (Spinner) deviceParameterSettings.findViewById(R.id.csGpioSpinner);
        sckGpioSpinner = (Spinner) deviceParameterSettings.findViewById(R.id.sckGpioSpinner);

        ArrayAdapter<CharSequence> gpioAdapter = ArrayAdapter.createFromResource(getActivity(),
                gpioValuesId, android.R.layout.simple_spinner_item);
        gpioAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        sclGpioSpinner.setAdapter(gpioAdapter);
        sclGpioSpinner.setOnItemSelectedListener(SPOTAFragment.instance);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.sclGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_SCL_GPIO_VALUE;
        }
        sclGpioSpinner.setSelection(position);

        sdaGpioSpinner.setAdapter(gpioAdapter);
        sdaGpioSpinner.setOnItemSelectedListener(SPOTAFragment.instance);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.sdaGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_SDA_GPIO_VALUE;
        }
        sdaGpioSpinner.setSelection(position);

        misoGpioSpinner.setAdapter(gpioAdapter);
        misoGpioSpinner.setOnItemSelectedListener(SPOTAFragment.instance);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.misoGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_MISO_VALUE;
        }
        Log.d("position", "MISO: " + position);
        misoGpioSpinner.setSelection(position);

        mosiGpioSpinner.setAdapter(gpioAdapter);
        mosiGpioSpinner.setOnItemSelectedListener(SPOTAFragment.instance);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.mosiGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_MOSI_VALUE;
        }
        Log.d("position", "MOSI: " + position);
        mosiGpioSpinner.setSelection(position);

        csGpioSpinner.setAdapter(gpioAdapter);
        csGpioSpinner.setOnItemSelectedListener(SPOTAFragment.instance);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.csGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_CS_VALUE;
        }
        Log.d("position", "CS: " + position);
        csGpioSpinner.setSelection(position);

        sckGpioSpinner.setAdapter(gpioAdapter);
        sckGpioSpinner.setOnItemSelectedListener(SPOTAFragment.instance);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.sckGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_SCK_VALUE;
        }
        Log.d("position", "SCK: " + position);
        sckGpioSpinner.setSelection(position);

        sendToDeviceButton = (Button) deviceParameterSettings.findViewById(R.id.sendToDeviceButton);
        sendToDeviceButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startUpdate();
            }
        });

        int previousMemoryType;
        if (bluetoothManager.type == SpotaManager.TYPE) {
            try {
                previousMemoryType = Integer.parseInt(Statics.getPreviousInput(getActivity(), Statics.MEMORY_TYPE_SPOTA_INDEX));
            } catch (NumberFormatException nfe) {
                previousMemoryType = Statics.DEFAULT_MEMORY_TYPE;
            }
        } else {
            try {
                previousMemoryType = Integer.parseInt(Statics.getPreviousInput(getActivity(), Statics.MEMORY_TYPE_SUOTA_INDEX));
            } catch (NumberFormatException nfe) {
                previousMemoryType = Statics.DEFAULT_MEMORY_TYPE;
            }
        }

        if (previousMemoryType > 0) {
            setMemoryType(previousMemoryType);
        } else {
            // Set default memory type to SPI
            setMemoryType(Statics.MEMORY_TYPE_SPI);
        }
    }

    private void startUpdate() {
        Intent intent = new Intent();

        if (bluetoothManager.type == SpotaManager.TYPE) {
            int patchBaseAddressValue = Integer.decode(patchBaseAddress.getText().toString()); //TODO This crashes when empty
            Statics.setPreviousInput(getActivity(), R.id.patchBaseAddress, String.format("%#010x", patchBaseAddressValue));
            bluetoothManager.setPatchBaseAddress(patchBaseAddressValue);
        } else if (bluetoothManager.type == SuotaManager.TYPE) {
            Statics.setPreviousInput(getActivity(), R.id.blockSize, blockSize.getText().toString());
        }

        if (memoryType == Statics.MEMORY_TYPE_I2C) {
            try {
                int I2CDeviceAddressValue = Integer.decode(I2CDeviceAddress.getText().toString());
                Statics.setPreviousInput(getActivity(), R.id.I2CDeviceAddress, String.format("%#04x", I2CDeviceAddressValue));
                bluetoothManager.setI2CDeviceAddress(I2CDeviceAddressValue);
            } catch (NumberFormatException nfe) {
                new AlertDialog.Builder(getActivity())
                        .setTitle("I2C Parameter Error")
                        .setMessage("Invalid I2C device address.")
                        .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                            }
                        })
                        .show();
                return;
            }
        }

        // Set default block size to 1 for SPOTA, this will not be used in this case
        int fileBlockSize = 1;
        if (bluetoothManager.type == SuotaManager.TYPE) {
            try {
                fileBlockSize = Math.abs(Integer.parseInt(blockSize.getText().toString()));
            } catch (NumberFormatException nfe) {
                fileBlockSize = 0;
            }
            if (fileBlockSize == 0) {
                new AlertDialog.Builder(getActivity())
                        .setTitle("Invalid block size")
                        .setMessage("The block size cannot be zero.")
                        .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                            }
                        })
                        .show();
                return;
            }
        }
        bluetoothManager.setFileBlockSize(fileBlockSize);

        intent.setAction(Statics.BLUETOOTH_GATT_UPDATE);
        intent.putExtra("step", 1);
        getActivity().sendBroadcast(intent);
        switchView(3);
    }

    private void setMemoryType(int memoryType) {
        this.clearMemoryTypeChecked();
        this.memoryType = memoryType;
        bluetoothManager.setMemoryType(memoryType);
        parameterI2cView.setVisibility(View.GONE);
        parameterSpiView.setVisibility(View.GONE);

        if (bluetoothManager.type == SpotaManager.TYPE) {
            Statics.setPreviousInput(getActivity(), Statics.MEMORY_TYPE_SPOTA_INDEX, String.valueOf(memoryType));
        } else {
            Statics.setPreviousInput(getActivity(), Statics.MEMORY_TYPE_SUOTA_INDEX, String.valueOf(memoryType));
        }

        switch (memoryType) {
            case Statics.MEMORY_TYPE_SYSTEM_RAM:
                patchBaseAddressContainer.setVisibility(View.GONE);
                memoryTypeSystemRam.setChecked(true);
                break;
            case Statics.MEMORY_TYPE_RETENTION_RAM:
                patchBaseAddressContainer.setVisibility(View.GONE);
                memoryTypeRetentionRam.setChecked(true);
                break;
            case Statics.MEMORY_TYPE_SPI:
                if (bluetoothManager.type == SpotaManager.TYPE) {
                    patchBaseAddressContainer.setVisibility(View.VISIBLE);
                }
                parameterSpiView.setVisibility(View.VISIBLE);
                memoryTypeSPI.setChecked(true);
                break;

            case Statics.MEMORY_TYPE_I2C:
                if (bluetoothManager.type == SpotaManager.TYPE) {
                    patchBaseAddressContainer.setVisibility(View.VISIBLE);
                }
                parameterI2cView.setVisibility(View.VISIBLE);
                memoryTypeI2C.setChecked(true);
                break;
        }
    }

    public void switchView(int viewIndex) {
        this.deviceContainer.setDisplayedChild(viewIndex);
        ((SuotaActivity) getActivity()).changeActionbarTitle(viewTitles[viewIndex]);
        if (viewIndex == 0) {
            ((SuotaActivity) getActivity()).changeActionbarTitle(bluetoothManager.getDevice().getName());
        }

    }

    private void clearMemoryTypeChecked() {
        memoryTypeSystemRam.setChecked(false);
        memoryTypeRetentionRam.setChecked(false);
        memoryTypeI2C.setChecked(false);
        memoryTypeSPI.setChecked(false);
    }

    public void enableCloseButton() {
        closeButton.setVisibility(View.VISIBLE);
    }


    public void logMemInfoValue(int memInfoValue) {
        String message = "Patch Memory Info:\n";
        int numberOfPatches = (memInfoValue >> 16) & 0xff;
        int numberOfBytes = memInfoValue & 0xff;
        int sizeOfPatches = (int) Math.ceil((double) numberOfBytes / (double) 4);
        message += "\tNumber of patches = " + numberOfPatches + "\n" +
                "\tSize of patches = " + sizeOfPatches + " words (" + numberOfBytes + " bytes)";
        this.log(message);
    }

    public void log(String message) {
        this.logWindow.getEditableText().append(message + "\n");
        this.scroll.post(new Runnable() {
            @Override
            public void run() {
                scroll.fullScroll(ScrollView.FOCUS_DOWN);
            }
        });
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position,
                            long id) {
        // Get the resourceID necessary for retrieving the file
        String filename = filesList.get(position).toString();
        bluetoothManager.setFileName(filename);
        Log.d(TAG, "Clicked: " + filename);
        try {
            bluetoothManager.setFile(File.getByFileName(filename));
            initParameterSettings();
            switchView(2);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.memoryTypeSystemRam:
                setMemoryType(Statics.MEMORY_TYPE_SYSTEM_RAM);
                break;
            case R.id.memoryTypeRetentionRam:
                setMemoryType(Statics.MEMORY_TYPE_RETENTION_RAM);
                break;
            case R.id.memoryTypeSPI:
                setMemoryType(Statics.MEMORY_TYPE_SPI);
                break;
            case R.id.memoryTypeI2C:
                setMemoryType(Statics.MEMORY_TYPE_I2C);
                break;
            case R.id.buttonClose:
                getActivity().finish();
                break;
        }
    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        String stringValue = parent.getSelectedItem().toString();
        Statics.setPreviousInput(getActivity(), parent.getId(), stringValue);

        if (parent.getId() == R.id.imageBank) {
            bluetoothManager.setImageBank(Integer.decode(stringValue));
            return;
        }

        int value = Statics.gpioStringToInt(stringValue);
        switch (parent.getId()) {
            // SPI
            case R.id.misoGpioSpinner:
                bluetoothManager.setMISO_GPIO(value);
                break;
            case R.id.mosiGpioSpinner:
                bluetoothManager.setMOSI_GPIO(value);
                break;
            case R.id.csGpioSpinner:
                bluetoothManager.setCS_GPIO(value);
                break;
            case R.id.sckGpioSpinner:
                bluetoothManager.setSCK_GPIO(value);
                break;

            // I2C
            case R.id.sclGpioSpinner:
                bluetoothManager.setSCL_GPIO(value);
                break;
            case R.id.sdaGpioSpinner:
                bluetoothManager.setSDA_GPIO(value);
                break;
        }
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {
    }

    public void hideDisconnectMenu() {
        showDisconnectMenu = false;
        getActivity().invalidateOptionsMenu();
    }

    public boolean isDisconnected() {
        return disconnected;
    }
}
