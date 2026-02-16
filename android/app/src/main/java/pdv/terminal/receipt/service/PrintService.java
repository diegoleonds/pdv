package pdv.terminal.receipt.service;

import java.util.Map;

public interface PrintService {
    Map<String, String> print(Map<String, Object> args);
}