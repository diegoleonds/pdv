package pdv.terminal;

import android.content.Context;

import androidx.annotation.NonNull;

import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import pdv.terminal.connectivity.service.ConnectivityService;
import pdv.terminal.connectivity.service.ConnectivityServiceImpl;
import pdv.terminal.payment.service.PaymentService;
import pdv.terminal.payment.service.PaymentServiceMock;
import pdv.terminal.receipt.service.PrintService;
import pdv.terminal.receipt.service.PrintServiceMock;

public class TerminalChannelHandler implements MethodChannel.MethodCallHandler {
    private final ExecutorService executor;
    private final Context context;

    public TerminalChannelHandler(Context context) {
        this.executor = Executors.newSingleThreadExecutor();
        this.context = context;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "checkConnectivity":
                checkConnectivity(call, result);
                break;
            case "requestCardPayment":
                requestCardPayment(call, result);
                break;
            case "printReceipt":
                printReceipt(call, result);
                break;
            default:
                result.error("METHOD_NOT_FOUND", "Unknown method", null);
        }
    }

    private void requestCardPayment(@NonNull MethodCall call, @NonNull Result result) {
        PaymentService paymentService = new PaymentServiceMock();
        executor.execute(() -> {
            try {
                Thread.sleep(1000L);
                Map<String, String> args = (Map<String, String>) call.arguments;
                result.success(paymentService.authorize(args));
            } catch (InterruptedException e) {
                result.error("INTERRUPTED", "Payment process was interrupted", null);
            }
        });
    }

    private void printReceipt(@NonNull MethodCall call, @NonNull Result result) {
        PrintService printService = new PrintServiceMock();
        Map<String, Object> payload = (Map<String, Object>) call.arguments;
        result.success(printService.print(payload));
    }

    private void checkConnectivity(@NonNull MethodCall call, @NonNull Result result) {
        ConnectivityService connectivityService = new ConnectivityServiceImpl();
        result.success(Map.of(
                "network",
                connectivityService.checkConnectivity(context).name()));
    }
}
