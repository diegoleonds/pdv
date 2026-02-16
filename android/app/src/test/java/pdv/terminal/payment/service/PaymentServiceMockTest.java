package pdv.terminal.payment.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;

import java.util.Map;

public class PaymentServiceMockTest {
    private final PaymentService service = new PaymentServiceMock();

    @Test
    public void authorize_shouldReturnApproved_whenForceOutcomeIsInvalid() {
        Map<String, String> args = Map.of("forceOutcome", "INVALID_DATA");

        Map<String, String> result = service.authorize(args);

        assertEquals("APPROVED", result.get("status"));
        assertEquals("ABC123", result.get("authCode"));
    }

    @Test
    public void authorize_shouldNotIncludeAuthCode_whenStatusIsDeclined() {
        Map<String, String> args = Map.of("forceOutcome", "DECLINED");

        Map<String, String> result = service.authorize(args);

        assertEquals("DECLINED", result.get("status"));
        assertFalse(result.containsKey("authCode"));
    }

    @Test
    public void authorize_shouldNotIncludeAuthCode_whenStatusIsError() {
        Map<String, String> args = Map.of("forceOutcome", "ERROR");

        Map<String, String> result = service.authorize(args);

        assertEquals("ERROR", result.get("status"));
        assertFalse(result.containsKey("authCode"));
    }

    @Test
    public void authorize_shouldReturnValidStatus_whenForceOutcomeIsRandom() {
        Map<String, String> args = Map.of("forceOutcome", "RANDOM");

        Map<String, String> result = service.authorize(args);

        assertNotNull(result.get("status"));
        assertNotNull(result.get("message"));
    }

    @Test
    public void authorize_shouldReturnApproved_whenForceOutcomeIsMissing() {
        Map<String, String> args = Map.of();

        Map<String, String> result = service.authorize(args);

        assertEquals("APPROVED", result.get("status"));
        assertEquals("ABC123", result.get("authCode"));
    }
}