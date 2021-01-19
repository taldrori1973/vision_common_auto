package com.radware.vision.bddtests.VRM;

import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Report;
import com.radware.vision.infra.testhandlers.vrm.VRMHandler;
import com.radware.vision.infra.testhandlers.vrm.VRMReportsHandler;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReportSteps extends BddUITestBase {
    private VRMReportsHandler vrmReportsHandler = new VRMReportsHandler();

    public ReportSteps() throws Exception {
    }

    /**
     * @param operationType or Create or Validate or Edit (Enum)
     * @param reportName    The name of the report (String)
     * @param reportsEntry  The values that the user want to added it like:
     *                      *- | reportType| DefensePro Analytics Dashboard / HTTPS Flood
     *                      The device type that you want to create the reporter with
     *
     *                      Scope Selection:
     *                      By Devices for non HTTPS Flood , or Policy for HTTPS Flood
     *                      *- | devices| index:10, ports:[1], policies:[pol_1]; ports: [1,3], index:11;|
     *                      - The scope selection widget - you can select any device and its ports and policies
     *                      - we seperate between the devices by ';'
     *                      - The ports and policies value shold be inside [] (type of array)
     *                      - We seperate between the different keys inside the same device by ','
     *
     *                      *- | policy | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
     *
     *                      * - | Time Definitions.Date|Quick:30m|
     *                      - Second widget is time definition you can select it with 3 ways:
     *                      - Quick: you type Quick:'the time definition how it witten at the UI'
     *                      example: | Time Definitions.Date|Quick:30m|
     *                      - Absolute: you type the ket 'Absolute:' and the value will be by two ways
     *                      - one value like '+5m' it will add 5 minutes on the machine's current time
     *                      example:  | Time Definitions.Date | Absolute:+1d| it will add 1 day in the current time
     *                      - two params: the first time is which date it will start - you type the format date that found at the UI
     *                      the second is the same like the first way
     *                      example:  | Time Definitions.Date | Absolute:[Feb 27, 1971 01:00, +1d]|
     *                      - Relative: you type Relative:[day/weeks/Hour/month/: the value]
     *                      example | Time Definitions.Date | Relative:[Hours,1]|
     *                      * - | Schedule|Run Every:Daily,On Time:+5m|
     *                      - The user have to write the Run Every value
     *                      you can select or Daily/Weekly/Monthly/Ounce
     *                      - The user can do it by two ways:
     *                      - By type +/-[value][type of the value] after On Time key, like +2M = after 2 months from now (it works with Once/Weekly/Daily/Monthly)
     *                      - By type all of the UI params
     *                      - Once: | Schedule| Run Every:Once,On Time:15:30, On Day:12-08-2018|
     *                      - Monthly: | Schedule| Run Every:Monthly,At Months:[FEB,JAN],ON Day of Month:5,On Time:10:00 |
     *                      - Weekly: | Schedule| Run Every:Weekly, At Week Day:[TUE],On Time:10:00|
     *                      - Daily:  | Schedule| Run Every:daily, On Time:10:00|
     *                      * - | Delivery|Email:[VisionQA3@radware.com],Subject:Subject,Body:english chrarecters1# |
     *                      * - | Design|Delete:[ALL], Add:[Top Attacks]| (it will do the delete (if found) first always )
     *                      <p>
     *                      <p>
     *                      <p>
     *                      <p>
     *                      Edit is the same thing
     *                      Validate the same thing but it diffrent at the Design
     *                      | Design| Widgets:[Top Attacks]| = it is mean which widgets i want see finally
     *                      <p>
     *                      <p>
     *                      you ca write all of the table or some of the columns
     *                      and it will work
     */
    @Then("^UI \"(Create|Validate|Edit|Generate|Isexist|Delete)\" Report With Name \"([^\"]*)\"( negative)?$")
    public void uiReportWithName(vrmActions operationType, String reportName,String negative, Map<String, String> reportsEntry) throws Throwable {
        new Report().baseOperation(operationType, reportName, negative, reportsEntry, restTestBase.getRootServerCli());
    }

    @Then("^UI Open Report Parameters$")
    public void uiOpenReportParameters() throws Throwable {
        Report.expandReportParameters();
    }

    @Then("^UI Delete Report With Name \"([^\"]*)\"( negative)?$")
    public void uiReportWithName(String reportName,String negative) throws Throwable {
        new Report().delete(reportName);
    }

    @When("^UI Validate invalid message in delivery$")
    public void uiValidatePopupMessageInDelivery() throws TargetWebElementNotFoundException {
        vrmReportsHandler.uiValidateInvalidMessageInDelivery();
    }

    @Then("^UI Validate max generate Report is (\\d+)$")
    public void uiValidateMaxGenerateReportIs(int maxValue) throws Exception {
        vrmReportsHandler.uiValidateMaxGenerateView(maxValue);
    }


    @Then("^UI Validate max generate Report Template is (\\d+)$")
    public void uivalidateMaxGenerateTemplateReportIs(int maxValue) throws Exception {
        vrmReportsHandler.uivalidateMaxGenerateTemplateView(maxValue);
    }

    @Then("^UI Validate Expand$")
    public void uiValidateExpand() throws TargetWebElementNotFoundException {
        vrmReportsHandler.validateExpand();
    }

    @Then("^UI Validate Scope Selection Search With Element Type \"([^\"]*)\" And Device index (\\d+)$")
    public void uiValidateSearch(String elementType, int index) throws Exception {
        vrmReportsHandler.validateSearch(elementType, index);
    }

    @Then("^UI Validate Search The Text \"([^\"]*)\" in Search Label \"([^\"]*)\" if this elements exist with prefix label \"([^\"]*)\"$")
    public void uiValidateSearchTheTextInSearchPlaceIfThisElementsExist(String text, String searchPlace,String prefixLabel, List<VRMHandler.LabelParam> elementsExist) throws Exception {
        vrmReportsHandler.validateFilter(text, searchPlace, elementsExist, prefixLabel);
    }

    @Then("^UI Validate Search With Label: \"([^\"]*)\" and param: \"([^\"]*)\" in Search Label \"([^\"]*)\" if this elements exist take label text$")
    public void uiValidateSearchWithLabelText(String label, String param, String searchPlace) throws Exception {
        vrmReportsHandler.validateFilterWithLabelText(label, param, searchPlace);
    }

    @Then("^UI Validate Search Numbering With text: \"([^\"]*)\" And Element Label: \"([^\"]*)\" In Search Label \"([^\"]*)\" If this equal to (\\d+)$")
    public void uiValidateNumberingFilter(String text, String label, String searchLabel, int expectedNumber) throws Exception {
        vrmReportsHandler.validateFilterNumbering(text, label, searchLabel, expectedNumber);
    }

    @Then("^UI Validate Reports Design Drag and Drop$")
    public void uiValidateReportsDesignDragAndDrop(Map<String, String> reportsEntry) throws Throwable {
        vrmReportsHandler.validateDragAndDrop(reportsEntry);

    }

    @Then("^UI Undo Widgets with label \"([^\"]*)\"$")
    public void uiUndoWidgetsWithLabel(String label, List<String> listWidgets) throws Throwable {
        vrmReportsHandler.undoWidgets(label,listWidgets);

    }

    @Then("^UI Validate Report Mail With Subject \"([^\"]*)\" And Content \"([^\"]*)\"$")
    public void reportMail(String subject , String content) throws Exception{
        vrmReportsHandler.validateMailReport(subject,content);
    }

    @Then("^UI Generate (and Validate )?Report With Name \"([^\"]*)\" with Timeout of (\\d+) Seconds$")
    public void uiGenerateAndValidateReportWithNameWithTimeoutOfSeconds(String Validate,String reportName ,int timeout) throws Exception {
        Map<String,String> map=new HashMap<>();
        map.put("validation",Validate);
        map.put("timeout",String.valueOf(timeout));
        vrmReportsHandler.VRMReportOperation(vrmActions.GENERATE,reportName,map,restTestBase.getRootServerCli());
    }

    @Then("^UI validate togglesData in report \"([^\"]*)\" with widget \"([^\"]*)\"$")
    public void uiValidateTogglesDataInReportWithWidget(String reportName, String widget, List<VRMHandler.ToggleData> entries) throws Throwable {
            vrmReportsHandler.uiValidateTogglesDataInReportWithWidget(reportName, widget, entries);
    }

}