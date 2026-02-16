package pdv.terminal.connectivity.service;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.*;
import static android.net.NetworkCapabilities.*;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;

import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import pdv.terminal.connectivity.NetworkStatus;

public class ConnectivityServiceImplTest {

    private ConnectivityServiceImpl service;

    @Mock
    private Context mockContext;

    @Mock
    private ConnectivityManager mockConnectivityManager;

    @Mock
    private Network mockNetwork;

    @Mock
    private NetworkCapabilities mockCapabilities;

    @Before
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        service = spy(new ConnectivityServiceImpl());
        doReturn(mockConnectivityManager).when(service).getConnectivityManager(mockContext);
    }

    @Test
    public void checkConnectivity_shouldReturnOffline_whenNetworkIsNull() {
        doReturn(null).when(service).getActiveNetwork(mockConnectivityManager);

        NetworkStatus result = service.checkConnectivity(mockContext);

        assertEquals(NetworkStatus.OFFLINE, result);
    }

    @Test
    public void checkConnectivity_shouldReturnOnline_whenNetworkIsConnectedAndValidated() {
        doReturn(mockNetwork).when(service).getActiveNetwork(mockConnectivityManager);
        doReturn(mockCapabilities).when(mockConnectivityManager).getNetworkCapabilities(mockNetwork);
        doReturn(true).when(mockCapabilities).hasCapability(NET_CAPABILITY_INTERNET);
        doReturn(true).when(mockCapabilities).hasCapability(NET_CAPABILITY_VALIDATED);

        NetworkStatus result = service.checkConnectivity(mockContext);

        assertEquals(NetworkStatus.ONLINE, result);
    }

    @Test
    public void checkConnectivity_shouldReturnOffline_whenNetworkIsNotValidated() {
        doReturn(mockNetwork).when(service).getActiveNetwork(mockConnectivityManager);
        doReturn(mockCapabilities).when(mockConnectivityManager).getNetworkCapabilities(mockNetwork);

        doReturn(true).when(mockCapabilities).hasCapability(NET_CAPABILITY_INTERNET);
        doReturn(false).when(mockCapabilities).hasCapability(NET_CAPABILITY_VALIDATED);

        NetworkStatus result = service.checkConnectivity(mockContext);

        assertEquals(NetworkStatus.OFFLINE, result);
    }

    @Test
    public void checkConnectivity_shouldReturnOffline_whenCapabilitiesAreNull() {
        doReturn(mockNetwork).when(service).getActiveNetwork(mockConnectivityManager);
        doReturn(null).when(mockConnectivityManager).getNetworkCapabilities(null);

        NetworkStatus result = service.checkConnectivity(mockContext);

        assertEquals(NetworkStatus.OFFLINE, result);
    }
}