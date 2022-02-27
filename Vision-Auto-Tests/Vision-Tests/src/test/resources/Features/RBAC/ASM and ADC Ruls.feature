@TC125289

Feature: AMS and ADC Analytics Users

  @SID_1
  Scenario: Login And Go to Vision
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"


  @SID_2
  Scenario Outline: Create users
    When UI Create New User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" ,Password "<Password>"
    Then  UI User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" Exists
    Examples:
      | User Name       | Role               | Scope | Password        |
      | ADC_ANALYTICS_1 | ADC Analytics User | [ALL] | Radware1234!@#$ |
      | AMS_ANALYTICS_1 | AMS Analytics User | [ALL] | Radware1234!@#$ |

  @SID_3
  Scenario: Edit User Management Settings
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "Local" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_4
  Scenario: ADC_ANALYTICS_Viewer RBAC Validation
    When UI Login with user "ADC_ANALYTICS_1" and password "Radware1234!@#$"
    And Sleep "10"
    Then UI Validate user rbac
      | operations        | accesses |
      | VISION SETTINGS   | no       |
      | ANALYTICS ADC     | yes      |
      | ANALYTICS AMS     | no       |
      | APPLICATIONS_ITEM | no       |
      | AUTOMATION_ITEM   | no       |
      | DEFENSEFLOW_ITEM  | no       |
      | SCHEDULER_ITEM    | no       |
      | vDirect           | no       |
      | GEL Dashboard     | no       |
      | EAAF Dashboard    | no       |


  @SID_5
  Scenario: Create and validate ADC Report1
    When UI Navigate to "ADC Reports" page via homePage
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC System and Network Report1"
      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.154.215] |
      | Time Definitions.Date | Quick:1H                                                                                                   |
      | Format                | Select:  CSV                                                                                               |
    Then UI "Validate" Report With Name "ADC System and Network Report1"
      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.154.215] |
      | Time Definitions.Date | Quick:1H                                                                                                   |
      | Format                | Select: CSV                                                                                                |


  @SID_6
  Scenario: generate ADC report1
    Then UI "Generate" Report With Name "ADC System and Network Report1"
      | timeOut | 60 |
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep 'VRM_report_.*.zip' | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.zip" on "ROOT_SERVER_CLI"

  @SID_7
  Scenario: Delete ADC report1
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "ADC System and Network Report1"
    Then UI Delete Report With Name "ADC System and Network Report1"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "ADC System and Network Report1"

  @SID_8
  Scenario: Create and validate ADC Report2
    When UI Navigate to "ADC Reports" page via homePage
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC System and Network Report2"
      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.154.215] |
      | Time Definitions.Date | Quick:1H                                                                                                   |
      | Format                | Select:  PDF                                                                                               |
    Then UI "Validate" Report With Name "ADC System and Network Report2"
      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.154.215] |
      | Time Definitions.Date | Quick:1H                                                                                                   |
      | Format                | Select: PDF                                                                                                |

  @SID_9
  Scenario: generate ADC report2
    Then UI "Generate" Report With Name "ADC System and Network Report2"
      | timeOut | 60 |
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep 'VRM_report_.*.pdf' | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.pdf" on "ROOT_SERVER_CLI"


  @SID_10
  Scenario: Edit ADC report2
    Given UI "Edit" Report With Name "ADC System and Network Report2"
      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.154.215] |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Format                | Select: HTML                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
    Then UI "Validate" Report With Name "ADC System and Network Report2"
      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.154.215] |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Format                | Select: HTML                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |

  @SID_11
  Scenario: generate ADC report2 after edit
    Then UI "Generate" Report With Name "ADC System and Network Report2"
      | timeOut | 60 |
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep 'VRM_report_.*.html' | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.html" on "ROOT_SERVER_CLI"

  @SID_12
  Scenario: Delete ADC report2
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "ADC System and Network Report2"
    Then UI Delete Report With Name "ADC System and Network Report2"
    Then Sleep "2"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "ADC System and Network Report2"
    Then UI Logout


  @SID_13
  Scenario: AMS_ANALYTICS_Viewer RBAC Validation
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*" on "ROOT_SERVER_CLI"
    When UI Login with user "AMS_ANALYTICS_1" and password "Radware1234!@#$"
    And Sleep "10"
    Then UI Validate user rbac
      | operations        | accesses |
      | VISION SETTINGS   | no       |
      | ANALYTICS ADC     | no       |
      | ANALYTICS AMS     | yes      |
      | AppWall Dashboard | no       |
      | APPLICATIONS_ITEM | no       |
      | AUTOMATION_ITEM   | no       |
      | DEFENSEFLOW_ITEM  | no       |
      | SCHEDULER_ITEM    | no       |
      | vDirect           | no       |
      | GEL Dashboard     | no       |
      | EAAF Dashboard    | no       |


  @SID_14
  Scenario: Create and validate AMS Report1
    When UI Navigate to "AMS Reports" page via homePage
    Given UI "Create" Report With Name "AMSReport"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                               |
      | Format                | Select: CSV                                                                                    |
    Then UI "Validate" Report With Name "Top Attack Destinations Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                               |
      | Format                | Select: CSV                                                                                    |

  @SID_15
  Scenario: Validate Disable/Enable Template
    Then UI Click Button "Edit Report" with value "AMSReport"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label    | param                             | value |
      | Template | DefensePro Analytics              | true  |
      | Template | DefensePro Behavioral Protections | true  |
      | Template | HTTPS Flood                       | true  |
      | Template | DefenseFlow Analytics             | true  |
      | Template | AppWall                           | false |
      | Template | ERT Active Attackers Feed         | true  |


  @SID_16
  Scenario: generate report
    Then UI "Generate" Report With Name "AMSReport"
      | timeOut | 60 |
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep 'VRM_report_.*.zip' | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.zip" on "ROOT_SERVER_CLI"

  @SID_17
  Scenario: Edit report to HTML format and Validate Generated Report
    Then UI "Edit" Report With Name "AMSReport"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "AMSReport"
      | Format | Select: HTML |
    Then UI "Generate" Report With Name "AMSReport"
      | timeOut | 120 |
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep 'VRM_report_.*.html' | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.html" on "ROOT_SERVER_CLI"

  @SID_18
  Scenario: Edit report to HTML format and Validate Generated Report
    Then UI "Edit" Report With Name "AMSReport"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "AMSReport"
      | Format | Select: PDF |
    Then UI "Generate" Report With Name "AMSReport"
      | timeOut | 120 |
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep 'VRM_report_.*.pdf' | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.pdf" on "ROOT_SERVER_CLI"

  @SID_19
  Scenario: Delete Report Validation
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "AMSReport"
    Then UI Delete Report With Name "AMSReport"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "AMSReport"

  @SID_20
  Scenario: Create Alert Delivery
    And UI Navigate to "AMS Alerts" page via homePage
    When UI "Create" Alerts With Name "Alert Delivery"
      | Product    | DefensePro                                                                                                                  |
      | Basic Info | Description:Alert Delivery Description,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical     |
      | Criteria   | Event Criteria:Action,Operator:Not Equals,Value:[Blocked];                                                                  |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                                                                           |
      | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body |
    And Sleep "10"

  @SID_21
  Scenario: Validate License Enable/Disable
    Then UI Click Button "Add New"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label          | param      | value |
      | Product Button | defensepro | ture  |
      | Product Button | appwall    | false |
    Then UI Click Button "Close"

  @SID_22
  Scenario: Delete Alert and Validation
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert Delivery"
    When UI Delete Alerts With Name "Alert Delivery"
    Then Sleep "5"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert Delivery"

  @SID_23
  Scenario: create new Forensics_DP and validate
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "Forensics_DP"
      | Product               | DefensePro                                                                                                                 |
      | Application           | All                                                                                                                        |
      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
      | Format                | Select: CSV                                                                                                                |
      | Time Definitions.Date | Quick:Today                                                                                                                |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware           |

  @SID_24
  Scenario: Forensic New Category Validate ForensicsView
    Then UI Click Button "My Forensics" with value "Forensics_DP"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_DP"
    Then Sleep "20"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Forensics_DP"
    Then UI Click Button "Views.Forensic" with value "Forensics_DP,0"
    Then UI Validate Element Existence By Label "Forensics View" if Exists "true" with value "Forensics_DP"

  @SID_25
  Scenario: Edit Forensics to HTML format and Validate Generated Forensics
    When UI "Edit" Forensics With Name "Forensics_DP"
      | Format | Select: HTML |
    Then UI Click Button "My Forensics" with value "Forensics_DP"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_DP"
    Then Sleep "20"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Forensics_DP"
    Then UI Click Button "Views.Forensic" with value "Forensics_DP,1"
    Then UI Validate Element Existence By Label "Forensics View" if Exists "true" with value "Forensics_DP"

  @SID_26
  Scenario: Validate Enabled/Disabled Forensics Product Templates
    Then UI Click Button "Edit Forensics" with value "Forensics_DP"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label   | param       | value |
      | Product | DefensePro  | true  |
      | Product | DefenseFlow | false |
      | Product | AppWall     | false |
    Then UI Click Button "Close Edit Tab"

  @SID_27
  Scenario: Delete Forensics and Validation
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Forensics_DP"
    Then UI Delete Forensics With Name "Forensics_DP"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Forensics_DP"
    Then UI Logout

  @SID_28
  Scenario Outline: Delete All Users
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"
    When UI Delete User With User Name "<User Name>"
    Examples:
      | User Name       |
      | ADC_ANALYTICS_1 |
      | AMS_ANALYTICS_1 |

  @SID_29
  Scenario: Login And Go to Vision
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "TACACS+" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI logout and close browser