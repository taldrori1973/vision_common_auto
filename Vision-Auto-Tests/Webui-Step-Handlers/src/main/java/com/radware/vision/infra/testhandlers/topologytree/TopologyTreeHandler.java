package com.radware.vision.infra.testhandlers.topologytree;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.api.popups.PopupContent;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIWidget;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.base.pages.topologytree.*;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.utils.GeneralUtils;
import com.radware.vision.infra.utils.MouseUtils;
import com.radware.vision.infra.utils.ReportsUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.*;

import static com.radware.vision.infra.enums.TopologyTreeTabs.PhysicalContainers;

public class TopologyTreeHandler {
    public static String snmpV1VersionText = "SNMPv1";
    public static String snmpV2VersionText = "SNMPv2";
    public static String snmpV3VersionText = "SNMPv3";

    private static String deviceName;

    public static void addNewSite(String siteName, String parentNode) {
        DeviceProperties newSiteProperties = new StandardDeviceProperties();
        expandAllPhysical();
        expandAllSitesClusters();
        clickTreeNode(parentNode);
        newSiteProperties.openAddNewElementDialog();
        newSiteProperties.setSiteType();
        newSiteProperties.setElementName(siteName);
        DeviceProperties.submit();
    }

    public static void addNewDevice(SUTDeviceType elementType, String deviceName, String parentNode, String managementIP, String visionServerIP, boolean registerVisionServer, HashMap<String, String> properties, TopologyTreeTabs topologyTreeTab) {
        openTab(topologyTreeTab);
        clickTreeNode(parentNode);
        if (!isTreeNodeExist(deviceName)) {
            DeviceProperties deviceProperties = new StandardDeviceProperties();
            innerNewDevice(deviceProperties, elementType, deviceName, parentNode, managementIP, visionServerIP, registerVisionServer, properties);
            if (topologyTreeTab.equals(TopologyTreeTabs.PhysicalContainers)) {
                BasicOperationsHandler.delay(180);
                WebUIUpperBar.select(UpperBarItems.Refresh);
            }
        } else {
            BaseTestUtils.report("Device already exists: " + deviceName, Reporter.PASS);
        }

    }

    public static void openAddNewTopologyElement() {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        deviceProperties.openAddNewElementDialog();
    }

    private static void innerNewDevice(DeviceProperties deviceProperties, SUTDeviceType elementType, String deviceName, String parentNode, String managementIP, String visionServerIP, boolean registerForDeviceEvents, HashMap<String, String> properties) {
        deviceProperties.openAddNewElementDialog();

        deviceProperties.setType(elementType);
        BasicOperationsHandler.delay(0.5);
        deviceProperties.setElementName(deviceName);
        assert properties != null;
        if (elementType != SUTDeviceType.AppWall) {
            deviceProperties.mSnmp().setSnmpV2ReadCommunity(properties.get("snmpReadCommunity"));
            deviceProperties.mSnmp().setSnmpV2WriteCommunity(properties.get("snmpWriteCommunity"));
            if (elementType.equals(SUTDeviceType.DefensePro)) {
                deviceProperties.mWebAccess().setUserName(properties.get("httpUserNameDefensePro"));
                deviceProperties.mWebAccess().setPassword(properties.get("httpPasswordDefensePro"));
            }

            deviceProperties.mSnmp().setManagementIp(managementIP);
//            deviceProperties.mEventNotification().setRegisterVisionServerForDeviceEvents(registerForDeviceEvents);
//            if (registerForDeviceEvents) {
//                deviceProperties.mEventNotification().setVisionServerIp(visionServerIP);
//            }
        } else {
            deviceProperties.mWebAccess().setManagementIp(managementIP);
        }
        deviceProperties.mEventNotification().setRegisterVisionServerForDeviceEvents(registerForDeviceEvents);
        if (registerForDeviceEvents) {
            deviceProperties.mEventNotification().setVisionServerIp(visionServerIP);
        }

        waitForNonSynchronizedState(deviceProperties);
    }


    public static void deleteDevice(String deviceName) {
        deleteDevice(deviceName, TopologyTreeTabs.SitesAndClusters);
    }

    public static void deleteDevice(String deviceName, TopologyTreeTabs topologyTreeTab) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        openTab(topologyTreeTab);
        clickTreeNode(deviceName);
        deviceProperties.deleteElement(deviceName);
    }

    public static void selectDevice(String deviceName, TopologyTreeTabs topologyTreeTab) {
        if (topologyTreeTab != TopologyTreeTabs.SitesAndClusters) openTab(topologyTreeTab);
        expandTree(topologyTreeTab);
        clickTreeNode(deviceName);
    }

    public static void editAppWall(HashMap<String, String> devPorperties) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        openSitesAndClusters();
        deviceProperties.selectTreeNode(devPorperties.get("deviceName"));
        deviceProperties.openEditElementDialog();

        //deviceProperties.mWebAccess().setVerifyHttpAccess(Boolean.parseBoolean(devPorperties.get("verifyHttpAccess")));
        //deviceProperties.mWebAccess().setVerifyHttpsAccess(Boolean.parseBoolean(devPorperties.get("verifyHttpsAccess")));
        deviceProperties.mWebAccess().setUserName(devPorperties.get("httpUserName"));
        deviceProperties.mWebAccess().setPassword(devPorperties.get("httpPassword"));
        deviceProperties.mWebAccess().setHttpsPort(Integer.parseInt(devPorperties.get("httpsPort")));

        deviceProperties.mEventNotification().setRegisterVisionServerForDeviceEvents(Boolean.parseBoolean(devPorperties.get("registerVisionServer")));
        if (Boolean.parseBoolean(devPorperties.get("registerVisionServer"))) {
            deviceProperties.mEventNotification().setVisionServerIp(devPorperties.get("visionServerIP"));
            deviceProperties.mEventNotification().setRemoveAllOtherTargets(Boolean.parseBoolean(devPorperties.get("removeTargets")));
        }

        waitForNonSynchronizedState(deviceProperties);
    }


    public static void editAlteon(HashMap<String, String> devPorperties) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        openSitesAndClusters();
        deviceProperties.selectTreeNode(devPorperties.get("deviceName"));
        deviceProperties.openEditElementDialog();

        if (devPorperties.get("snmpVersion") != null) {
            switch (com.radware.vision.pojomodel.helpers.constants.ImConstants$SnmpVersionEnumPojo.valueOf(devPorperties.get("snmpVersion"))) {
                case SNMP_V1:
                    deviceProperties.mSnmp().setSnmpVersion(snmpV1VersionText);
                    if (devPorperties.get("writeCommunityAlteon") != null)
                        deviceProperties.mSnmp().setSnmpV1WriteCommunity(devPorperties.get("writeCommunityAlteon"));
                    if (devPorperties.get("readCommunity") != null)
                        deviceProperties.mSnmp().setSnmpV1ReadCommunity(devPorperties.get("readCommunity"));
                    break;
                case SNMP_V2:
                    deviceProperties.mSnmp().setSnmpVersion(snmpV2VersionText);
                    if (devPorperties.get("writeCommunityAlteon") != null)
                        deviceProperties.mSnmp().setSnmpV2WriteCommunity(devPorperties.get("writeCommunityAlteon"));
                    if (devPorperties.get("readCommunity") != null)
                        deviceProperties.mSnmp().setSnmpV2ReadCommunity(devPorperties.get("readCommunity"));
                    break;
                case SNMP_V3:
                    deviceProperties.mSnmp().setSnmpVersion(snmpV3VersionText);
                    if (devPorperties.get("snmpV3Username") != null)
                        deviceProperties.mSnmp().setSnmpUserName(devPorperties.get("snmpV3Username"));
                    if (devPorperties.get("useSnmpV3Authentication") != null)
                        deviceProperties.mSnmp().setUseAuthentication(Boolean.parseBoolean(devPorperties.get("useSnmpV3Authentication")));
                    if (devPorperties.get("useSnmpV3Authentication") != null && Boolean.parseBoolean(devPorperties.get("useSnmpV3Authentication"))) {
                        if (devPorperties.get("snmpV3AuthenticationProtocol") != null)
                            deviceProperties.mSnmp().setAuthenticationProtocol(devPorperties.get("snmpV3AuthenticationProtocol"));
                        if (devPorperties.get("snmpV3AuthenticationPassword") != null)
                            deviceProperties.mSnmp().setAuthenticationPassword(devPorperties.get("snmpV3AuthenticationPassword"));
                        if (devPorperties.get("useSnmpV3Privacy") != null)
                            deviceProperties.mSnmp().setUsePrivacy(Boolean.parseBoolean(devPorperties.get("useSnmpV3Privacy")));
                        if (devPorperties.get("useSnmpV3Privacy") != null && Boolean.parseBoolean(devPorperties.get("useSnmpV3Privacy"))) {
                            if (devPorperties.get("snmpV3PrivacyPassword") != null)
                                deviceProperties.mSnmp().setPrivacyPassword(devPorperties.get("snmpV3PrivacyPassword"));
                        }
                    }
                    break;
            }
        }

        if (devPorperties.get("verifyHttpAccess") != null)
            deviceProperties.mWebAccess().setVerifyHttpAccess(Boolean.parseBoolean(devPorperties.get("verifyHttpAccess")));
        if (devPorperties.get("verifyHttpsAccess") != null)
            deviceProperties.mWebAccess().setVerifyHttpsAccess(Boolean.parseBoolean(devPorperties.get("verifyHttpsAccess")));
        if (devPorperties.get("httpUserName") != null)
            deviceProperties.mWebAccess().setUserName(devPorperties.get("httpUserName"));
        if (devPorperties.get("httpPassword") != null)
            deviceProperties.mWebAccess().setPassword(devPorperties.get("httpPassword"));
        if (devPorperties.get("httpPort") != null)
            deviceProperties.mWebAccess().setHttpPort(Integer.parseInt(devPorperties.get("httpPort")));
        if (devPorperties.get("httpsPort") != null)
            deviceProperties.mWebAccess().setHttpsPort(Integer.parseInt(devPorperties.get("httpsPort")));
        if (devPorperties.get("sshUserName") != null)
            deviceProperties.mSsh().setUserName(devPorperties.get("sshUserName"));
        if (devPorperties.get("sshPassword") != null)
            deviceProperties.mSsh().setPassword(devPorperties.get("sshPassword"));
        if (devPorperties.get("sshPort") != null)
            deviceProperties.mSsh().setSshPort(Integer.parseInt(devPorperties.get("sshPort")));
        if (devPorperties.get("registerVisionServer") != null)
            deviceProperties.mEventNotification().setRegisterVisionServerForDeviceEvents(Boolean.parseBoolean(devPorperties.get("registerVisionServer")));
        if (devPorperties.get("registerVisionServer") != null && Boolean.parseBoolean(devPorperties.get("registerVisionServer"))) {
            if (devPorperties.get("visionServerIP") != null)
                deviceProperties.mEventNotification().setVisionServerIp(devPorperties.get("visionServerIP"));
            if (devPorperties.get("removeTargets") != null)
                deviceProperties.mEventNotification().setRemoveAllOtherTargets(Boolean.parseBoolean(devPorperties.get("removeTargets")));
        }
        if (devPorperties.get("newDeviceName") != null)
            deviceProperties.setElementName(devPorperties.get("newDeviceName"));
        waitForNonSynchronizedState(deviceProperties);
    }

    public static void manageAllVADC(HashMap<String, String> devProperties, List<String> targetNames) {
        openPhysicalContainers();
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        for (String name : targetNames) {
            deviceProperties.selectTreeNode(name);
            deviceProperties.openManageVADCDialog();
            innerManageVADc(devProperties, false);
        }
        //TODO manageAll is currently NOT functional , so workaround is used - change it back when the BUG is fixed
        //multiSelection(targetNames);
        //deviceProperties.openManageVADCDialog();

        //ManageAllVADC manageAllVADC = new ManageAllVADC();
        //manageAllVADC.setLocation(devProperties.get("manageVadcLocation"));
        //innerManageVADc(devProperties, true);
    }

    public static void manageVADC(HashMap<String, String> devPorperties) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        TreeSelection treeSelection = new TreeSelection();

        treeSelection.openPhysicalContainersTree();
        expandAllPhysical();

        deviceProperties.selectTreeNode(devPorperties.get("deviceName"));
        deviceProperties.openManageVADCDialog();
        //ManageVADC manageVADC = new ManageVADC();
        //manageVADC.setLocation(devPorperties.get("manageVadcLocation"));
        innerManageVADc(devPorperties, false);
    }

    private static void innerManageVADc(HashMap<String, String> devProperties, boolean multipleVADC) {
        DeviceProperties deviceProperties = multipleVADC ? new ManageAllVADC() : new ManageVADC();
        switch (com.radware.vision.pojomodel.helpers.constants.ImConstants$SnmpVersionEnumPojo.valueOf(devProperties.get("snmpVersion"))) {
            case SNMP_V1:
                deviceProperties.mSnmp().setSnmpVersion(snmpV1VersionText);
                deviceProperties.mSnmp().setSnmpV1WriteCommunity(devProperties.get("writeCommunityAlteon"));
                deviceProperties.mSnmp().setSnmpV1ReadCommunity(devProperties.get("readCommunity"));
                break;
            case SNMP_V2:
                deviceProperties.mSnmp().setSnmpVersion(snmpV2VersionText);
                deviceProperties.mSnmp().setSnmpV2WriteCommunity(devProperties.get("writeCommunityAlteon"));
                deviceProperties.mSnmp().setSnmpV2ReadCommunity(devProperties.get("readCommunity"));
                break;
            case SNMP_V3:
                deviceProperties.mSnmp().setSnmpVersion(snmpV3VersionText);
                deviceProperties.mSnmp().setSnmpUserName(devProperties.get("snmpV3Username"));
                deviceProperties.mSnmp().setUseAuthentication(Boolean.parseBoolean(devProperties.get("useSnmpV3Authentication")));
                if (Boolean.parseBoolean(devProperties.get("useSnmpV3Authentication"))) {
                    deviceProperties.mSnmp().setAuthenticationProtocol(devProperties.get("snmpV3AuthenticationProtocol"));
                    deviceProperties.mSnmp().setAuthenticationPassword(devProperties.get("snmpV3AuthenticationPassword"));
                    deviceProperties.mSnmp().setUsePrivacy(Boolean.parseBoolean(devProperties.get("useSnmpV3Privacy")));
                    if (Boolean.parseBoolean(devProperties.get("useSnmpV3Privacy"))) {
                        deviceProperties.mSnmp().setPrivacyPassword(devProperties.get("snmpV3PrivacyPassword"));
                    }
                }
                break;
        }
        if (!multipleVADC) {
            String mangedDeviceName = devProperties.get("managedDeviceNames");
            if (mangedDeviceName != null && !mangedDeviceName.isEmpty()) {
                deviceProperties.setElementName(mangedDeviceName);
            }
        }
        deviceProperties.mWebAccess().setVerifyHttpAccess(Boolean.parseBoolean(devProperties.get("verifyHttpAccess")));
        deviceProperties.mWebAccess().setVerifyHttpsAccess(Boolean.parseBoolean(devProperties.get("verifyHttpsAccess")));
        deviceProperties.mWebAccess().setUserName(devProperties.get("httpUserName"));
        deviceProperties.mWebAccess().setPassword(devProperties.get("httpPassword"));
        deviceProperties.mWebAccess().setHttpPort(Integer.parseInt(devProperties.get("httpPort")));
        deviceProperties.mWebAccess().setHttpsPort(Integer.parseInt(devProperties.get("httpsPort")));
        deviceProperties.mSsh().setUserName(devProperties.get("sshUserName"));
        deviceProperties.mSsh().setPassword(devProperties.get("sshPassword"));
        deviceProperties.mSsh().setSshPort(Integer.parseInt(devProperties.get("sshPort")));
        deviceProperties.mEventNotification().setRegisterVisionServerForDeviceEvents(Boolean.parseBoolean(devProperties.get("registerVisionServer")));
        if (Boolean.parseBoolean(devProperties.get("registerVisionServer"))) {
            deviceProperties.mEventNotification().setVisionServerIp(devProperties.get("visionServerIP"));
            deviceProperties.mEventNotification().setRemoveAllOtherTargets(Boolean.parseBoolean(devProperties.get("removeTargets")));
        }
        waitForNonSynchronizedState(deviceProperties);
    }

    public static void editDefencePro(HashMap<String, String> devPorperties) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        openSitesAndClusters();
        deviceProperties.selectTreeNode(devPorperties.get("deviceName"));
        deviceProperties.openEditElementDialog();
        switch (com.radware.vision.pojomodel.helpers.constants.ImConstants$SnmpVersionEnumPojo.valueOf(devPorperties.get("snmpVersion"))) {
            case SNMP_V1:
                deviceProperties.mSnmp().setSnmpVersion(snmpV1VersionText);
                deviceProperties.mSnmp().setSnmpV1WriteCommunity(devPorperties.get("snmpWriteCommunity"));
                deviceProperties.mSnmp().setSnmpV1ReadCommunity(devPorperties.get("snmpReadCommunity"));
                break;
            case SNMP_V2:
                deviceProperties.mSnmp().setSnmpVersion(snmpV2VersionText);
                deviceProperties.mSnmp().setSnmpV2WriteCommunity(devPorperties.get("writeCommunityDefensePro"));
                deviceProperties.mSnmp().setSnmpV2ReadCommunity(devPorperties.get("readCommunity"));
                break;
            case SNMP_V3:
                deviceProperties.mSnmp().setSnmpVersion(snmpV3VersionText);
                deviceProperties.mSnmp().setSnmpUserName(devPorperties.get("snmpV3Username"));
                deviceProperties.mSnmp().setUseAuthentication(Boolean.parseBoolean(devPorperties.get("useSnmpV3Authentication")));
                if (Boolean.parseBoolean(devPorperties.get("useSnmpV3Authentication"))) {
                    deviceProperties.mSnmp().setAuthenticationProtocol(devPorperties.get("snmpV3AuthenticationProtocol"));
                    deviceProperties.mSnmp().setAuthenticationPassword(devPorperties.get("snmpV3AuthenticationPassword"));
                    deviceProperties.mSnmp().setUsePrivacy(Boolean.parseBoolean(devPorperties.get("useSnmpV3Privacy")));
                    if (Boolean.parseBoolean(devPorperties.get("useSnmpV3Privacy"))) {
                        deviceProperties.mSnmp().setPrivacyPassword(devPorperties.get("snmpV3PrivacyPassword"));
                    }
                }
                break;
        }

        deviceProperties.mWebAccess().setVerifyHttpAccess(Boolean.parseBoolean(devPorperties.get("verifyHttpAccess")));
        deviceProperties.mWebAccess().setVerifyHttpsAccess(Boolean.parseBoolean(devPorperties.get("verifyHttpsAccess")));
        deviceProperties.mWebAccess().setUserName(devPorperties.get("httpUserName"));
        deviceProperties.mWebAccess().setPassword(devPorperties.get("httpPassword"));
        deviceProperties.mWebAccess().setHttpPort(Integer.parseInt(devPorperties.get("httpPort")));
        deviceProperties.mWebAccess().setHttpsPort(Integer.parseInt(devPorperties.get("httpsPort")));
        deviceProperties.mEventNotification().setRegisterVisionServerForDeviceEvents(Boolean.parseBoolean(devPorperties.get("registerVisionServer")));
        if (Boolean.parseBoolean(devPorperties.get("registerVisionServer"))) {
            deviceProperties.mEventNotification().setVisionServerIp(devPorperties.get("visionServerIP"));
            deviceProperties.mEventNotification().setRemoveAllOtherTargets(Boolean.parseBoolean(devPorperties.get("removeTargets")));
        }
        waitForNonSynchronizedState(deviceProperties);
    }

    public static void editAlteonVX(HashMap<String, String> devPorperties) {
        DeviceProperties deviceProperties = new LocationDeviceProperties();
        openPhysicalContainers();
        deviceProperties.selectTreeNode(devPorperties.get("deviceName"));
        deviceProperties.openEditElementDialog();
        switch (com.radware.vision.pojomodel.helpers.constants.ImConstants$SnmpVersionEnumPojo.valueOf(devPorperties.get("snmpVersion"))) {
            case SNMP_V1:
                deviceProperties.mSnmp().setSnmpVersion(snmpV1VersionText);
                deviceProperties.mSnmp().setSnmpV1WriteCommunity(devPorperties.get("writeCommunityAlteon"));
                deviceProperties.mSnmp().setSnmpV1ReadCommunity(devPorperties.get("readCommunity"));
                break;
            case SNMP_V2:
                deviceProperties.mSnmp().setSnmpVersion(snmpV2VersionText);
                deviceProperties.mSnmp().setSnmpV2WriteCommunity(devPorperties.get("writeCommunityAlteon"));
                deviceProperties.mSnmp().setSnmpV2ReadCommunity(devPorperties.get("readCommunity"));
                break;
            case SNMP_V3:
                deviceProperties.mSnmp().setSnmpVersion(snmpV3VersionText);
                deviceProperties.mSnmp().setSnmpUserName(devPorperties.get("snmpV3Username"));
                deviceProperties.mSnmp().setUseAuthentication(Boolean.parseBoolean(devPorperties.get("useSnmpV3Authentication")));
                if (Boolean.parseBoolean(devPorperties.get("useSnmpV3Authentication"))) {
                    deviceProperties.mSnmp().setAuthenticationProtocol(devPorperties.get("snmpV3AuthenticationProtocol"));
                    deviceProperties.mSnmp().setAuthenticationPassword(devPorperties.get("snmpV3AuthenticationPassword"));
                    deviceProperties.mSnmp().setUsePrivacy(Boolean.parseBoolean(devPorperties.get("useSnmpV3Privacy")));
                    if (Boolean.parseBoolean(devPorperties.get("useSnmpV3Privacy"))) {
                        deviceProperties.mSnmp().setPrivacyPassword(devPorperties.get("snmpV3PrivacyPassword"));
                    }
                }
                break;
        }

        deviceProperties.mWebAccess().setVerifyHttpAccess(Boolean.parseBoolean(devPorperties.get("verifyHttpAccess")));
        deviceProperties.mWebAccess().setVerifyHttpsAccess(Boolean.parseBoolean(devPorperties.get("verifyHttpsAccess")));
        deviceProperties.mWebAccess().setUserName(devPorperties.get("httpUserName"));
        deviceProperties.mWebAccess().setPassword(devPorperties.get("httpPassword"));
        deviceProperties.mWebAccess().setHttpPort(Integer.parseInt(devPorperties.get("httpPort")));
        deviceProperties.mWebAccess().setHttpsPort(Integer.parseInt(devPorperties.get("httpsPort")));
        deviceProperties.mEventNotification().setRegisterVisionServerForDeviceEvents(Boolean.parseBoolean(devPorperties.get("registerVisionServer")));
        if (Boolean.parseBoolean(devPorperties.get("registerVisionServer"))) {
            deviceProperties.mEventNotification().setVisionServerIp(devPorperties.get("visionServerIP"));
            deviceProperties.mEventNotification().setRemoveAllOtherTargets(Boolean.parseBoolean(devPorperties.get("removeTargets")));
        }
        waitForNonSynchronizedState(deviceProperties);
    }

    public static void clickTreeNode(String node) {
        node = node == null ? "Default" : node;
        deviceName = node;
        WebElement element;
        ComponentLocator locator = new ComponentLocator(How.XPATH, "//div[contains(@id,'" + WebUIStrings.getDeviceTreeNode(node) + "')]");

        element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.defaultVisibilityTimeout, false);
        try {
            element.click();
        } catch (NullPointerException e) {
            ReportsUtils.reportAndTakeScreenShot("Element not found |Element is not Displayed | Element is not Enabled" + locator.getLocatorValue(), Reporter.FAIL);
        }
        //get rid of the device info pane after clicking on it
        MouseUtils.hover(new ComponentLocator(How.ID, WebUIStringsVision.getAlertsMaximizeButton()));
    }

    public static boolean isTreeNodeExist(String node) {
        try {
            ComponentLocator locator = new ComponentLocator(How.XPATH, "//div[contains(@id,'" + WebUIStrings.getDeviceTreeNode(node) + "')]");
            final WebElement webElement = WebUIUtils.fluentWait(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            return webElement != null;
        } catch (Exception e) {
            return false;
        }
    }

    public static void findTreeElement(String elementName) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        deviceProperties.selectTreeNode(elementName);
    }

    public static void openTreeSelectionMenu() {
        TreeSelection treeSelection = new TreeSelection();
        treeSelection.openTreeSelectionMenu();
    }

    public static void openPhysicalContainers() {
        TreeSelection treeSelection = new TreeSelection();
        treeSelection.openPhysicalContainersTree();
        expandAllPhysical();
    }

    public static void openSitesAndClusters() {
        TreeSelection treeSelection = new TreeSelection();
        treeSelection.openSitesAndClustersTree();
        expandAllSitesClusters();
    }

    public static void openGroups() {
        TreeSelection treeSelection = new TreeSelection();
        treeSelection.openGroupsTree();
    }

    public static void openDeviceInfoPane() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getViewDevice());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (deviceName != null && !deviceName.isEmpty())
            if (!new VisionServerInfoPane().getDeviceNameWithOutType().equals(deviceName)) {
                ReportsUtils.reportAndTakeScreenShot("Open Device Info Pane Failed", Reporter.FAIL);
            }
    }

    public static void openDeviceSitesClusters(String deviceName) {
        expandAllSitesClusters();
        clickTreeNode(deviceName);
        openDeviceInfoPane();
    }

    public static void openTab(TopologyTreeTabs topologyTreeTabs) {

        switch (topologyTreeTabs) {

            case SitesAndClusters:
                openSitesAndClusters();
                break;
            case PhysicalContainers:
                openPhysicalContainers();
                break;
            case LOGICAL_GROUPS:
                openGroups();
                break;
        }
    }


    public static void expandTree(TopologyTreeTabs topologyTreeTabs) {

        switch (topologyTreeTabs) {

            case SitesAndClusters:
                expandAllSitesClusters();
                break;
            case PhysicalContainers:
                expandAllPhysical();
                break;
            case LOGICAL_GROUPS:
                expandAllLogicalGroups();
                break;
        }

    }


    public static boolean waitForDeviceToShowUp(TopologyTreeTabs deviceType, String deviceName, long secondsToWait) {

        openTab(deviceType);
        long startTime = System.currentTimeMillis();
        long milliSecondsToWait = secondsToWait * 1000;
        while (System.currentTimeMillis() - startTime < milliSecondsToWait) {
            expandTree(deviceType);
            if (ClickOperationsHandler.checkIfElementExistAndDisplayed(GeneralUtils.buildGenericXpath(WebElementType.Id, WebUIStrings.getDeviceTreeNode(deviceName), OperatorsEnum.EQUALS)))
                return true;
            BasicOperationsHandler.delay(5);

        }
        ReportsUtils.reportAndTakeScreenShot("Device Did Not Show Up", Reporter.FAIL);
        return false;
    }

    public static void expandAllPhysical() {
        ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-PhysicalCOntainersTree_ExpandAll");
        innerExpandAll(locator);
    }

    public static void expandAllSitesClusters() {
        ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-SitesAndClustersTree_ExpandAll");
        innerExpandAll(locator);
    }

    public static void expandAllLogicalGroups() {
        ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-LogicalGroupsTree_ExpandAll");
        innerExpandAll(locator);
    }

    //gwt-debug-LogicalGroupsTree_ExpandAll

    private static void innerExpandAll(ComponentLocator locator) {
        try {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
            WebUIUtils.fluentWaitJSExecutor("arguments[0].click();", WebUIUtils.SHORT_WAIT_TIME, false, locator);
        } finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
        }
    }

    private static void waitForTreeRoot(ComponentLocator locator) {
        WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
    }

    public static void multiSelection(List<String> treeNodes) throws Exception {
        List<String> treeNodesList = new ArrayList<String>();
        for (String currentTreeNode : treeNodes) {
            treeNodesList.add(WebUIStrings.getDeviceTreeNode(currentTreeNode));
        }
        WebUIUtils.clickMultiSelect(treeNodesList);
    }

    public static String getDeviceStatusSites(String deviceName) {
        openSitesAndClusters();
        expandAllSitesClusters();
        clickTreeNode(deviceName);
        openDeviceInfoPane();
        BasicOperationsHandler.delay(4);
        VisionServerInfoPane infopane = new VisionServerInfoPane();
        return infopane.getDeviceStatus();
    }

    public static void waitForDeviceStatus(TopologyTreeTabs treeNode, String deviceName, DeviceStatusEnum expectedDeviceStatus, int timeout) {

        boolean isPhysical = treeNode.equals(PhysicalContainers) ? true : false;
        String deviceStatus;
        long currentTime = System.currentTimeMillis();
        while (System.currentTimeMillis() - currentTime < timeout * 1000) {

            if (isPhysical) {

                deviceStatus = TopologyTreeHandler.getDeviceStatusPhysical(deviceName);
            } else {
                deviceStatus = TopologyTreeHandler.getDeviceStatusSites(deviceName);
            }
            if (expectedDeviceStatus.equals(DeviceStatusEnum.UP_OR_MAINTENANCE)) {
                if ((deviceStatus.equals(DeviceStatusEnum.UP.getStatus())) || (deviceStatus.equals(DeviceStatusEnum.MAINTENANCE.getStatus()))) {
                    return;
                }
            } else if (deviceStatus.equals(expectedDeviceStatus.getStatus())) {
                return;
            }

            BaseTestUtils.report("Device Status Is Equal To : " + deviceStatus, Reporter.FAIL);
        }
    }

    public static String getDeviceStatusPhysical(String deviceName) {
        openPhysicalContainers();
        clickTreeNode(deviceName);
        openDeviceInfoPane();
        VisionServerInfoPane infopane = new VisionServerInfoPane();
        return infopane.getDeviceStatus();
    }

    public static List<WebElement> getNodes() {
        WebUIWidget content = getTabLayoutPanelContent();
        String trXpath = "./table/tbody/tr";
        int trCount = content.getWebElement().findElements(By.xpath(trXpath)).size();
        String nodeXpath = "./table/tbody/tr[" + trCount + "]//div[starts-with(@id,'" + WebUIStrings.getDeviceTreeNodeString() + "')]";
        List<WebElement> nodeList = content.getWebElement().findElements(By.xpath(nodeXpath));
        return nodeList;
    }

    private static WebUIWidget getTabLayoutPanelContent() {
        ComponentLocator locator = new ComponentLocator(How.CLASS_NAME, "gwt-TabLayoutPanelContent");
        WebUIWidget deviceAreaPanel = new WebUIWidget(new WebUIComponent(locator));
        return deviceAreaPanel;
    }

    public static void waitForNonSynchronizedState(DeviceProperties deviceProperties) {
        for (int i = 0; i < 10; i++) {
            deviceProperties.submit();
            deviceProperties.waitForDialogClose(2 * 1000);
            List<PopupContent> popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();
            if (popupErrors != null && popupErrors.size() > 0) {
                for (PopupContent errors : popupErrors) {
                    if (errors.getContent().contains("is in synchronized state")) {
                        BasicOperationsHandler.delay(5);
                    }
                }
                break;
            } else {
                break;
            }
        }
    }


    public static void clickRandomDevice() {

        openSitesAndClusters();
        expandAllSitesClusters();
        if (WebUIUtils.fluentWaitGetText(By.id(WebUIStrings.getDefaultDeviceTreeNodeString()), WebUIUtils.SHORT_WAIT_TIME, false).contains("0/0")) {
            BaseTestUtils.report("Could not click random device from tree, there is no device managed by vision in sites and devices", Reporter.FAIL);
            return;
        }
        String xpathDevicePrefix = GeneralUtils.buildGenericXpath(WebElementType.Id, WebUIStrings.getDeviceTreeNodeString(), OperatorsEnum.CONTAINS);
        List<WebElement> devices = WebUIUtils.fluentWaitMultiple(By.xpath(xpathDevicePrefix));
        for (WebElement device : devices) {

            if (!ClickOperationsHandler.checkIfElementAttributeContains(device, "id", "Default")) {
                ClickOperationsHandler.clickWebElement(device);
                if (!device.getAttribute("class").equals("siteIcon"))
                    openDeviceInfoPane();
                return;
            }

        }

    }

    /**
     * searches for device by type under "sites and devices" node and clicks on it
     *
     * @param deviceType - DeviceType4Group ENUM
     * @return in case the device found clicks on it and returns true, else return false
     */
    public static boolean clickTreeNode(DeviceType4Group deviceType) {

        openSitesAndClusters();
        expandAllSitesClusters();

        //if there is no devices managed , no need to continue
        if (WebUIUtils.fluentWaitGetText(By.id(WebUIStrings.getDefaultDeviceTreeNodeString()), WebUIUtils.SHORT_WAIT_TIME, false).contains("0/0")) {
            return false;
        }

        String xpathDevicePrefix = GeneralUtils.buildGenericXpath(WebElementType.Id, WebUIStrings.getDeviceTreeNodeString(), OperatorsEnum.CONTAINS);
        List<WebElement> devices = WebUIUtils.fluentWaitMultiple(By.xpath(xpathDevicePrefix));

        WebElement currentSiteInTree;
        int i = 0;
        while (i < devices.size()) {
            currentSiteInTree = devices.get(i);
            try {
                if (!ClickOperationsHandler.checkIfElementAttributeContains(currentSiteInTree, "id", "Default")) {
                    setDeviceName(currentSiteInTree.getText());
                    ClickOperationsHandler.clickWebElement(currentSiteInTree);

                    if (deviceType.equals(DeviceType4Group.NOT_DEFAULT)) return true;

                    if (new VisionServerInfoPane().getDeviceTypeFromName().equalsIgnoreCase(deviceType.getDeviceType())) {
                        return true;
                    }
                }
                i++;
            } catch (StaleElementReferenceException | NoSuchElementException e) {
                devices = WebUIUtils.fluentWaitMultiple(By.xpath(xpathDevicePrefix));
            }
        }
        return false;
    }

    public static void setDeviceName(String deviceName) {
        TopologyTreeHandler.deviceName = deviceName;
    }

    public static DeviceInfo setDeviceInfo(SUTDeviceType sutDeviceType, String name, String ip, Map<String, String> optionalValues) {
        DeviceInfo deviceInfo = new DeviceInfo();
        deviceInfo.setDeviceName(name);
        deviceInfo.setDeviceIp(ip);

        deviceInfo.setUsername(optionalValues.get("User Name"));
        deviceInfo.setPassword(optionalValues.get("Password"));
        deviceInfo.setReadCommunity(optionalValues.getOrDefault("SNMP Read Community", "public"));
        deviceInfo.setWriteCommunity(optionalValues.getOrDefault("SNMP Write Community", sutDeviceType == SUTDeviceType.DefensePro ? "public" : "private"));

        return deviceInfo;
    }

    public static void navigateToIFrame(String by, String byLabel, String deviceName, TopologyTreeTabs topologyTreeTab) {
        selectDevice(deviceName, topologyTreeTab);
        By byInstance = by.equals("Id") ? By.id(byLabel) : By.className(byLabel);
        new WebDriverWait(WebUIDriver.getDriver(), 30)
                .until(ExpectedConditions.frameToBeAvailableAndSwitchToIt(byInstance));
    }

    public static void navigateBackFromIFrame() {
        WebUIDriver.getDriver().switchTo().defaultContent();
    }
}
