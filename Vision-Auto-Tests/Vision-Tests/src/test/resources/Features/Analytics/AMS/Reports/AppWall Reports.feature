@TC112423
Feature: AppWall Reports

  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-AVA-AppWall"
    * REST Delete ES index "appwall-v2-attack*"
    * REST Delete ES index "vrm-scheduled-report-*"
    * CLI Clear vision logs

  @SID_2
  Scenario:Run AW Attacks
    Given CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 5 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |

    And CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/AppwallAttackTypes/Injection3 \| netcat " |
      | #visionIP                                                               |
      | " 2215"                                                                 |

    And Sleep "40"

    And CLI Operations - Run Root Session command "curl -XPOST -H "Content-type: application/json" -s "localhost:9200/appwall-v2-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool":{"must":{"term":{"tunnel":"tun_HTTP"}}}},"script":{"source":"ctx._source.receivedTimeStamp='$(echo $(date +%s%3N)-7200000|bc)L';"}}'"
    And CLI Operations - Run Root Session command "curl -XPOST -H "Content-type: application/json" -s "localhost:9200/appwall-v2-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool":{"must":{"term":{"tunnel":"Default Web Application"}}}},"script":{"source":"ctx._source.receivedTimeStamp='$(echo $(date +%s%3N)-7200000|bc)L';"}}'"

    And CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 5 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |
    And Sleep "40"


  @SID_3
  Scenario: Clear SMTP Server Log Files
    Given CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/radware" on "GENERIC_LINUX_SERVER"
    And CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"

  @SID_4
  Scenario: Login And Copy uVision_get_scheduled_report_value.sh File To Server
    Given UI Login with user "radware" and password "radware"
    And CLI copy "/home/radware/Scripts/uVision_get_scheduled_report_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_5
  Scenario: Email Configuration
    Then UI Navigate to "VISION SETTINGS" page via homePage
    Given UI Go To Vision
    And UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    And UI Do Operation "select" item "Email Reporting Configuration"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    And UI Set Text Field "From Header" To "Automation system"
    And UI Set Checkbox "Enable" To "false"
    And UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"

  @SID_6
  Scenario: Navigate AMS Report
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then REST Add device with DeviceID "AppWall_172.17.164.30" into site "AW_site"
    * REST Vision Install License Request "vision-AVA-AppWall"
    And Browser Refresh Page
    And UI Navigate to "AMS Reports" page via homePage


  # =============================================Overall===========================================================
  @SID_7
  Scenario: Create One Report Validation
    Given UI "Create" Report With Name "OverAllAppWallReport"
      | Template | reportType:AppWall , Widgets:[Top Sources,Attacks by Action] , Applications:[Vision1,radware1,test1] , showTable:false |
      | Logo     | reportLogoPNG.png                                                                                                      |

    Then UI "Validate" Report With Name "OverAllAppWallReport"
      | Template | reportType:AppWall , Widgets:[Top Sources,Attacks by Action] , Applications:[Vision1,radware1,test1] , showTable:false |
      | Logo     | reportLogoPNG.png                                                                                                      |

    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverAllAppWallReport"


  @SID_8
  Scenario: Edit Report Validation
    Given UI "Edit" Report With Name "OverAllAppWallReport"
      | Template-3            | reportType:AppWall , Widgets:[Attack Severity] , Applications:[Vision2] , showTable:false |
      | Time Definitions.Date | Quick:15m                                                                                 |

    Then UI "Validate" Report With Name "OverAllAppWallReport"
      | Template-3            | reportType:AppWall , Widgets:[Attack Severity] , Applications:[Vision2] , showTable:false |
      | Time Definitions.Date | Quick:15m                                                                                 |

  @SID_9
  Scenario: Generate Report Validation
    Then UI "Generate" Report With Name "OverAllAppWallReport"
      | timeOut | 90 |

  @SID_10
  Scenario: Delete Report Validation
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverAllAppWallReport"
    Then UI Delete Report With Name "OverAllAppWallReport"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "OverAllAppWallReport"

          # =============================================SanityReports===========================================================

  @SID_11
  Scenario: Create New Report With Default Values
    Given CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/radware" on "GENERIC_LINUX_SERVER"
    And CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"
    When UI "Create" Report With Name "deliveryAW"
      | Template | reportType:AppWall , Widgets:[All] , Applications:[All] , showTable:false                    |
      | Share    | Email:[automation.vision1@radware.com, also@report.local],Subject:report delivery Subject AW |

    Then UI "Generate" Report With Name "deliveryAW"
      | timeOut | 90 |

  @SID_12
  Scenario: Validate Report Email Recieved Content
    Then CLI Run remote linux Command "cat /var/spool/mail/reportuser > /tmp/reportdelivery.log" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "cat /var/spool/mail/reportuser|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject" |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run linux Command "cat /var/spool/mail/radware|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject" |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"

    Then CLI Run linux Command "grep "From: Automation system <qa_test@Radware.com>" /var/spool/mail/reportuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "From: Automation system <qa_test@Radware.com>" /var/spool/mail/radware |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run linux Command "grep "X-Original-To: also@report.local" /var/spool/mail/reportuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run linux Command "grep "X-Original-To: automation.vision1@radware.com" /var/spool/mail/radware |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"

    Then CLI Run linux Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf" /var/spool/mail/reportuser | wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run linux Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf" /var/spool/mail/radware | wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"


  @SID_13
  Scenario: Create New Report With Monthly Schedule
    When UI "Create" Report With Name "scheduleMonthlyAW"
      | Template | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Schedule | Run Every:Monthly,On Time:+2m                                                                                                                                                       |

    When UI "Validate" Report With Name "scheduleMonthlyAW"
      | Template | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Schedule | Run Every:Monthly,On Time:+2m                                                                                                                                                       |


  @SID_14
  Scenario: Create New Report With Daily Schedule
    When UI "Create" Report With Name "scheduleDailyAW"
      | Template | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Schedule | Run Every:Daily,On Time:+2m                                                                                                                                                         |

    Then UI "Validate" Report With Name "scheduleDailyAW"
      | Template | reportType:AppWall, Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity], Applications:[All] , showTable:false |
      | Schedule | Run Every:Daily,On Time:+2m                                                                                                                                                       |


  @SID_15
  Scenario: Validation If Reports Generated After The Expected Time
    Given Sleep "150"
    # validate if scheduleMonthlyAW generated in UI
    When UI Click Button "My Report" with value "scheduleMonthlyAW"
    Then UI Validate Element Existence By Label "Show Report" if Exists "true" with value "scheduleMonthlyAW,0"
    # validate if scheduleDailyAW generated in UI
    When UI Click Button "My Report" with value "scheduleDailyAW"
    Then UI Validate Element Existence By Label "Show Report" if Exists "true" with value "scheduleDailyAW,0"
    # validate scheduleMonthlyAW schedule regex matchs in CLI
    When CLI Run remote linux Command "/uVision_get_scheduled_report_value.sh scheduleMonthlyAW" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) (\d{1,2}) (\d{1,2}) \? \*"

    # validate scheduleDailyAW schedule regex matchs in CLI
    When CLI Run remote linux Command "/uVision_get_scheduled_report_value.sh scheduleDailyAW" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) (\d{1,2}) (\d{1,2}) \? \*"

  @SID_16
  Scenario: Validate Time Selection - Quick Range - Report
    Given UI "Create" Report With Name "1HourBeforeReport"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[test1] , showTable:false |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                                           |
    Then UI "Validate" Report With Name "1HourBeforeReport"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[test1] , showTable:false |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                                           |

    Then UI "Generate" Report With Name "1HourBeforeReport"
      | timeOut | 90 |


  @SID_17
  Scenario: Validate Time Selection - Relative - Report
    Given UI "Create" Report With Name "2DaysBeforeReport"
      | Template              | reportType:AppWall , Widgets:[Geolocation, Attack Severity] , Applications:[All] , showTable:false |
      | Time Definitions.Date | Relative:[Days,2]                                                                                  |
      | Format                | Select: CSV                                                                                        |
    Then UI "Validate" Report With Name "2DaysBeforeReport"
      | Template              | reportType:AppWall , Widgets:[Geolocation, Attack Severity] , Applications:[All] , showTable:false |
      | Time Definitions.Date | Relative:[Days,2]                                                                                  |
      | Format                | Select: CSV                                                                                        |

    Then UI "Generate" Report With Name "2DaysBeforeReport"
      | timeOut | 90 |

  @SID_18
  Scenario: Validate Credential of sec_mon User
    When UI Open "Configurations" Tab
    When UI logout and close browser
    And UI Login with user "sec_mon" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "2DaysBeforeReport"


  @SID_19
  Scenario: Search For Bad Logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_20
  Scenario: Cleanup
    Given UI Open "Configurations" Tab
    And UI logout and close browser



