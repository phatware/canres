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

import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.app.ProgressDialog;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothProfile;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.LayoutRes;
import android.support.v4.content.ContextCompat;
import android.support.v4.content.LocalBroadcastManager;
import android.support.v7.app.ActionBar;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.dialog.suota.R;
import com.dialog.suota.SuotaApplication;
import com.dialog.suota.bluetooth.BluetoothGattReceiver;
import com.dialog.suota.bluetooth.BluetoothGattSingleton;
import com.dialog.suota.bluetooth.BluetoothManager;
import com.dialog.suota.bluetooth.Callback;
import com.dialog.suota.data.Statics;
import com.dialog.suota.fragments.DisclaimerFragment;
import com.dialog.suota.fragments.InfoFragment;
import com.dialog.suota.fragments.SUOTAFragment;
import com.mikepenz.google_material_typeface_library.GoogleMaterial;
import com.mikepenz.materialdrawer.AccountHeader;
import com.mikepenz.materialdrawer.AccountHeaderBuilder;
import com.mikepenz.materialdrawer.Drawer;
import com.mikepenz.materialdrawer.DrawerBuilder;
import com.mikepenz.materialdrawer.model.DividerDrawerItem;
import com.mikepenz.materialdrawer.model.PrimaryDrawerItem;
import com.mikepenz.materialdrawer.model.ProfileDrawerItem;
import com.mikepenz.materialdrawer.model.SecondaryDrawerItem;
import com.mikepenz.materialdrawer.model.interfaces.IDrawerItem;

public class DeviceActivity extends SuotaActivity {
    final static String TAG = "DeviceActivity";

    private SuotaApplication application;
    private BluetoothDevice device;
    private BroadcastReceiver connectionStateReceiver, bluetoothGattReceiver, progressUpdateReceiver;
    private ProgressDialog dialog;
    private Toolbar toolbar;
    private Drawer drawer;
    private int menuSUOTA, menuDeviceInfo, menuDisclaimer;
    private SecondaryDrawerItem disconnectButton;
    private InfoFragment deviceInfoFragment;
    private SUOTAFragment suotaFragment;
    private DisclaimerFragment disclaimerFragment;
    private int previousFragmentID = -1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        application = (SuotaApplication) getApplication();
        setContentView(R.layout.activity_device);

        connectionStateReceiver = new BluetoothGattReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                super.onReceive(context, intent);
                int connectionState = intent.getIntExtra("state", 0);
                connectionStateChanged(connectionState);
            }
        };
        bluetoothGattReceiver = new BluetoothGattReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                super.onReceive(context, intent);
                if (previousFragmentID == 1) {
                    ((SUOTAFragment) getFragmentItem(1)).processStep(intent);
                }
                if (dialog.isShowing() && !intent.hasExtra("suotaMtu")) {
                    dialog.dismiss();
                }
            }
        };
        progressUpdateReceiver = new BluetoothGattReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                super.onReceive(context, intent);
                int progress = intent.getIntExtra("progress", 0);

                if (previousFragmentID == 1 && ((SUOTAFragment) getFragmentItem(1)).progressBar != null) {
                    ((SUOTAFragment) getFragmentItem(1)).progressBar.setProgress(progress);
                }
            }
        };

        toolbar = (Toolbar) findViewById(R.id.sensor_toolbar);
        if (toolbar != null) {
            toolbar.setTitleTextColor(Color.WHITE);
            setSupportActionBar(toolbar);
            toolbar.setTitle(R.string.app_name);
            toolbar.setSubtitle("");
        }

        LocalBroadcastManager.getInstance(this).registerReceiver(
                connectionStateReceiver,
                new IntentFilter(Statics.CONNECTION_STATE_UPDATE));
        LocalBroadcastManager.getInstance(this).registerReceiver(
                bluetoothGattReceiver,
                new IntentFilter(Statics.BLUETOOTH_GATT_UPDATE));
        LocalBroadcastManager.getInstance(this).registerReceiver(
                progressUpdateReceiver,
                new IntentFilter(Statics.PROGRESS_UPDATE));

        device = application.device = (BluetoothDevice) getIntent().getExtras().get("device");
        BluetoothGatt gatt;
        if (Build.VERSION.SDK_INT < 23) {
            gatt = device.connectGatt(this, false, new Callback(this));
        } else {
            gatt = device.connectGatt(this, false, new Callback(this), BluetoothDevice.TRANSPORT_LE);
        }
        BluetoothGattSingleton.setGatt(gatt);

        dialog = new ProgressDialog(this);
        dialog.setMessage("Connecting, please wait...");
        //dialog.setCancelable(false);
        dialog.setCanceledOnTouchOutside(false);
        dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
            @Override
            public void onCancel(DialogInterface dialog) {
                application.resetToDefaults();
                finish();
            }
        });
        dialog.show();

        IDrawerItem[] drawerItems = new IDrawerItem[4];
        int i = 0;
        drawerItems[i++] = new PrimaryDrawerItem().withName(R.string.drawer_suota).withIcon(GoogleMaterial.Icon.gmd_system_update_alt);
        menuSUOTA = i;
        drawerItems[i++] = new DividerDrawerItem();
        drawerItems[i++] = new PrimaryDrawerItem().withName(R.string.drawer_information).withIcon(R.drawable.cic_info).withSelectedIcon(R.drawable.cic_info_selected);
        menuDeviceInfo = i;
        drawerItems[i] = new PrimaryDrawerItem().withName(R.string.drawer_disclaimer).withIcon(R.drawable.cic_disclaimer).withSelectedIcon(R.drawable.cic_disclaimer_selected);
        menuDisclaimer = i + 1;

        disconnectButton = new SecondaryDrawerItem() {
            @Override
            public void onPostBindView(IDrawerItem drawerItem, View view) {
                super.onPostBindView(drawerItem, view);
                view.setBackgroundColor(getResources().getColor(R.color.button_color));
            }

            @Override
            @LayoutRes
            public int getLayoutRes() {
                return R.layout.disconnect_drawer_button;
            }
        };

        disconnectButton
                .withTextColor(ContextCompat.getColor(this, android.R.color.white))
                .withName(R.string.drawer_disconnect)
                .withIdentifier(300)
                .withEnabled(true);

        drawer = createNavDrawer(drawerItems);
        changeFragment(getFragmentItem(1), 1);
    }

    @Override
    protected void onDestroy() {
        Log.d(TAG, "onDestroy");
        if (dialog != null && dialog.isShowing()) {
            dialog.dismiss();
        }
        suotaFragment.bluetoothManager.disconnect();
        LocalBroadcastManager.getInstance(this).unregisterReceiver(connectionStateReceiver);
        LocalBroadcastManager.getInstance(this).unregisterReceiver(bluetoothGattReceiver);
        LocalBroadcastManager.getInstance(this).unregisterReceiver(progressUpdateReceiver);
        super.onDestroy();
    }

    @Override
    public void onBackPressed() {
        if (drawer.isDrawerOpen()) {
            drawer.closeDrawer();
            return;
        }
        if (previousFragmentID == 1) {
            if (!((SUOTAFragment) getFragmentItem(1)).onBackPressed()) {
                super.onBackPressed();
            }
        } else {
            super.onBackPressed();
        }
    }

    private void connectionStateChanged(int connectionState) {
        if (connectionState == BluetoothProfile.STATE_DISCONNECTED) {
            Toast.makeText(this, device.getName() + " disconnected", Toast.LENGTH_LONG).show();
            suotaFragment.setDisconnected(true);
            if (BluetoothGattSingleton.getGatt() != null) {
                // Refresh device cache if update was successful
                if (suotaFragment.bluetoothManager.isRefreshPending())
                    BluetoothManager.refresh(BluetoothGattSingleton.getGatt());
                BluetoothGattSingleton.getGatt().close();
            }
            if (!suotaFragment.bluetoothManager.isFinished() && !suotaFragment.bluetoothManager.getError()) {
                application.resetToDefaults();
                finish();
            }
        }
    }

    public Fragment getFragmentItem(final int position) {
        if (position == menuDeviceInfo) {
            if (deviceInfoFragment == null) {
                deviceInfoFragment = new InfoFragment();
            }
            return deviceInfoFragment;
        } else if (position == menuSUOTA) {
            if (suotaFragment == null) {
                suotaFragment = new SUOTAFragment();
            }
            return suotaFragment;
        } else if (position == menuDisclaimer) {
            if (disclaimerFragment == null) {
                disclaimerFragment = new DisclaimerFragment();
            }
            return disclaimerFragment;
        } else {
            return new Fragment();
        }
    }

    private Drawer createNavDrawer(IDrawerItem[] drawerItems) {
        AccountHeader accountHeader = new AccountHeaderBuilder()
                .withActivity(this)
                .withHeaderBackground(R.color.navigation_bar_background)
                .addProfiles(new ProfileDrawerItem().withName(getString(R.string.app_name)).withEmail(getString(R.string.dialog_semiconductor)))
                .withProfileImagesClickable(false)
                .withProfileImagesVisible(false)
                .withSelectionListEnabledForSingleProfile(false)
                .withTextColor(getResources().getColor(android.R.color.white))
                .build();

        Drawer drawer = new DrawerBuilder().withActivity(this)
                .withAccountHeader(accountHeader)
                .withToolbar(toolbar)
                .addDrawerItems(drawerItems)
                .withOnDrawerItemClickListener(new Drawer.OnDrawerItemClickListener() {
                    @Override
                    public boolean onItemClick(View view, int position, IDrawerItem drawerItem) {
                        Log.d(TAG, "Menu position: " + String.valueOf(position));
                        if (position == menuSUOTA) {
                            toolbar.setSubtitle(R.string.drawer_suota);
                        } else if (position == menuDeviceInfo) {
                            toolbar.setSubtitle(R.string.drawer_information);
                        } else if (position == menuDisclaimer) {
                            toolbar.setSubtitle(R.string.drawer_disclaimer);
                        }
                        if (position == -1) {
                            finish();
                        } else {
                            changeFragment(getFragmentItem(position), position);
                        }
                        return false;
                    }
                })
                .addStickyDrawerItems(disconnectButton)
                .withStickyFooterShadow(false)
                .build();
        ActionBar actionBar = getSupportActionBar();

        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(false);
            drawer.getActionBarDrawerToggle().setDrawerIndicatorEnabled(true);
        }
        return drawer;
    }

    public void changeFragment(Fragment newFragment, int position) {
        FragmentManager fragmentManager = getFragmentManager();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.replace(R.id.fragment_container, newFragment);
        fragmentTransaction.commit();
        previousFragmentID = position;
    }
}
