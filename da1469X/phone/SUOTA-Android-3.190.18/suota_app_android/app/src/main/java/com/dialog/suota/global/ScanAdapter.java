/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

package com.dialog.suota.global;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.dialog.suota.R;

import java.util.ArrayList;

/**
 * ScanItem adapter for the device list on the main activity
 */
public class ScanAdapter extends ArrayAdapter<ScanItem> {

    private Context mContext;
    private int layoutResourceId;
    private ArrayList<ScanItem> data = null;

    public ScanAdapter(Context mContext, int layoutResourceId, ArrayList<ScanItem> data) {
        super(mContext, layoutResourceId, data);
        this.layoutResourceId = layoutResourceId;
        this.mContext = mContext;
        this.data = data;
    }

    private static class Views {
        TextView name;
        TextView description;
        TextView rssi;
        SignalBar signalBar;
        ImageView pairedImage;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        // Create view
        Views views;
        if (convertView == null) {
            convertView = ((Activity) mContext).getLayoutInflater().inflate(layoutResourceId, parent, false);
            views = new Views();
            views.name = (TextView) convertView.findViewById(R.id.scanItemName);
            views.description = (TextView) convertView.findViewById(R.id.scanItemDescription);
            views.rssi = (TextView) convertView.findViewById(R.id.scanItemRssi);
            views.signalBar = (SignalBar) convertView.findViewById(R.id.signalBar);
            views.pairedImage = (ImageView) convertView.findViewById(R.id.pairedIcon);
            convertView.setTag(views);
        } else {
            views = (Views) convertView.getTag();
        }

        // Update view
        ScanItem scanitem = data.get(position);
        views.pairedImage.setVisibility(scanitem.scanPaired ? View.VISIBLE : View.GONE);
        views.name.setText(scanitem.scanName);
        views.description.setText(scanitem.scanDescription);
        views.rssi.setText(scanitem.scanSignal == -900 ? "" : String.valueOf(scanitem.scanSignal) + "dB");
        views.signalBar.setState(scanitem.scanSignal == -900, scanitem.scanPaired);
        views.signalBar.setRssi(scanitem.scanSignal);
        return convertView;
    }

}
