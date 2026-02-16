package pdv.terminal.receipt.service;

import org.junit.Test;
import java.util.Map;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class PrintServiceMockTest {

    private final PrintServiceMock service = new PrintServiceMock();

    @Test
    public void print_shouldReturnOkStatus_whenCalledWithAnyArguments() {
        Map<String, Object> args = Map.of(
                "content", "Test Print",
                "copies", 1
        );

        Map<String, String> result = service.print(args);

        assertEquals("OK", result.get("status"));
        assertEquals("Mock print successful", result.get("message"));
    }
}