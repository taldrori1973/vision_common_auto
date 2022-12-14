package com.radware.vision.automation.systemManagement.licenseManagement;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RestClientsFactory;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.databases.mariaDB.client.JDBCConnectionException;
import com.radware.vision.automation.databases.mariaDB.repositories.vision_ng_schema.daos.VisionLicenseDao;
import com.radware.vision.automation.databases.mariaDB.repositories.vision_ng_schema.entities.VisionLicense;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.utils.UriUtils;
import models.RestResponse;
import models.StatusCode;
import restInterface.client.SessionBasedRestClient;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.radware.vision.utils.SutUtils.*;

public class LicenseManagement {

    private static String VISION_TIME_BASED_LICENSE_PATTERN = "(vision)-" +
            "(.*)-" +
            "(\\d{2}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\d{4})-" +
            "(\\d{2}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\d{4})-" +
            "(.*)";//matches only time based licenses : <product name>-<license name>-<from date>-<to date>-<code>
    private static String DF_CYBER_CONTROL_TIME_BASED_LICENSE_PATTERN = "(df)-(cyber)-(control)-(.*)-(.*)" +
            "(\\d{2}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\d{4})-" +
            "(\\d{2}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\d{4})-" +
            "(.*)";//matches only time based licenses : <product name>-<license name>-<from date>-<to date>-<code>

    private static String VISION_GLOBAL_LICENSE_PATTERN = "(vision)-(.*)-(.*)";//matches any thing like : <product name>-<license name>-<code>

    private static String VISION_LICENSE_PREFIX_PATTERN = "(vision)-(.*)";
    private static String DF_CYBER_CONTROL_LICENSE_PREFIX_PATTERN = "(df)-(cyber)-(control)-(.*)-(.*)";

    private String productName;
    private String licenseName;
    private String fromDate;
    private String toDate;
    private String featureName;
    private boolean timeBasedLicense;


    private Pattern visionTimeBasedLicensePattern;
    private Pattern visionGlobalLicensePattern;
    private Pattern visionLicensePrefixPattern;
    private Pattern dfCyberControlLicensePrefixPattern;
    private Pattern dfCyberControlTimeBasedLicensePattern;

    //this list contains all the licenses which installed in the database
    private List<VisionLicense> installedLicenses;
    private VisionLicenseDao visionLicenseDao;

    private LicenseManagement() throws JDBCConnectionException {
        this.visionGlobalLicensePattern = Pattern.compile(VISION_GLOBAL_LICENSE_PATTERN);
        this.visionTimeBasedLicensePattern = Pattern.compile(VISION_TIME_BASED_LICENSE_PATTERN);
        this.visionLicensePrefixPattern = Pattern.compile(VISION_LICENSE_PREFIX_PATTERN);
        this.dfCyberControlLicensePrefixPattern = Pattern.compile(DF_CYBER_CONTROL_LICENSE_PREFIX_PATTERN);
        this.dfCyberControlTimeBasedLicensePattern = Pattern.compile(DF_CYBER_CONTROL_TIME_BASED_LICENSE_PATTERN);

        this.visionLicenseDao = new VisionLicenseDao();
        this.installedLicenses = this.visionLicenseDao.getAll();
    }

    /**
     * This constructor build an object from full License String as follow:
     *
     * @param fullLicenseString Result:
     *                          time based license : vision-AVA-6-Gbps-attack-capacity-03sep2019-29oct2020-wH8KbYLL
     *                          productName=vision
     *                          licenseName=AVA-6-Gbps-attack-capacity
     *                          fromDate=03sep2019
     *                          toDate=29oct2020
     *                          timeBasedLicense=true
     *                          not time based license :vision-AVA-400-Gbps-attack-capacity-KsZdkhlb
     *                          productName=vision
     *                          licenseName=AVA-400-Gbps-attack-capacity
     *                          fromDate=null
     *                          toDate=null
     *                          timeBasedLicense=false
     */
    public LicenseManagement(String fullLicenseString) throws JDBCConnectionException {
        this();
        Matcher visionTimeBasedLicenseMatcher = visionTimeBasedLicensePattern.matcher(fullLicenseString);
        Matcher visionGlobalLicenseMatcher = visionGlobalLicensePattern.matcher(fullLicenseString);
        Matcher dfCyberControlLicensePrefixMatcher = dfCyberControlLicensePrefixPattern.matcher(fullLicenseString);


//        the time based should be first because the second pattern is matches both global and based time licenses
        if (visionTimeBasedLicenseMatcher.matches()) {

            this.productName = visionTimeBasedLicenseMatcher.group(1);
            this.licenseName = visionTimeBasedLicenseMatcher.group(2);
            this.fromDate = visionTimeBasedLicenseMatcher.group(3);
            this.toDate = visionTimeBasedLicenseMatcher.group(5);
            this.featureName = VisionLicenses.getFeatureName(productName + "-" + licenseName);
            this.timeBasedLicense = true;


        }
        else if (dfCyberControlLicensePrefixMatcher.matches()) {

            this.productName = dfCyberControlLicensePrefixMatcher.group(1);
            this.licenseName = dfCyberControlLicensePrefixMatcher.group(2);
            this.fromDate = null;
            this.toDate = null;
            this.featureName = VisionLicenses.getFeatureName(productName + "-" + licenseName);
            this.timeBasedLicense = false;

        }else if (visionGlobalLicenseMatcher.matches()) {

            this.productName = visionGlobalLicenseMatcher.group(1);
            this.licenseName = visionGlobalLicenseMatcher.group(2);
            this.fromDate = null;
            this.toDate = null;
            this.featureName = VisionLicenses.getFeatureName(productName + "-" + licenseName);
            this.timeBasedLicense = false;

        } else {
            throw new IllegalArgumentException(String.format("the %s argument is NOT matches the Global Pattern nor the Time Based Pattern", fullLicenseString));
        }

    }

    /**
     * This Constructor is for license prefix for example: vision-AVA-60-Gbps-attack-capacity
     *
     * @param licensePrefix is the product name + license name without dates and hashcode
     * @param fromDate      for time based license , or null if the license is not time based
     * @param toDate        for time based license , or null if the license is not time based
     *                      examples:
     *                      <p>
     *                      licensePrefix=vision-AVA-60-Gbps-attack-capacity , fromDate="10-10-2019" , to Date="1-12-2019"
     *                      Result:
     *                      productName=vision
     *                      licenseName=AVA-60-Gbps-attack-capacity
     *                      fromDate=10Oct2019
     *                      toDate=01Dec2019
     *                      timeBasedLicense=true
     *                      <p>
     *                      <p>
     *                      licensePrefix=vision-AVA-60-Gbps-attack-capacity , fromDate=null , to Date=null
     *                      Result:
     *                      productName=vision
     *                      licenseName=AVA-60-Gbps-attack-capacity
     *                      fromDate=null
     *                      toDate=null
     *                      timeBasedLicense=false
     */
    public LicenseManagement(String licensePrefix, LocalDate fromDate, LocalDate toDate) throws JDBCConnectionException {
        this();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("ddMMMyyyy");

        Matcher visionLicensePrefixMatcher = visionLicensePrefixPattern.matcher(licensePrefix);
        Matcher dfCyberControlLicensePrefixMatcher = dfCyberControlLicensePrefixPattern.matcher(licensePrefix);

        if (dfCyberControlLicensePrefixMatcher.matches()) {

            this.productName = dfCyberControlLicensePrefixMatcher.group(1) +"-" + dfCyberControlLicensePrefixMatcher.group(2)+"-" +  dfCyberControlLicensePrefixMatcher.group(3);
            this.licenseName = dfCyberControlLicensePrefixMatcher.group(4)+"-" +  dfCyberControlLicensePrefixMatcher.group(5);
            this.fromDate = fromDate == null ? null : fromDate.format(dtf);
            this.toDate = toDate == null ? null : toDate.format(dtf);
            if (fromDate != null ^ toDate != null) {
                throw new IllegalArgumentException(String.format("one of the dates is null when the other is not null , should be both null or not null"));
            }
            this.featureName = VisionLicenses.getFeatureName(productName + "-" + licenseName);

            this.timeBasedLicense = fromDate != null;


        }
        else{
            if (visionLicensePrefixMatcher.matches()) {
            this.productName = visionLicensePrefixMatcher.group(1);
            this.licenseName = visionLicensePrefixMatcher.group(2);
            this.fromDate = fromDate == null ? null : fromDate.format(dtf);
            this.toDate = toDate == null ? null : toDate.format(dtf);
            if (fromDate != null ^ toDate != null) {
                throw new IllegalArgumentException(String.format("one of the dates is null when the other is not null , should be both null or not null"));
            }
            this.featureName = VisionLicenses.getFeatureName(productName + "-" + licenseName);
            this.timeBasedLicense = fromDate != null;
        }
        else{
                throw new IllegalArgumentException(String.format("the %s argument is NOT matches \"<product name>-<feature name>\" Pattern", licensePrefix));
            }
        }

    }

    public boolean install() throws Exception {
        String timeBasedLicensePrefix = String.format("%s-%s-%s-%s-", this.productName, this.licenseName, this.fromDate, this.toDate);
        String shortLicensePrefix = String.format("%s-%s-", this.productName, this.licenseName);

        if (this.featureName.equals(VisionLicenses.ATTACK_CAPACITY.getLicenseFeatureName()) || this.featureName.equals(VisionLicenses.MAX_ATTACK_CAPACITY.getLicenseFeatureName())) {
            return handleRelatedLicenseInstallation(Arrays.asList(VisionLicenses.ATTACK_CAPACITY, VisionLicenses.MAX_ATTACK_CAPACITY));


        } else if (this.featureName.equals(VisionLicenses.RTU.getLicenseFeatureName()) ||
                this.featureName.equals(VisionLicenses.RTUVA.getLicenseFeatureName()) ||
                this.featureName.equals(VisionLicenses.RTUMAX.getLicenseFeatureName())) {
            return handleRelatedLicenseInstallation(Arrays.asList(VisionLicenses.RTU, VisionLicenses.RTUVA, VisionLicenses.RTUMAX));


        } else {//this is not special license
            if (this.isTimeBasedLicense()) {
                if (this.installedLicenses.stream().anyMatch(license -> license.getLicense_str().startsWith(timeBasedLicensePrefix)))
                    return true;

                if (this.installedLicenses.stream().anyMatch(license -> license.getLicense_str().startsWith(shortLicensePrefix))) {//so the same license with different dates already installed
                    deleteLicenses(this.installedLicenses.stream().filter(license -> license.getLicense_str().startsWith(shortLicensePrefix)).collect(Collectors.toList()));
                    return restInstall();
                }
                //license is not exist
                return restInstall();
            } else {//not time based license will be with the following pattern <product>-<license name>-<code> : vision-AVA-AppWall-123456
                if (this.installedLicenses.stream().anyMatch(license -> license.getLicense_str().startsWith(shortLicensePrefix))) { //so the same license already installed
                    //should check if found license is time based
                    List<VisionLicense> licenses = this.installedLicenses.stream().filter(license -> license.getLicense_str().startsWith(shortLicensePrefix) &&
                            visionTimeBasedLicensePattern.matcher(license.getLicense_str()).reset().matches()).collect(Collectors.toList());
                    if (licenses.isEmpty()) return true;
                    deleteLicenses(licenses);
                    return restInstall();

                }
                return restInstall();
            }
        }
    }

    public boolean delete() throws Exception {
        String timeBasedLicensePrefix = String.format("%s-%s-%s-%s", this.productName, this.licenseName, this.fromDate, this.toDate);
        String shortLicensePrefix = String.format("%s-%s", this.productName, this.licenseName);
        Optional<VisionLicense> licenseToDelete;
        if (this.timeBasedLicense)
            licenseToDelete = installedLicenses.stream().filter(license -> license.getLicense_str().startsWith(timeBasedLicensePrefix)).findAny();
        else
            licenseToDelete = installedLicenses.stream().filter(license -> license.getLicense_str().startsWith(shortLicensePrefix)).findAny();

        if (licenseToDelete.isPresent())
            return restDelete(licenseToDelete.get());
        return true;
    }

    private boolean handleRelatedLicenseInstallation(List<VisionLicenses> relatedLicenses) throws Exception {
//        first check if the same license is already installed
        String timeBasedLicensePrefix = String.format("%s-%s-%s-%s-", this.productName, this.licenseName, this.fromDate, this.toDate);
        String shortLicensePrefix = String.format("%s-%s-", this.productName, this.licenseName);
        if (this.isTimeBasedLicense()) {
            if (this.installedLicenses.stream().anyMatch(license -> license.getLicense_str().startsWith(timeBasedLicensePrefix)))
                return true;
        } else {
            if (this.installedLicenses.stream().anyMatch(license -> license.getLicense_str().startsWith(shortLicensePrefix))) {//so the same license with different dates already installed
                //should check if found license is time based
                List<VisionLicense> licenses = this.installedLicenses.stream().filter(license -> license.getLicense_str().startsWith(shortLicensePrefix) &&
                        visionTimeBasedLicensePattern.matcher(license.getLicense_str()).matches()).collect(Collectors.toList());
                if (licenses.isEmpty()) return true;
                deleteLicenses(licenses);
                return restInstall();
            }
        }
        List<String> relatedLicensesFeatureNames = new ArrayList<>();
        relatedLicenses.forEach(license -> relatedLicensesFeatureNames.add(license.getLicenseFeatureName()));

//        maybe another license with the same feature already exist , for example we need to install RTU10VA when RTUMAX already installed
        deleteLicenses(this.installedLicenses.stream().filter(license -> relatedLicensesFeatureNames.contains(license.getFeature_name())).collect(Collectors.toList()));
        return restInstall();
    }

    private boolean restInstall() throws Exception {
        ClientConfigurationDto clientConfigurations = SUTManagerImpl.getInstance().getClientConfigurations();
        int numberOfInstalledLicensesBeforeDelete = installedLicenses.size();
        String timeBasedLicensePrefix = String.format("%s-%s-%s-%s", this.productName, this.licenseName, this.fromDate, this.toDate);
        String shortLicensePrefix = String.format("%s-%s", this.productName, this.licenseName);
        String licenseKey = null;
        try {
            if (timeBasedLicense)
                licenseKey = LicenseGenerator.generateLicense(timeBasedLicensePrefix);
            else
                licenseKey = LicenseGenerator.generateLicense(shortLicensePrefix);
        } catch (Exception e) {
            BaseTestUtils.report(String.format("License Key Generation Failed , Error Message: %s", e.getMessage()), Reporter.FAIL);
        }
        GenericVisionRestAPI request;
        if (this.featureName.equals(VisionLicenses.ACTIVATION.getLicenseFeatureName())) {
            SessionBasedRestClient connection = RestClientsFactory.getVisionConnection(UriUtils.buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), getCurrentVisionIp()),
                    getCurrentVisionRestPort(), getCurrentVisionRestUserName(), getCurrentVisionRestUserPassword(), licenseKey);
            RestResponse loginResult = connection.login();
            if (!loginResult.getStatusCode().equals(StatusCode.OK)) {
                throw new Exception(String.format("Vision Activation License Install Fails because of the following error: %s", loginResult.getBody().getBodyAsString()));
            }
        } else {
            request = new GenericVisionRestAPI("Vision/SystemManagement.json", "Install License");

            Map<String, Object> body = new HashMap<>();
            body.put("licenseStr", licenseKey);
            body.put("requireDeviceLock", true);
            body.put("parameters", Collections.EMPTY_LIST);
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.valueToTree(body);

            request.getRestRequestSpecification().setBody(jsonNode.toString());
            RestResponse restResponse = request.sendRequest();
            if (!restResponse.getStatusCode().equals(StatusCode.OK)) {
                throw new Exception(String.format("Vision \"%s\" License Installation Fails because of the following error: %s", licenseKey, restResponse.getBody().getBodyAsString()));
            }
        }

        this.installedLicenses = this.visionLicenseDao.getAll();
        if (numberOfInstalledLicensesBeforeDelete == this.installedLicenses.size())
            BaseTestUtils.report("The number of installed licenses before install and after install are the same.", Reporter.FAIL);

        return true;

    }


    private boolean restDelete(VisionLicense license) throws Exception {
        int numberOfInstalledLicensesBeforeDelete = installedLicenses.size();

        GenericVisionRestAPI request = new GenericVisionRestAPI("Vision/SystemManagement.json", "Delete License");

        Map<String, String> pathParams = new HashMap<>();
        pathParams.put("ormID", license.getRow_id());

        request.getRestRequestSpecification().setPathParams(pathParams);
        RestResponse restResponse = request.sendRequest();

        if (!restResponse.getStatusCode().equals(StatusCode.OK))
            throw new Exception(String.format("Delete Vision \"%s\" License Fails because of the following error: %s", license.getName(), restResponse.getBody().getBodyAsString()));

        this.installedLicenses = this.visionLicenseDao.getAll();
        if (numberOfInstalledLicensesBeforeDelete == this.installedLicenses.size())
            BaseTestUtils.report("The number of installed licenses before delete and after delete are the same.", Reporter.FAIL);

        return true;

    }

    private void deleteLicenses(List<VisionLicense> toDeleteLicenses) throws Exception {
        VisionLicenseDao visionLicenseDao = new VisionLicenseDao();
        for (VisionLicense toDeleteLicens : toDeleteLicenses) {
            restDelete(toDeleteLicens);
        }
    }

    private boolean isTimeBasedLicense() {
        return timeBasedLicense;
    }

}


