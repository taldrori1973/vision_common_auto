package com.radware.vision.devicesRestApi.topologyTree;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.utils.BodyEntry;
import models.RestResponse;
import models.StatusCode;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static com.radware.vision.utils.SutUtils.*;
import static java.lang.String.format;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/5/2020
 * Time: 1:33 AM
 */
public class TopologyTreeImpl implements TopologyTree {


    private static String REQUESTS_FILE_PATH = "/Vision/SystemConfigTree.json";
    private static String PARENT_ORM_ID_JSON_KEY = "parentOrmID";

    @Override
    public RestStepResult addDevice(String setId) {
        try {

//            get device from sut
            Optional<TreeDeviceManagementDto> treeDeviceManagementDtoOptional = getDeviceManagement(setId);
            if (!treeDeviceManagementDtoOptional.isPresent()) return new RestStepResult(RestStepResult.Status.FAILED,
                    format("The Device with Set Id \"%s\" wasn't found", setId));

            TreeDeviceManagementDto deviceManagementDto = treeDeviceManagementDtoOptional.get();

//            get device Request Body from SUT
            Optional<JsonNode> requestBodyAsJsonNodeOpt = getDeviceRequestBodyAsJson(deviceManagementDto.getDeviceId());

            if (!requestBodyAsJsonNodeOpt.isPresent())
                return new RestStepResult(RestStepResult.Status.FAILED, "No Json Body was returned from the SUT");

//          get and cast JsonNode to ObjectNode because JsonNode is Immutable.
            ObjectNode body = (ObjectNode) requestBodyAsJsonNodeOpt.get();

//            get device parent ormID

            String deviceParentSite = getDeviceParentSite(deviceManagementDto.getDeviceId());
            if (deviceParentSite == null)
                return new RestStepResult(RestStepResult.Status.FAILED, "No parent site was found for this device");

            if (!this.isSiteExist(deviceParentSite)) {//the site not added yet
//                add the site
                RestStepResult result = this.addSite(deviceParentSite);
                if (result.getStatus().equals(RestStepResult.Status.FAILED)) return result;
            }
            String siteOrmId = this.getSiteOrmId(deviceParentSite);

            if (siteOrmId == null)
                return new RestStepResult(RestStepResult.Status.FAILED, "The Site Parent ormID is null");

            body.put(PARENT_ORM_ID_JSON_KEY, siteOrmId);

//            send request

            GenericVisionRestAPI requestApi = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Add Device to the Server");

            requestApi.getRestRequestSpecification().setBody(body.toString());

            RestResponse restResponse = requestApi.sendRequest();

            return restResponse.getStatusCode().equals(StatusCode.OK) ?
                    new RestStepResult(RestStepResult.Status.SUCCESS, restResponse.getBody().getBodyAsString()) :
                    new RestStepResult(RestStepResult.Status.FAILED, restResponse.getBody().getBodyAsString());
        } catch (Exception e) {
            return new RestStepResult(RestStepResult.Status.FAILED, e.getMessage());
        }
    }

    @Override
    public Optional<JsonNode> getDeviceData(String setId) throws Exception {

        Optional<TreeDeviceManagementDto> deviceManagementOpt = getDeviceManagement(setId);
        if (!deviceManagementOpt.isPresent())
            throw new Exception(format("The Device with Set Id \"%s\" wasn't found", setId));

        String managementIp = deviceManagementOpt.get().getManagementIp();

        return this.getDeviceDataByIp(managementIp);
    }

    @Override
    public RestStepResult updateDevice(String setId, List<BodyEntry> bodyEntries) {
        try {

//      get device from sut
            Optional<TreeDeviceManagementDto> treeDeviceManagementDtoOptional = getDeviceManagement(setId);
            if (!treeDeviceManagementDtoOptional.isPresent()) return new RestStepResult(RestStepResult.Status.FAILED,
                    format("The Device with Set Id \"%s\" wasn't found", setId));

            TreeDeviceManagementDto deviceManagementDto = treeDeviceManagementDtoOptional.get();

//      get device Request Body from SUT
            Optional<JsonNode> requestBodyAsJsonNodeOpt = getDeviceRequestBodyAsJson(deviceManagementDto.getDeviceId());

            if (!requestBodyAsJsonNodeOpt.isPresent())
                return new RestStepResult(RestStepResult.Status.FAILED, "No Json Body was returned from the SUT");

//      get and cast JsonNode to ObjectNode because JsonNode is Immutable.
            ObjectNode body = (ObjectNode) requestBodyAsJsonNodeOpt.get();
//      remove not for update fields

            body.remove("type");
            body.remove("parentOrmID");
//      add ormID field
            String ormID = null;

            Optional<JsonNode> deviceDataOpt = this.getDeviceData(setId);
            if (!deviceDataOpt.isPresent())
                return new RestStepResult(RestStepResult.Status.FAILED, "No Device Data Was returned");

            if (deviceDataOpt.get().has("ormID")) ormID = deviceDataOpt.get().get("ormID").asText();
            else return new RestStepResult(RestStepResult.Status.FAILED, "ormID not found to delete the device");

            body.put("ormID", ormID);

            DocumentContext documentContext = JsonPath.parse(body.toString());
            bodyEntries.forEach(bodyEntry -> documentContext.set(bodyEntry.getJsonPath(), bodyEntry.getValue()));

            GenericVisionRestAPI restAPI = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Update Device");
            restAPI.getRestRequestSpecification().setBody(documentContext.jsonString());
            RestResponse restResponse = restAPI.sendRequest();

            return new RestStepResult(
                    restResponse.getStatusCode().equals(StatusCode.OK) ? RestStepResult.Status.SUCCESS : RestStepResult.Status.FAILED,
                    restResponse.getBody().getBodyAsString());

        } catch (Exception e) {
            return new RestStepResult(RestStepResult.Status.FAILED, e.getMessage());

        }
    }

    @Override
    public RestStepResult deleteDevice(String setId) {

        try {
            Optional<JsonNode> deviceDataOpt = this.getDeviceData(setId);
            if (!deviceDataOpt.isPresent())
                return new RestStepResult(RestStepResult.Status.FAILED, "No Device Data Was returned");

            String ormID = null;
            if (deviceDataOpt.get().has("ormID")) ormID = deviceDataOpt.get().get("ormID").asText();
            else return new RestStepResult(RestStepResult.Status.FAILED, "ormID not found to delete the device");

            GenericVisionRestAPI restAPI = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Delete Device");

            Map<String, String> pathParams = new HashMap<>();
            pathParams.put("ormID", ormID);
            restAPI.getRestRequestSpecification().setPathParams(pathParams);

            RestResponse restResponse = restAPI.sendRequest();

            return new RestStepResult(
                    restResponse.getStatusCode().equals(StatusCode.OK) ? RestStepResult.Status.SUCCESS : RestStepResult.Status.FAILED,
                    restResponse.getBody().getBodyAsString());

        } catch (Exception e) {
            return new RestStepResult(RestStepResult.Status.FAILED, e.getMessage());
        }
    }

    @Override
    public RestStepResult addSite(String siteName) {
        try {

            if (this.isSiteExist(siteName))
                return new RestStepResult(RestStepResult.Status.SUCCESS, "Site Already Exist");

            String siteParent = getSiteParent(siteName);

            if (siteParent == null)
                return new RestStepResult(RestStepResult.Status.FAILED, "Sut returns NULL Site Parent");

            if (!this.isSiteExist(siteParent))
                return new RestStepResult(RestStepResult.Status.FAILED, "Site Parent is not added to the tree yet.");

//            get site parent ormID

            String parentOrmId = this.getSiteOrmId(siteParent);

            Map<String, String> bodyAsMap = new HashMap<>();
            bodyAsMap.put("parentOrmID", parentOrmId);
            bodyAsMap.put("name", siteName);

            ObjectMapper objectMapper = new ObjectMapper();
            String jsonBody = objectMapper.valueToTree(bodyAsMap).toString();

            GenericVisionRestAPI requestApi = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Add Site to the Server");
            requestApi.getRestRequestSpecification().setBody(jsonBody);

            RestResponse restResponse = requestApi.sendRequest();

            return new RestStepResult(
                    restResponse.getStatusCode().equals(StatusCode.OK) ? RestStepResult.Status.SUCCESS : RestStepResult.Status.FAILED,
                    restResponse.getBody().getBodyAsString());
        } catch (Exception e) {
            return new RestStepResult(RestStepResult.Status.FAILED, e.getMessage());
        }

    }

    @Override
    public String getSiteOrmId(String siteName) throws Exception {
        GenericVisionRestAPI request = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Get Site by Name");

        Map<String, String> pathParams = new HashMap<>();
        pathParams.put("name", siteName);

        request.getRestRequestSpecification().setPathParams(pathParams);

        RestResponse restResponse = request.sendRequest();
        if (!restResponse.getStatusCode().equals(StatusCode.OK))
            throw new Exception(restResponse.getBody().getBodyAsString());

        Optional<JsonNode> responseJsonNodeOpt = restResponse.getBody().getBodyAsJsonNode();

        if (responseJsonNodeOpt.isPresent()) {
            if (responseJsonNodeOpt.get().has("ormID")) return responseJsonNodeOpt.get().get("ormID").asText();
        }
        return null;
    }

    @Override
    public boolean isSiteExist(String siteName) throws NoSuchFieldException {
        GenericVisionRestAPI request = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Get Site by Name");

        Map<String, String> pathParams = new HashMap<>();
        pathParams.put("name", siteName);

        request.getRestRequestSpecification().setPathParams(pathParams);

        RestResponse restResponse = request.sendRequest();
        return restResponse.getStatusCode().equals(StatusCode.OK);
    }

    @Override
    public RestStepResult deleteSite(String siteName) {
        try {
            GenericVisionRestAPI restAPI = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Delete Site by Name");
            Map<String, String> map = new HashMap<>();
            map.put("name", siteName);
            restAPI.getRestRequestSpecification().setPathParams(map);
            RestResponse restResponse = restAPI.sendRequest();

            if (restResponse.getStatusCode().equals(StatusCode.INTERNAL_SERVER_ERROR) && restResponse.getBody().getBodyAsString().contains("not found"))
                return new RestStepResult(RestStepResult.Status.SUCCESS, "Already not exist");

            return new RestStepResult(
                    restResponse.getStatusCode().equals(StatusCode.OK) ? RestStepResult.Status.SUCCESS : RestStepResult.Status.FAILED,
                    restResponse.getBody().getBodyAsString());
        } catch (NoSuchFieldException e) {
            return new RestStepResult(RestStepResult.Status.FAILED, e.getMessage());
        }
    }


    private Optional<JsonNode> getDeviceDataByIp(String deviceIp) {

        try {
            GenericVisionRestAPI restAPI = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Get Device Data");
            Map<String, String> map = new HashMap<>();
            map.put("ip", deviceIp);
            restAPI.getRestRequestSpecification().setPathParams(map);
            RestResponse restResponse = restAPI.sendRequest();
            if (restResponse.getStatusCode().equals(StatusCode.OK)) return restResponse.getBody().getBodyAsJsonNode();
        } catch (NoSuchFieldException e) {
            return Optional.empty();
        }
        return Optional.empty();

    }
}
