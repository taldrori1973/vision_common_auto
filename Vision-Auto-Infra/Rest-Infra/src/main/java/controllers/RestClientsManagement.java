package controllers;

import controllers.restAssured.client.BasicAuth.AlteonRestAssuredClient;
import controllers.restAssured.client.BasicAuth.AppWallRestAssuredClient;
import controllers.restAssured.client.SessionBased.OnVisionVDirectRestAssuredClient;
import controllers.restAssured.client.SessionBased.VisionRestAssuredClient;
import restInterface.client.RestClient;

import java.util.Objects;
import java.util.Optional;

public class RestClientsManagement {


    private static RestClient currentConnection;

    public static RestClient getVisionConnection(String baseUri, String username, String password) {
        return new VisionRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getOnVisionVDirectConnection(String baseUri, String username, String password) {
        return new OnVisionVDirectRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getAlteonConnection(String baseUri, String username, String password) {
        return new AlteonRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getAppWallConnection(String baseUri, String username, String password) {
        return new AppWallRestAssuredClient(baseUri, username, password);
    }

    public static Optional<RestClient> getCurrentConnection() {
        if (Objects.isNull(currentConnection)) return Optional.empty();
        return Optional.of(currentConnection);
    }

    public static void setCurrentConnection(RestClient currentConnection) {
        RestClientsManagement.currentConnection = currentConnection;
    }

    public static RestClient getVisionConnection(String baseUri, Integer connectionPort, String username, String password) {
        return new VisionRestAssuredClient(baseUri, connectionPort, username, password);
    }

    public static RestClient getVisionConnection(String baseUri, Integer connectionPort, String username, String password, String license) {
        return new VisionRestAssuredClient(baseUri, connectionPort, username, password, license);
    }
}
