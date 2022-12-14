package com.radware.vision.bddtests.clioperation.system.upgrade;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.Deploy.UvisionServer;
import com.radware.vision.automation.Deploy.VisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.clioperation.GeneralSteps;
import com.radware.vision.bddtests.vmoperations.Deploy.Upgrade;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.vision.automation.Deploy.VisionServer.waitForVisionServerServicesToStartHA;


public class UpgradeSteps extends TestBase {


    @When("^validate vision server services are UP With DF services are Enable$")
    public void validateVisionServerServicesUPWithDFStep() {
        try {
            UvisionServer.waitForUvisionServerServicesStatus(serversManagement.getRadwareServerCli().get(),
                    UvisionServer.UVISON_DEFAULT_SERVICES, 30 * 60);
            UvisionServer.waitForUvisionServerServicesStatus(serversManagement.getRadwareServerCli().get(),
                    UvisionServer.UVISON_DEFAULT_SERVICES_DF, 30 * 60);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
    @When("^validate vision server services are UP With DF services are Disable$")
    public void validateVisionServerServicesUP() {
        try {
            UvisionServer.waitForUvisionServerServicesStatus(serversManagement.getRadwareServerCli().get(),
                    UvisionServer.UVISON_DEFAULT_SERVICES, 30 * 60);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL) ;
        }
    }

    @When("^validate vision server services are UP on vision 2$")
    public void validateVisionServerServicesUPStepVision2() {
        try {
            String sourceIP = sutManager.getpair().getPairIp();
            RadwareServerCli radwareServerCli = new RadwareServerCli(sourceIP,
                    serversManagement.getRadwareServerCli().get().getUser(),
                    serversManagement.getRadwareServerCli().get().getPassword());
            radwareServerCli.connect();
            UvisionServer.waitForUvisionServerServicesStatus(radwareServerCli, UvisionServer.UVISON_DEFAULT_SERVICES_DF, 30 * 60);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @When("^Upgrade in Parallel,backup&Restore setup$")        /// backup and restore setup
    public static void UpgradeVisionToLatestBuildTwoMachines() {
        try {
            String sourceIP = getSutManager().getClientConfigurations().getHostIp();
            String targetIP = getSutManager().getPairConfigurations().getHostIp();
            String build = System.getenv("BUILD");//get build from portal
            if (build == null || build.equals("") || build.equals("0")) build = "";//Latest Build

            RadwareServerCli radwareSource = getServersManagement().getRadwareServerCli().get();
            RootServerCli rootSource = getServersManagement().getRootServerCLI().get();

            RadwareServerCli radwareTarget = new RadwareServerCli(targetIP, getSutManager().getPairCliConfigurations().getRadwareServerCliUserName(), getSutManager().getPairCliConfigurations().getRadwareServerCliPassword());
            RootServerCli rootTarget = new RootServerCli(targetIP, getSutManager().getPairCliConfigurations().getRootServerCliUserName(), getSutManager().getPairCliConfigurations().getRootServerCliPassword());

            Upgrade upgradeSource = new Upgrade(radwareSource, rootSource);
            Upgrade upgradeTarget = new Upgrade(radwareTarget, rootTarget);
            UpgradeThread sourceMachineThread = new UpgradeThread(sourceIP, radwareSource, rootSource, build);
            UpgradeThread targetMachineThread = new UpgradeThread(targetIP, radwareTarget, rootTarget, build);

            if (upgradeSource.isSetupNeeded) {
                sourceMachineThread.start();
            }
            if (upgradeTarget.isSetupNeeded) {
                targetMachineThread.start();
            }
            while (true) {
                if (!sourceMachineThread.isAlive() && !targetMachineThread.isAlive())
                    break;
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @When("^CLI validate Vision Services UP$")
    public void CliValidateVisionServerServicesUP() {
        try {
            validateVisionServerServicesUP(serversManagement.getRadwareServerCli().get());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

//    public static boolean isAPM() {
//        ServerCliBase rootServerCli = serversManagement.getRootServerCLI().get();
//        try {
//            rootServerCli.connect();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        CliOperations.runCommand(rootServerCli, "df -h | grep apm | grep /vz/private | wc -l", 5 * 60 * 1000);
//        return !CliOperations.lastRow.equals("0");
//    }

    public static void validateVisionServerServicesUP(RadwareServerCli serverCli) throws Exception {
        try {
            serverCli.disconnect();
            serverCli.connect();
            boolean isVisionUp = waitForVisionServerServicesToStartHA(serverCli, 40 * 60 * 1000);
            if (!isVisionUp)
                BaseTestUtils.report("Not all services are up till timeout.", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
            if (!rootServerCli.isServerConnected()) rootServerCli.connect();
        }
    }

    /**
     * try to upgrade to a non-supported version
     */
    @Then("^Upgrade to non-supported version$")
    public void upgradeToAnOldVersion() {
        try {
            String version = VMOperationsSteps.readVisionVersionFromPomFile();
            String build = System.getenv("BUILD");//get build from portal
            if (build == null || build.equals("") || build.equals("0")) build = "";//Latest Build

            upgradeToNonSupportedVersion(version);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Will try to upgrade to a non-supported version by changing server's build properties file
     *
     * @param versionNumber - Desired vision version
     */
    private void upgradeToNonSupportedVersion(String versionNumber) {
        RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
        RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
        Upgrade upgrade = new Upgrade(radwareServerCli, rootServerCli);
        String[] notSupportedVersion = upgrade.getNonSupportedVersion();

        String[] path = upgrade.getBuildFileInfo().getPath().toString().split("/");
        String fileName = path[path.length - 1];

        try {
            /* Change version to unsupported one */
            CliOperations.runCommand(rootServerCli, "/bin/cp /opt/radware/mgt-server/build.properties /opt/radware/storage/",
                    CliOperations.DEFAULT_TIME_OUT, false, false, true);

            String ChangeMajorVersion = String.format("sed -i 's/buildMajorVersion: .*$/buildMajorVersion: %s/g' /opt/radware/mgt-server/build.properties", notSupportedVersion[0]);
            CliOperations.runCommand(rootServerCli, ChangeMajorVersion, CliOperations.DEFAULT_TIME_OUT, false, false, true);

            String changeMinorVersion = String.format("sed -i 's/buildMinorVersion: .*$/buildMinorVersion: %s/g' /opt/radware/mgt-server/build.properties", notSupportedVersion[1]);
            CliOperations.runCommand(rootServerCli, changeMinorVersion, CliOperations.DEFAULT_TIME_OUT, false, false, true);
            BaseTestUtils.report("Setting Server property file to version: " + String.format("%s.%s.%s", notSupportedVersion[0], notSupportedVersion[1], notSupportedVersion[2]), Reporter.PASS_NOR_FAIL);
            VisionServer.downloadUpgradeFile(rootServerCli, upgrade.getBuildFileInfo().getDownloadUri().toString() , upgrade.getBuildFileInfo().getChecksums().getMd5());
            String upgradePassword = "";
            radwareServerCli.setUpgradePassword(upgradePassword);
            radwareServerCli.setBeginningTheAPSoluteVisionUpgradeProcessEndsCommand(false);

            int responseTimeOut = 10 * 60 * 1000;
            /* Run the system upgrade command */
            CliOperations.runCommand(radwareServerCli, Menu.system().upgrade().full().build() + " " + fileName,
                    responseTimeOut, false, false, true);
            ArrayList<String> output = radwareServerCli.getCmdOutput();
            String errorMessage = String.format("Upgrade from source version \\d+.\\d+.\\d+.\\d+ to version %s is not supported.", versionNumber);
            Pattern pattern = Pattern.compile(errorMessage);
            Matcher matcher = pattern.matcher(output.toString());
            if (matcher.find() &&
                    output.toString().contains("Failed to upgrade") &&
                    output.toString().contains("The APSolute Vision upgrade process failed.")) {
                BaseTestUtils.report("Installation of un-supported version Passed.", Reporter.PASS);
            } else
                BaseTestUtils.report("Installation of un-supported version Failed. Actual output:" + output, Reporter.FAIL);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            try {
                /* Revert to the original */
                CliOperations.runCommand(rootServerCli, "/bin/cp /opt/radware/storage/build.properties /opt/radware/mgt-server/ ",
                        CliOperations.DEFAULT_TIME_OUT, false, false, true);
                /* Delete all upgrade files */
                CliOperations.runCommand(rootServerCli, "rm -f /uploads/temp/Upgrade*",
                        CliOperations.DEFAULT_TIME_OUT, false, false, true);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
    }

    @Given("^Upgrade to future version$")
    public void upgradeToFutureVersion() {
        try {
            String version = VMOperationsSteps.readVisionVersionFromPomFile();
            String build = "";
            build = BaseTestUtils.getRuntimeProperty("BUILD", build);
            if (build == null || build.equals("") || build.equals("0")) build = "";//Latest Build

            upgradeToTheNextBuild(build);
            VMOperationsSteps.updateVersionVar();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    private void upgradeToTheNextBuild(String build) {
        RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
        RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
        Upgrade upgrade = new Upgrade(radwareServerCli, rootServerCli);
        String buildUnderTest = upgrade.getBuild();
        if (upgrade.isSetupNeeded) {
            BaseTestUtils.report("Upgrading to latest build: " + buildUnderTest,
                    Reporter.PASS_NOR_FAIL);
            upgrade.deploy();

            BaseTestUtils.report("Server is ready for future upgrade", Reporter.PASS_NOR_FAIL);
        }
        GeneralSteps.clearAllLogs();
        upgrade = new Upgrade(radwareServerCli, rootServerCli);
        //Force upgrade to make sure another upgrade will occur.
        upgrade.isSetupNeeded = true;
        String nextBuild = upgrade.getBuild();

        BaseTestUtils.report(String.format("Going to upgrade from build %s to %s", buildUnderTest, nextBuild),
                Reporter.PASS_NOR_FAIL);
        upgrade.deploy();
    }

    public void UpgradeVisionServerFromOldVersion(String version) {
        try {
            FileType upgradeType = FileType.UPGRADE;
            JFrogFileModel buildFileInfo = JFrogAPI.getBuildFromOldVersion(upgradeType, version);
            String[] path = buildFileInfo.getPath().toString().split("/");
            RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
            RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
            VisionServer.upgradeServerFile(radwareServerCli, rootServerCli
                    , null, path[path.length - 1], buildFileInfo.getDownloadUri().toString(), buildFileInfo.getChecksums().getMd5());
            validateVisionServerServicesUP(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Setup Failed. Changing server to OFFLINE", Reporter.FAIL);
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
