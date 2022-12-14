package com.radware.vision.bddtests.clioperation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.base.VisionCliTestBase;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;


public class ConsoleOperation extends TestBase {

    /* this for commands contain ? in the last command (help output) */
    @Then("^CLI Operations - Run Radware Session help command \"([^\"]*)\"$")
    public void runRadwareHelpCommand(String command) {
        if (command.contains("?")) {
            CliOperations.runCommand(serversManagement.getRadwareServerCli().get(), command,
                    CliOperations.DEFAULT_TIME_OUT, false, false, false, null, false);
            CliOperations.runCommand(serversManagement.getRadwareServerCli().get(),
                    "nothing", CliOperations.DEFAULT_TIME_OUT);
        } else
            runRadwareCommand(command);
    }

    @When("^CLI Operations - Run Radware Session command \"([^\"]*)\" on vision 2, timeout (\\d+)$")
    public void runRadwareCommandOnVision2(String command, Integer timeOut) {
        try {


            timeOut = timeOut != null ? timeOut : 30;
            //           kVision
//            String Host2 = restTestBase.getVisionServerHA().getHost_2();
//            ServerCliBase radwareServerCli = new RadwareServerCli(Host2, SutUtils.getCurrentVisionRestUserName(), SutUtils.getCurrentVisionRestUserPassword());
//            radwareServerCli.init();
//            radwareServerCli.connect();
//           kVision
//            CliOperations.runCommand(radwareServerCli, command, timeOut * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + command + ", on vision 2 " + "\n" + e.getMessage(), Reporter.FAIL);

        }
    }

    @When("^CLI Operations - Run Radware Session command \"([^\"]*)\" timeout (\\d+)$")
    public void runRadwareCommand(String command, int timeout) {
        int sec = 1000;
        CliOperations.runCommand(serversManagement.getRadwareServerCli().get(), command, timeout * sec);
    }

    @Then("^CLI Operations - Run Radware Session command \"([^\"]*)\"$")
    public void runRadwareCommand(String command) {
        try {
            Optional<RadwareServerCli> radwareServerCliOpt = serversManagement.getRadwareServerCli();
            if (!radwareServerCliOpt.isPresent()) {
                throw new Exception("Radware Server Not found!");
            }
            CliOperations.runCommand(radwareServerCliOpt.get(), command);
        } catch (Exception e) {
            BaseTestUtils.report(String.format("Error: %s", e.getMessage()), Reporter.FAIL);
        }
    }

    @When("^CLI Operations - Run Root Session command \"(.*)\"$")
    public void runRootCommand(String command) {
        try {
            Optional<RootServerCli> rootServerCliOpt = serversManagement.getRootServerCLI();
            if (!rootServerCliOpt.isPresent()) {
                throw new Exception("Root Server Not found!");
            }
            CliOperations.runCommand(rootServerCliOpt.get(), command);
        } catch (Exception e) {
            BaseTestUtils.report(String.format("Error: %s", e.getMessage()), Reporter.FAIL);
        }
    }

    @When("^CLI Operations - Run Root Session command \"(.*)\" timeout (\\d+)$")
    public void runRootCommand(String command, int timeout) {
        int sec = 1000;
        CliOperations.runCommand(serversManagement.getRootServerCLI().get(), command, timeout * sec);
    }

    @Then("^CLI Operations - Verify last output contains$")
    public void verifyLastOutput(List<String> output) {
        List<String> lastOutputItems = CliOperations.resultLines;
        StringBuilder result = new StringBuilder();
        for (String out : output) {
            for (String lastOutputItem : lastOutputItems) {
                if (!lastOutputItem.contains(out)) {
                    result.append("Actual values not contains: ").append(Arrays.asList(out)).append("\n");
                    break;
                }
            }
        }
        if (!result.toString().equals("")) {
            BaseTestUtils.report(result.toString(), Reporter.FAIL);
        }
    }


    @Then("^CLI Operations - Verify interval of (\\d+) seconds in log \"(.*)\" for print \"(.*)\" with valid deviation of (\\d+)$")
    public void verifyLogPrintIntervalWithDeviation(int expectedInterval, String logFile, String relevantPrint, int validDeviation) {
        String strCommand = "echo $(date +%s -d $(grep \"" + relevantPrint + "\" " + logFile + " | tail -1 | awk '{print substr($2,0,8)}')) - " + " $(date +%s -d $(grep \"" + relevantPrint + "\" " + logFile + " | tail -2 | head -1 | awk '{print substr($2,0,8)}')) | bc";
        runRootCommand(strCommand);
        int intActualInterval = Integer.parseInt(CliOperations.resultLines.get(CliOperations.resultLines.size() - 1));
        CliOperations.verifyDeviationValidity(intActualInterval, expectedInterval, validDeviation);
    }

    @Then("^CLI Operations - Verify last output not contains$")
    public void verifyLastOutputNotContain(List<String> output) {
        List<String> lastOutputItems = CliOperations.resultLines;
        StringBuilder result = new StringBuilder();
        for (String out : output) {
            if (lastOutputItems.contains(out)) {
                result.append("Actual values contains: ").append(Arrays.asList(out)).append("\n");
            }
        }
        if (!result.toString().equals("")) {
            BaseTestUtils.report(result.toString(), Reporter.FAIL);
        }
    }

    @Then("^CLI Connect Root$")
    public void connectRootCLI() {
        try {
            RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
            rootServerCli.disconnect();
            rootServerCli.connect();
        } catch (Exception e) {
            BaseTestUtils.report("failed to connect Root CLI: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^CLI Connect Radware$")
    public void connectRadwareCLI() {
        try {
            RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
            radwareServerCli.disconnect();
            radwareServerCli.connect();
        } catch (Exception e) {
            BaseTestUtils.report("failed to connect Radware CLI: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^CLI Operations - Verify that output contains regex \"(.*)\"( negative)?$")
    public void verifyLastOutputByRegex(String regex, String negative) {
        CliOperations.verifyLastOutputByRegex(regex);
    }

    @Then("^CLI Operations - Using \"(radware|root)\" User to Verify that output contains regex \"(.*)\"( negative)?$")
    public void verifyLastOutputByRegex(String user, String regex, String negative) {
        if (user.equalsIgnoreCase("radware")) {
            CliOperations.verifyLastOutputByRegex(regex, serversManagement.getRadwareServerCli().get());
        } else if (user.equalsIgnoreCase("root")) {
            CliOperations.verifyLastOutputByRegex(regex, serversManagement.getRootServerCLI().get());
        } else {
            BaseTestUtils.report(user + " is not supported here!", Reporter.FAIL);
        }
    }


    @Then("^CLI Operations - Verify that the output Lines number as expected (\\d+)$")
    public void verifyLinesNumber(int num) {
        CliOperations.verifyLinesNumber(num);
    }

    @Then("^Clear Radware Session$")
    public void clearRadwareSession() {
        StringBuilder clearString = new StringBuilder();
        for (int i = 0; i < 60; i++) {
            clearString.append("\b");
        }
        CliOperations.runCommand(serversManagement.getRadwareServerCli().get(), clearString.toString(), 2* 2000,true,true,
                true, null, true, true);
    }
}
