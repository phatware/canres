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

import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;

import com.dialog.suota.R;

public abstract class SuotaActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            getWindow().setStatusBarColor(getResources().getColor(R.color.status_bar_background));
            getWindow().setNavigationBarColor(getResources().getColor(R.color.navigation_bar_background));
        }
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#347ab8"));
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setBackgroundDrawable(colorDrawable);
            actionBar.setTitle(R.string.app_name);
            actionBar.setSubtitle(R.string.dialog_semiconductor);
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        menu.findItem(R.id.menu_scan).setVisible(false);
        menu.findItem(R.id.menu_disconnect).setVisible(false);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        switch (id) {
            case R.id.menu_scan:
            case R.id.menu_disconnect:
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void changeActionbarTitle(String subtitle) {
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setSubtitle(subtitle);
        }
        Toolbar toolbar = (Toolbar) findViewById(R.id.sensor_toolbar);
        if (toolbar != null) {
            toolbar.setTitle(R.string.app_name);
            toolbar.setSubtitle(subtitle);
        }
    }
}
