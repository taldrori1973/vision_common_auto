package models;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

@Data
@AllArgsConstructor
public class RestResponse {

    private StatusCode statusCode;
    private String statusLine;
    private Body body;
    private Map<String, String> headers;
    private Map<String, String> cookies;
    private ContentType contentType;
    private String sessionId;
    private long time;

    /**
     *
     * @param timeUnit
     * @return the time in @timeUnit , and -1 if the @timeUnit=-1
     */
    public long getTimeIn(TimeUnit timeUnit) {
        if (Objects.isNull(timeUnit)) return -1;
        if (this.time != -1 && timeUnit != java.util.concurrent.TimeUnit.MILLISECONDS) {
            this.time = timeUnit.convert(this.time, java.util.concurrent.TimeUnit.MILLISECONDS);
        }
        return time;
    }
}
