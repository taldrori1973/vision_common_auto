@TC117967
Feature: Negative test to validate Error Messages

  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and halt 185 seconds

  @SID_2
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
#    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Service "config_kvision-collector_1" do action RESTART
#    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds
    Then CLI Validate service "CONFIG_KVISION_COLLECTOR" is up with timeout "45" minutes

  @SID_3
  Scenario: Clear Database and old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Update Policies
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs

  @SID_5
  Scenario:Login and Navigate to HTTPS Server Dashboard
    Then UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given Rest Add Policy "pol1" To DP "172.16.22.51" if Not Exist
    And Rest Add new Rule "https_servers_automation" in Profile "ProfileHttpsflood" to Policy "pol1" to DP "172.16.22.51"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.50"}},"script":{"source":"ctx._source.endTime='$(date +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"

  @SID_6
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
#    Given CLI simulate 2 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 5000 and wait 60 seconds
    Given CLI simulate 2 attacks of type "HTTPS" on SetId "DefensePro_Set_1" with loopDelay 5000 and wait 60 seconds

  @SID_7
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_8
  Scenario: Create New Report Empty
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a name for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_9
  Scenario: Create New Report without Templates
    Then UI Click Button "New Report Tab"
    Then UI Open Report Parameters
    Then UI Set Text Field "Report Name" To "Report without templates"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a template for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report without templates"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a template for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report without templates"?"
    Then UI Click Button "No"

  @SID_10
  Scenario: Create New Report with Report Name invalid
    Then UI Click Button "New Report Tab"
    Then UI Open Report Parameters
    Then UI Set Text Field "Report Name" To ","
    Then UI Click Button "Add Template" with value "HTTPS Flood"
    Then UI Click Button "Open Scope Selection" with value "HTTPS Flood"
    Then UI Click Button "httpsScopeRadio" with value "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https"
    Then UI Click Button "SaveHTTPSScopeSelection"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report name contains special characters. Remove the special characters."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save ","?"
    Then UI Click Button "No"

  @SID_11
  Scenario: Create New Report with Report with more than 50 Widgets without policy and port
    Then UI Click Button "New Report Tab"
    Then UI Open Report Parameters
    Then UI Set Text Field "Report Name" To "Report with more than 50 Widgets without device and policy and port"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report Template requires the selection of a single device and policy."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with more than 50 Widgets without device and policy and port"?"
    Then UI Click Button "No"

  @SID_12
  Scenario: Create New DefensePro Behavioral Protections report without policy and port
    Then UI Click Button "New Report Tab"
    Then UI Open Report Parameters
    Then UI Set Text Field "Report Name" To "DefensePro Behavioral Protections report without policy and port"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report Template requires the selection of a single device and policy."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefensePro Behavioral Protections report without policy and port"?"
    Then UI Click Button "No"

  @SID_13
  Scenario: Create New DefensePro Behavioral Protections report without port
    Then UI Click Button "New Report Tab"
    Then UI Open Report Parameters
    Then UI Set Text Field "Report Name" To "DefensePro Behavioral Protections report without port"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report Template requires the selection of a single device and policy."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefensePro Behavioral Protections report without port"?"
    Then UI Click Button "No"

  @SID_14
  Scenario: Create New Report with Report with more than 200 Widgets
    Then UI Click Button "New Report Tab"
    Then UI Open Report Parameters
    Then UI Set Text Field "Report Name" To "Report with more than 50 Widgets"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "HTTPS Flood"
    Then UI Click Button "Open Scope Selection" with value "HTTPS Flood"
    Then UI Click Button "httpsScopeRadio" with value "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https"
    Then UI Click Button "SaveHTTPSScopeSelection"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report configuration contains too many widgets. A Report can contain no more than 200 widgets. The current configuration contains 201 widgets. Remove at least 1 widgets from the Report configuration and try again."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with more than 50 Widgets"?"
    Then UI Click Button "No"

  @SID_15
  Scenario: Create New Report with invalid Email
    Then UI Click Button "New Report Tab"
    Then UI Open Report Parameters
    Then UI Set Text Field "Report Name" To "Report with invalid Email"
    Then UI Set Text Field "Email" To "invalidEmail"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Share configuration of the Report is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with invalid Email"?"
    Then UI Click Button "No"

  @SID_16
  Scenario: Create two reports with same name
    Given UI "Create" Report With Name "Duplicate Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                               |
      | Format                | Select: CSV                                                                                    |

    Given UI "Validate" Report With Name "Duplicate Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                               |
      | Format                | Select: CSV                                                                                    |

    Given UI "Create" Report With Name "Duplicate Report" negative
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                               |
      | Format                | Select: CSV                                                                                    |

    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'Duplicate Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"

    Then UI Text of "Save Change Message" contains "Do you want to save "Duplicate Report"?"
    Then UI Click Button "No"

    Then UI Click Button "My Report Tab"
    Then UI Delete Report With Name "Duplicate Report"

  @SID_17
  Scenario: Logout
    Then UI logout and close browser
