package com.radware.vision.utils;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;

import java.util.Optional;

import static java.util.Objects.isNull;
import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isEmpty;

public class SutUtils {

    private static SUTManager sutManager = SUTManagerImpl.getInstance();
    private static ClientConfigurationDto clientConfigurations = sutManager.getClientConfigurations();

    public static String getCurrentVisionRestProtocol() {
        String restProtocol = clientConfigurations.getRestConnectionDefaultProtocol();
        if (isNull(restProtocol) || isEmpty(restProtocol) || isBlank(restProtocol)) return "HTTP";
        return restProtocol;
    }

    public static Integer getCurrentVisionRestPort() {
        Integer restPort = Integer.parseInt(clientConfigurations.getRestConnectionDefaultPort());
        if (restPort == 0) return 80;
        return restPort;
    }

    public static String getCurrentVisionIp() throws NoSuchFieldException {
        String ip = clientConfigurations.getHostIp();
        if (isNull(ip) || isEmpty(ip) || isBlank(ip)) {
            throw new NoSuchFieldException("Can't read Host Name from SUT file under visionLab/visionServer/host");
        }
        return ip;
    }

    public static String getCurrentVisionRestUserName() throws NoSuchFieldException {
        String userName = clientConfigurations.getUserName();
        if (isNull(userName) || isEmpty(userName) || isBlank(userName)) {
            throw new NoSuchFieldException("Can't read User Name from SUT file");
        }
        return userName;
    }

    public static String getCurrentVisionRestUserPassword() throws NoSuchFieldException {
        String password = clientConfigurations.getPassword();
        if (isNull(password) || isEmpty(password) || isBlank(password)) {
            throw new NoSuchFieldException("Can't read User Password from SUT file");
        }
        return password;
    }

    public static String getCurrentVisionHAIp() throws Exception {
//       kVision- Vision HA
//        String ip = WebUITestBase.getRestTestBase().getVisionServerHA().getHost_2();
//        if (isNull(ip) || isEmpty(ip) || isBlank(ip)) {
//            throw new NoSuchFieldException("Can't read HA Host Name from SUT file under visionCli/visionServer/visionServerHA/Host_2");
//        }
//        return ip;
        return null;
    }


    public static Optional<TreeDeviceManagementDto> getDeviceManagement(String setId) {
        return sutManager.getTreeDeviceManagement(setId);
    }

    public static Optional<JsonNode> getDeviceRequestBodyAsJson(String deviceId) {

        return sutManager.getAddTreeDeviceRequestBodyAsJson(deviceId);
    }

    public static String getDeviceParentSite(String deviceId) {
        return sutManager.getDeviceParentSite(deviceId);
    }

    public static String getSiteParent(String siteName) {
        return sutManager.getSiteParent(siteName);
    }

}
