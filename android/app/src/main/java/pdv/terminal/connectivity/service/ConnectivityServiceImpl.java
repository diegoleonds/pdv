package pdv.terminal.connectivity.service;

import static android.Manifest.permission.ACCESS_NETWORK_STATE;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;

import static android.content.Context.CONNECTIVITY_SERVICE;
import static android.net.NetworkCapabilities.NET_CAPABILITY_INTERNET;
import static android.net.NetworkCapabilities.NET_CAPABILITY_VALIDATED;

import androidx.annotation.RequiresPermission;
import androidx.annotation.VisibleForTesting;

import pdv.terminal.connectivity.NetworkStatus;

import static pdv.terminal.connectivity.NetworkStatus.OFFLINE;
import static pdv.terminal.connectivity.NetworkStatus.ONLINE;

public class ConnectivityServiceImpl implements ConnectivityService {
    @RequiresPermission(ACCESS_NETWORK_STATE)
    @Override
    public NetworkStatus checkConnectivity(Context context) {
        ConnectivityManager connectivityManager = getConnectivityManager(context);
        Network network = getActiveNetwork(connectivityManager);
        if (network == null)
            return OFFLINE;

        NetworkCapabilities capabilities = connectivityManager.getNetworkCapabilities(network);
        if (capabilities != null &&
                capabilities.hasCapability(NET_CAPABILITY_INTERNET) &&
                capabilities.hasCapability(NET_CAPABILITY_VALIDATED)
        ) {
            return ONLINE;
        }
        return OFFLINE;
    }

    @VisibleForTesting
    ConnectivityManager getConnectivityManager(Context context) {
        return (ConnectivityManager)
                context.getSystemService(CONNECTIVITY_SERVICE);
    }

    @VisibleForTesting
    Network getActiveNetwork(ConnectivityManager cm) {
        return cm.getActiveNetwork();
    }
}