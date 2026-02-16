package pdv.terminal.receipt.service;

import static pdv.terminal.receipt.PrintStatus.OK;

import android.util.Log;

import java.util.Map;

public class PrintServiceMock implements PrintService {
    @Override
    public Map<String, String> print(Map<String, Object> args) {
        Log.i("PrintServiceMock", args.toString());
        return Map.of(
                "status", OK.name(),
                "message", "Mock print successful"
        );
    }
}