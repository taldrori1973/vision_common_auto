package com.radware.vision.restBddTests.utils;

import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.BaseHandler;

import static java.util.Objects.isNull;
import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isEmpty;

public class SutUtils {

    public static String getCurrentVisionRestProtocol() {
        String restProtocol = WebUITestBase.getRestTestBase().getVisionlab().visionServer.getRestProtocol();
        if (isNull(restProtocol) || isEmpty(restProtocol) || isBlank(restProtocol)) return "HTTP";
        return restProtocol;
    }

    public static String getCurrentVisionIp() throws NoSuchFieldException {
        String ip = WebUITestBase.getRestTestBase().getVisionServer().getHost();
        if (isNull(ip) || isEmpty(ip) || isBlank(ip)) {
            throw new NoSuchFieldException("Can't read Host Name from SUT file under visionLab/visionServer/host");
        }
        return ip;
    }

    public static String getCurrentVisionRestUserName() throws NoSuchFieldException {
        String userName = WebUITestBase.getRestTestBase().getVisionServer().getUser();
        if (isNull(userName) || isEmpty(userName) || isBlank(userName)) {
            throw new NoSuchFieldException("Can't read User Name from SUT file under " + WebUITestBase.getRestTestBase().getVisionServer().getXPath());
        }
        return userName;
    }

    public static String getCurrentVisionRestUserPassword() throws NoSuchFieldException {
        String password = WebUITestBase.getRestTestBase().getVisionServer().getPassword();
        if (isNull(password) || isEmpty(password) || isBlank(password)) {
            throw new NoSuchFieldException("Can't read User Password from SUT file under" + WebUITestBase.getRestTestBase().getVisionServer().getXPath());
        }
        return password;
    }

    public static String getCurrentVisionHAIp() throws Exception {
        String ip = WebUITestBase.getRestTestBase().getVisionServerHA().getHost_2();
        if (isNull(ip) || isEmpty(ip) || isBlank(ip)) {
            throw new NoSuchFieldException("Can't read HA Host Name from SUT file under visionCli/visionServer/visionServerHA/Host_2");
        }
        return ip;
    }


    public static String getDeviceIp(SUTDeviceType sutDeviceType, int deviceNumber) throws Exception {
        DeviceInfo deviceInfo = BaseHandler.devicesManager.getDeviceInfo(sutDeviceType, deviceNumber);
        return deviceInfo.getDeviceIp();
    }

    public static String getDeviceUserName(SUTDeviceType sutDeviceType, int deviceNumber) throws Exception {
        DeviceInfo deviceInfo = BaseHandler.devicesManager.getDeviceInfo(sutDeviceType, deviceNumber);
        return deviceInfo.getUsername();
    }

    public static String getDevicePassword(SUTDeviceType sutDeviceType, int deviceNumber) throws Exception {
        DeviceInfo deviceInfo = BaseHandler.devicesManager.getDeviceInfo(sutDeviceType, deviceNumber);
        return deviceInfo.getPassword();
    }
}
