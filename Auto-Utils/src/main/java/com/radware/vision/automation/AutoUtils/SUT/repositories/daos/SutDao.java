package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.*;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;

import static java.lang.String.format;
import static java.util.Objects.isNull;

public class SutDao {

    private static final String SUT_VM_OPTION_KEY_PROPERTY = "SUT.vmOptions.key";
    private static final String SUT_FILES_PATH_PROPERTY = "SUT.path";

    private static SutDao _instance = new SutDao();
    public static SutDao _pairInstance;

    private ApplicationPropertiesUtils applicationPropertiesUtils;
    private SystemProperties systemProperties;

    private SUTPojo sutPojo;


    public SutDao() {
        this.applicationPropertiesUtils = new ApplicationPropertiesUtils();
        this.systemProperties = SystemProperties.get_instance();

        String sutFilePath = systemProperties.getResourcesPath(
                String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_FILES_PATH_PROPERTY), getSUTFileName()));
        this.sutPojo = JsonUtilities.loadJsonFile(sutFilePath, SUTPojo.class);

        if (_pairInstance == null && this.sutPojo.getPairSUT() != null)
            _pairInstance = new SutDao(this.sutPojo.getPairSUT());
    }

    public SutDao(String sutFileName)
    {
        this.applicationPropertiesUtils = new ApplicationPropertiesUtils();
        this.systemProperties = SystemProperties.get_instance();

        String sutFilePath = systemProperties.getResourcesPath(
                String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_FILES_PATH_PROPERTY), sutFileName));
        this.sutPojo = JsonUtilities.loadJsonFile(sutFilePath, SUTPojo.class);
    }

    public static SutDao get_instance() {
        return _instance;
    }

    public static SutDao get_pairInstance()
    {
        return _pairInstance;
    }

    private String getSUTFileName() {

        try {
            String sutVmOptionsKey = this.applicationPropertiesUtils.getProperty(SUT_VM_OPTION_KEY_PROPERTY);
            if (isNull(sutVmOptionsKey) || sutVmOptionsKey.isEmpty()) {
                throw new NoSuchFieldException(format("The Property %s not found at %s file", SUT_VM_OPTION_KEY_PROPERTY, ApplicationPropertiesUtils.applicationPropertiesFile));
            }

            String sutFileName = this.systemProperties.getSUTFileName(sutVmOptionsKey);

            if (isNull(sutFileName) || sutFileName.isEmpty()) {
                throw new IllegalArgumentException(format("The sut file name is null or empty , validate that the vm option contains \"%s={filename}\" ", sutVmOptionsKey));
            }
            return sutFileName;

        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }

        return null;

    }

    //    DAO

    public String getLinuxServerID(){return this.sutPojo.getGenericLinuxID();}

    public String getSetupFileName() {
        return this.sutPojo.getSetupFile();
    }

    public String getServerName() {
        return this.sutPojo.getServerName();
    }

//    public String getSimulators() {
//        return this.sutPojo.getSimulatorSet();
//    }
//
//    public boolean isLoadSimulators() {
//        return this.sutPojo.isLoadSimulators();
//    }

    public ClientConfiguration findClientConfiguration() {
        return this.sutPojo.getClientConfiguration();
    }

    public DeployConfigurations findDeployConfigurations() {
        return this.sutPojo.getDeployConfigurations();
    }

    public CliConfiguration findCliConfiguration() {
        return this.sutPojo.getCliConfiguration();
    }

    public CliConfiguration findPairCliConfiguration() {
        return this.sutPojo.getCliConfiguration();
    }

//    public String getDefenseFlowID() {
//        return this.set.getDefenseFlow();
//    }

    public Pair getPair() {
        return this.sutPojo.getPair();
    }
}
