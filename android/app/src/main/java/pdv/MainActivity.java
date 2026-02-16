package pdv;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import pdv.terminal.TerminalChannelHandler;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.company.smartpos/terminal";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        TerminalChannelHandler bridge = new TerminalChannelHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(bridge);
    }
}
