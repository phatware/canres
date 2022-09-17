/*
 *******************************************************************************
 *
 * Copyright (C) 2016 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

package com.dialog.suota.global;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.content.Context;
import android.view.View;
import android.view.ViewPropertyAnimator;

import java.io.BufferedReader;
import java.io.IOException;

public class Utils {
    public static void showProgress(final Context context, final View fragmentContainer,
                                    final View progressView, final boolean show) {
        showView(fragmentContainer, !show);
        animate(context, fragmentContainer, !show);
        showView(progressView, show);
        animate(context, progressView, show);
    }

    private static void showView(final View view, final boolean show) {
        if (show) {
            view.setVisibility(View.VISIBLE);
        } else {
            view.setVisibility(View.GONE);
        }
    }

    private static void animate(final Context context, final View view, final boolean show) {
        // On Honeycomb MR2 we have the ViewPropertyAnimator APIs, which allow
        // for very easy animations. If available, use these APIs to fade-in the
        // progress spinner.
        int shortAnimTime = context.getResources().getInteger(
                android.R.integer.config_shortAnimTime);
        ViewPropertyAnimator animator = view.animate();
        animator.setDuration(shortAnimTime);
        if (show) {
            animator.alpha(1);
        } else {
            animator.alpha(0);
        }
        animator.setListener(new AnimatorListenerAdapter() {

            @Override
            public void onAnimationEnd(final Animator animation) {
                showView(view, show);
            }
        });
    }

    /**
     * @param r Reader
     * @return String
     */
    public static String readerToString(BufferedReader r) {
        String line;
        StringBuilder sb = new StringBuilder();
        try {
            while ((line = r.readLine()) != null) {
                sb.append(line);
                sb.append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static void replaceFragment(final Activity activity, final Fragment fragment,
                                       final int layoutResourceId, final boolean addToBackstack) {
        FragmentTransaction fragmentTransaction = activity.getFragmentManager()
                .beginTransaction();
        fragmentTransaction.replace(layoutResourceId, fragment);
        if (addToBackstack) {
            fragmentTransaction.addToBackStack(fragment.getClass().getName());
        }
        fragmentTransaction.commit();

    }
}
