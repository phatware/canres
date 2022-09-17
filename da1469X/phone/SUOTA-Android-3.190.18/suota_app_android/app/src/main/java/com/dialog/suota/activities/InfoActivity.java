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

import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.view.MenuItem;

import com.dialog.suota.R;
import com.dialog.suota.fragments.DisclaimerFragment;
import com.dialog.suota.global.Utils;

public class InfoActivity extends SuotaActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fragment);
        Utils.replaceFragment(this, new DisclaimerFragment(), R.id.fragment_container, false);
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null)
            actionBar.setDisplayHomeAsUpEnabled(true);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            finish();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
