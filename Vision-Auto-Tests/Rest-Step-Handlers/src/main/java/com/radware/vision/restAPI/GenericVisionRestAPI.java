package com.radware.vision.restAPI;

import com.radware.vision.RestStepResult;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import com.radware.vision.restTestHandler.RestClientsStepsHandler;
import controllers.RestApiManagement;
import lombok.Getter;
import models.RestRequestSpecification;
import models.RestResponse;
import restInterface.RestApi;

import java.net.ConnectException;

import static com.radware.vision.utils.SutUtils.*;
import static com.radware.vision.utils.UriUtils.buildUrlFromProtocolAndIp;

@Getter
public class GenericVisionRestAPI {

    private static RestApi restApi = RestApiManagement.getRestApi();
    private RestRequestSpecification restRequestSpecification;
    private String baseUri;
    private Integer port;
    private String username;
    private String password;
    private String licenseKey;

    /**
     * This is for Current Vision Requests , using Sut Params
     * @param requestFilePath
     * @param requestLabel
     * @throws NoSuchFieldException
     */
    public GenericVisionRestAPI(String requestFilePath, String requestLabel) throws NoSuchFieldException {
        this(
                buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), getCurrentVisionIp())
                , getCurrentVisionRestPort()
                , getCurrentVisionRestUserName()
                , getCurrentVisionRestUserPassword()
                , null
                , requestFilePath
                , requestLabel
        );
    }

    /**
     * @param baseUri             : the request will be sent to https://<visionIp>
     * @param port                 :nullable , default value 443
     * @param username             : login username
     * @param password             :login password
     * @param licenseKey:nullable, vision activation license key
     * @param requestFilePath      : request file path under APSoluteVisionAutomation\Vision-Auto-Tests\Vision-Tests\src\main\resources\restApis\Generic-REST-API\requests\
     *                             for example for user the SystemConfigItemList file under vision folder the value should be Vision/SystemConfigItemList.json
     * @param requestLabel         :request label under the file
     */
    public GenericVisionRestAPI(String baseUri, Integer port, String username, String password, String licenseKey, String requestFilePath, String requestLabel) {
        this.baseUri = baseUri;
        this.port = port;
        this.username = username;
        this.password = password;
        this.licenseKey = licenseKey;
        this.restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification(requestFilePath, requestLabel);
    }

    public RestResponse sendRequest() {
        try {
            RestStepResult loginResult = RestClientsStepsHandler.genericVisionLogIn(this.baseUri, this.port, this.username, this.password, this.licenseKey);
            if (loginResult.getStatus().equals(RestStepResult.Status.FAILED))
                throw new ConnectException(loginResult.getMessage());

            return restApi.sendRequest(this.restRequestSpecification);


        } catch (ConnectException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return null;
        }

    }
}
