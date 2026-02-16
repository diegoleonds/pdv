package pdv.terminal.payment.service;

import static pdv.terminal.payment.PaymentStatus.APPROVED;
import static pdv.terminal.payment.PaymentStatus.DECLINED;
import static pdv.terminal.payment.PaymentStatus.ERROR;

import pdv.terminal.payment.PaymentStatus;

import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ThreadLocalRandom;

public class PaymentServiceMock implements PaymentService {
    @Override
    public Map<String, String> authorize(Map<String, String> args) {
        var forceOutcome = args.get("forceOutcome");
        String statusName;
        if (Objects.equals(forceOutcome, "RANDOM")) {
            statusName = PaymentStatus.values()[
                    ThreadLocalRandom.current().nextInt(PaymentStatus.values().length)
                    ].name();
        } else {
            try {
                PaymentStatus status = PaymentStatus.valueOf(forceOutcome);
                statusName = status.name();
            } catch (Exception e) {
                statusName = APPROVED.name();
            }
        }
        if (statusName.equals(DECLINED.name()) || statusName.equals(ERROR.name())) {
            return Map.of(
                    "status", statusName,
                    "message", "some message"
            );
        }
        return Map.of(
                "status", statusName,
                "authCode", "ABC123",
                "message", "some message"
        );
    }
}