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
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.content.LocalBroadcastManager;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
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
import android.widget.Toast;
import android.widget.ViewFlipper;

import com.dialog.suota.R;
import com.dialog.suota.SuotaApplication;
import com.dialog.suota.activities.SuotaActivity;
import com.dialog.suota.bluetooth.SpotaManager;
import com.dialog.suota.bluetooth.SuotaManager;
import com.dialog.suota.data.File;
import com.dialog.suota.data.Statics;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Objects;

import static android.content.Context.INPUT_METHOD_SERVICE;

public class SUOTAFragment extends Fragment implements View.OnClickListener, AdapterView.OnItemSelectedListener {
    private static final String TAG = "SUOTAFragment";

    private static SUOTAFragment instance;
    private SuotaApplication application;
    public com.dialog.suota.bluetooth.BluetoothManager bluetoothManager;
    private int memoryType;
    private boolean disconnected = false;

    // Container which holds all the views
    private ViewFlipper deviceContainer;
    private String[] viewTitles;
    private View deviceMain, deviceFileListView, deviceParameterSettings, progressLayout;
    private int currentView;
    private LayoutInflater layoutInflater;

    // Device information view
    private LinearLayout mainItemsView;
    private RelativeLayout manufacturerItem, modelNumberItem, firmWareRevisionItem, softwareRevisionItem;
    private String manufacturer, modelNumber, firmwareRevision, softwareRevision;
    private Button updateDevice;

    // File list view
    private ListView fileListView;
    private ArrayAdapter<String> mArrayAdapter;
    private ArrayList<String> filesList = new ArrayList<>();

    // Parameter settings view
    private RadioButton memoryTypeSPI, memoryTypeI2C, memoryTypeSystemRam, memoryTypeRetentionRam;
    private LinearLayout imageBankContainer, patchBaseAddressContainer, blockSizeContainer;
    private View parameterI2cView, parameterSpiView;
    private Spinner sclGpioSpinner, sdaGpioSpinner, misoGpioSpinner, mosiGpioSpinner, csGpioSpinner, sckGpioSpinner, imageBankSpinner;
    private EditText patchBaseAddress, I2CDeviceAddress, blockSize;
    private TextView deviceNameValue, fileNameValue;
    private Button sendToDeviceButton, closeButton;

    // Progress view
    public ProgressBar progressBar;
    public TextView progressText, progressBarText;
    public TextView progressChunk;
    private ScrollView scroll;
    private TextView logWindow;

    @Override
    public View onCreateView(final LayoutInflater inflater, final ViewGroup container, final Bundle savedInstanceState) {
        instance = this;
        application = (SuotaApplication) getActivity().getApplication();
        if (bluetoothManager == null)
            bluetoothManager = new SuotaManager();
        bluetoothManager.setContext(this);
        bluetoothManager.setDevice(application.device);
        View fragmentView = inflater.inflate(R.layout.device_container, container, false);

        viewTitles = getResources().getStringArray(R.array.app_device_titles);
        layoutInflater = LayoutInflater.from(getActivity());
        deviceContainer = (ViewFlipper) fragmentView.findViewById(R.id.deviceLayoutContainer);
        deviceMain = inflater.inflate(R.layout.device_main, deviceContainer, true);
        deviceFileListView = inflater.inflate(R.layout.device_file_list, deviceContainer, true);
        deviceParameterSettings = inflater.inflate(R.layout.device_parameter_settings, deviceContainer, true);
        progressLayout = inflater.inflate(R.layout.progress, deviceContainer, true);
        progressText = (TextView) progressLayout.findViewById(R.id.progress_text);
        progressChunk = (TextView) progressLayout.findViewById(R.id.progress_chunk);
        progressBar = (ProgressBar) progressLayout.findViewById(R.id.progress_bar);
        progressBarText = (TextView) progressLayout.findViewById(R.id.progress_bar_text);
        scroll = (ScrollView) progressLayout.findViewById(R.id.logScroll);
        logWindow = (TextView) progressLayout.findViewById(R.id.logWindow);
        logWindow.setText(null, TextView.BufferType.EDITABLE);
        progressBar.setProgress(0);
        progressBar.setMax(100);

        initMainScreen();
        if (currentView == 3)
            currentView = 0;
        if (currentView >= 1)
            initFileList();
        if (currentView >= 2)
            initParameterSettings();
        switchView(currentView);

        return fragmentView;
    }

    public static SUOTAFragment getInstance() {
        return SUOTAFragment.instance;
    }

    public void processStep(Intent intent) {
        bluetoothManager.processStep(intent);
    }

    public void setDisconnected(boolean disconnected) {
        this.disconnected = disconnected;
    }

    public boolean isDisconnected() {
        return disconnected;
    }

    public boolean onBackPressed() {
        if (deviceContainer.getDisplayedChild() == 3) {
            if (bluetoothManager.isFinished() && closeButton.getVisibility() != View.VISIBLE && !disconnected)
                switchView(0);
            else {
                bluetoothManager.disconnect();
                getActivity().finish();
            }
        } else if (deviceContainer.getDisplayedChild() >= 1) {
            switchView(deviceContainer.getDisplayedChild() - 1);
        } else {
            bluetoothManager.disconnect();
            getActivity().finish();
        }
        return true;
    }

    public void initMainScreen() {
        Log.d(TAG, "initMainScreen");
        mainItemsView = (LinearLayout) deviceMain.findViewById(R.id.mainItemsList);
        manufacturerItem = (RelativeLayout) layoutInflater.inflate(R.layout.device_info_item, null);
        modelNumberItem = (RelativeLayout) layoutInflater.inflate(R.layout.device_info_item, null);
        firmWareRevisionItem = (RelativeLayout) layoutInflater.inflate(R.layout.device_info_item, null);
        softwareRevisionItem = (RelativeLayout) layoutInflater.inflate(R.layout.device_info_item, null);
        ((TextView) manufacturerItem.findViewById(R.id.itemName)).setText(R.string.dev_info_manufacturer);
        ((TextView) modelNumberItem.findViewById(R.id.itemName)).setText(R.string.dev_info_model);
        ((TextView) firmWareRevisionItem.findViewById(R.id.itemName)).setText(R.string.dev_info_firmware);
        ((TextView) softwareRevisionItem.findViewById(R.id.itemName)).setText(R.string.dev_info_software);
        if (manufacturer != null)
            ((TextView) manufacturerItem.findViewById(R.id.itemValue)).setText(manufacturer);
        if (modelNumber != null)
            ((TextView) modelNumberItem.findViewById(R.id.itemValue)).setText(modelNumber);
        if (firmwareRevision != null)
            ((TextView) firmWareRevisionItem.findViewById(R.id.itemValue)).setText(firmwareRevision);
        if (softwareRevision != null)
            ((TextView) softwareRevisionItem.findViewById(R.id.itemValue)).setText(softwareRevision);
        if (mainItemsView.getChildCount() == 0) {
            mainItemsView.addView(manufacturerItem);
            mainItemsView.addView(modelNumberItem);
            mainItemsView.addView(firmWareRevisionItem);
            mainItemsView.addView(softwareRevisionItem);
        }
        updateDevice = (Button) deviceMain.findViewById(R.id.updateButton);
        updateDevice.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                initFileList();
                switchView(1);
            }
        });
    }

    public void setItemValue(int index, String value) {
        if (index >= 0) {
            String info = null;
            switch (index) {
                case 0:
                    if (Objects.equals(value, "Dialog Semi"))
                        value = getString(R.string.dialog_semiconductor);
                    manufacturer = value;
                    ((TextView) manufacturerItem.findViewById(R.id.itemValue)).setText(value);
                    info = "Manufacturer";
                    break;
                case 1:
                    modelNumber = value;
                    ((TextView) modelNumberItem.findViewById(R.id.itemValue)).setText(value);
                    info = "Model number";
                    break;
                case 2:
                    firmwareRevision = value;
                    ((TextView) firmWareRevisionItem.findViewById(R.id.itemValue)).setText(value);
                    info = "Firmware revision";
                    break;
                case 3:
                    softwareRevision = value;
                    ((TextView) softwareRevisionItem.findViewById(R.id.itemValue)).setText(value);
                    info = "Software revision";
                    break;
            }
            if (info != null)
                Log.d("SuotaDevInfo", info + ": " + value);
        }
    }

    private void initFileList() {
        fileListView = (ListView) deviceFileListView.findViewById(R.id.file_list);
        mArrayAdapter = new ArrayAdapter<>(getActivity(), android.R.layout.simple_list_item_1);
        fileListView.setAdapter(mArrayAdapter);

        filesList = File.list();
        if (filesList == null || filesList.isEmpty()) {
            Toast.makeText(getActivity().getApplicationContext(), getString(R.string.no_firmware_found), Toast.LENGTH_LONG).show();
            return;
        }
        for (String file : filesList) {
            mArrayAdapter.add(file);
        }

        fileListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                String filename = filesList.get(i);
                bluetoothManager.setFileName(filename);
                Log.d(TAG, "Selected file: " + filename);
                try {
                    bluetoothManager.setFile(File.getByFileName(filename));
                    initParameterSettings();
                    switchView(2);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });
    }

    private void initParameterSettings() {
        int gpioValuesId = R.array.gpio_values;

        memoryTypeSystemRam = (RadioButton) deviceParameterSettings.findViewById(R.id.memoryTypeSystemRam);
        memoryTypeSystemRam.setOnClickListener(this);
        memoryTypeRetentionRam = (RadioButton) deviceParameterSettings.findViewById(R.id.memoryTypeRetentionRam);
        memoryTypeRetentionRam.setOnClickListener(this);
        memoryTypeSPI = (RadioButton) deviceParameterSettings.findViewById(R.id.memoryTypeSPI);
        memoryTypeSPI.setOnClickListener(this);
        memoryTypeI2C = (RadioButton) deviceParameterSettings.findViewById(R.id.memoryTypeI2C);
        memoryTypeI2C.setOnClickListener(this);

        closeButton = (Button) deviceParameterSettings.findViewById(R.id.buttonClose);
        closeButton.setOnClickListener(this);

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
            String previousText = Statics.getPreviousInput(getActivity(), R.id.blockSize);
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

        deviceNameValue = (TextView) deviceParameterSettings.findViewById(R.id.device_name_value);
        deviceNameValue.setText(bluetoothManager.getDevice().getName());
        fileNameValue = (TextView) deviceParameterSettings.findViewById(R.id.filename_value);
        fileNameValue.setText(bluetoothManager.getFileName());

        imageBankSpinner.setAdapter(imageBankAdapter);
        imageBankSpinner.setOnItemSelectedListener(this);
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
        sclGpioSpinner.setOnItemSelectedListener(this);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.sclGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_SCL_GPIO_VALUE;
        }
        sclGpioSpinner.setSelection(position);

        sdaGpioSpinner.setAdapter(gpioAdapter);
        sdaGpioSpinner.setOnItemSelectedListener(this);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.sdaGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_SDA_GPIO_VALUE;
        }
        sdaGpioSpinner.setSelection(position);

        misoGpioSpinner.setAdapter(gpioAdapter);
        misoGpioSpinner.setOnItemSelectedListener(this);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.misoGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_MISO_VALUE;
        }
        Log.d("position", "MISO: " + position);
        misoGpioSpinner.setSelection(position);

        mosiGpioSpinner.setAdapter(gpioAdapter);
        mosiGpioSpinner.setOnItemSelectedListener(this);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.mosiGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_MOSI_VALUE;
        }
        Log.d("position", "MOSI: " + position);
        mosiGpioSpinner.setSelection(position);

        csGpioSpinner.setAdapter(gpioAdapter);
        csGpioSpinner.setOnItemSelectedListener(this);
        position = gpioAdapter.getPosition(Statics.getPreviousInput(getActivity(), R.id.csGpioSpinner));
        if (position == -1) {
            position = Statics.DEFAULT_CS_VALUE;
        }
        Log.d("position", "CS: " + position);
        csGpioSpinner.setSelection(position);

        sckGpioSpinner.setAdapter(gpioAdapter);
        sckGpioSpinner.setOnItemSelectedListener(this);
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
        Statics.setPreviousInput(getActivity(), R.id.blockSize, blockSize.getText().toString());

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
        LocalBroadcastManager.getInstance(getActivity()).sendBroadcast(intent);
        progressBar.setProgress(0);
        switchView(3);
    }

    private void setMemoryType(int memoryType) {
        clearMemoryTypeChecked();
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
        currentView = viewIndex;
        deviceContainer.setDisplayedChild(viewIndex);
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
        log(message);
    }

    public void log(String message) {
        logWindow.getEditableText().append(message + "\n");
        scroll.post(new Runnable() {
            @Override
            public void run() {
                scroll.fullScroll(ScrollView.FOCUS_DOWN);
            }
        });
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

        // Verify if the soft keyboard is open
        InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(INPUT_METHOD_SERVICE);
        if (imm != null && imm.isAcceptingText() && getActivity().getCurrentFocus() != null)
            imm.hideSoftInputFromWindow(getActivity().getCurrentFocus().getWindowToken(), 0);
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
    public void onNothingSelected(AdapterView<?> parent) {
    }
}
