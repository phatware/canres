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

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.WindowManager;

import com.dialog.suota.R;
import com.dialog.suota.fragments.SplashFragment;
import com.dialog.suota.global.BusProvider;
import com.dialog.suota.global.Utils;
import com.squareup.otto.Subscribe;

public class SplashActivity extends AppCompatActivity {

    private boolean exitEventReceived;

    @Override
    public void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_fragment);
        Utils.replaceFragment(this, new SplashFragment(), R.id.fragment_container, false);
        BusProvider.getInstance().register(this);
    }

    @Override
    protected void onDestroy() {
        BusProvider.getInstance().unregister(this);
        super.onDestroy();
    }

    @SuppressWarnings("unused")
    @Subscribe
    public void onSplashExit(final SplashFragment.SplashEvent event) {
        if (exitEventReceived)
            return;
        exitEventReceived = true;
        finish();
        Intent intent = new Intent(this, ScanActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent);
        overridePendingTransition(0, 0);
    }
}
