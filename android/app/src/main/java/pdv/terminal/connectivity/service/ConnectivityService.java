package pdv.terminal.connectivity.service;

import android.content.Context;

import pdv.terminal.connectivity.NetworkStatus;

public interface ConnectivityService {
    NetworkStatus checkConnectivity(Context context);
}