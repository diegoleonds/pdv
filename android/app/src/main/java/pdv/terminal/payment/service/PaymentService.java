package pdv.terminal.payment.service;

import java.util.Map;

public interface PaymentService {
    Map<String, String> authorize(Map<String, String> args);
}