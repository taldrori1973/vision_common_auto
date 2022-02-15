package com.radware.vision.bddtests;

import com.radware.automation.bdd.reporter.BddReporterManager;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.Scenario;
import cucumber.api.java.After;
import cucumber.api.java.Before;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class BddHooks extends VisionUITestBase {

    public BddHooks() throws Exception {
    }

    @Before
    public void beforeScenario(Scenario scenario) {
        try {
            BddReporterManager.initReport(scenario, false);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Init", e);
        }
    }

    @After
    public void afterScenario() {
        publishBddResults();
    }

    @After
    public void afterAll() throws UnknownHostException {
        String localIP = InetAddress.getLocalHost().getHostAddress();
        String command = Menu.system().database().access().revoke().build() + " " + localIP;
        CliOperations.runCommand(serversManagement.getRadwareServerCli().get(), command);
    }
}
