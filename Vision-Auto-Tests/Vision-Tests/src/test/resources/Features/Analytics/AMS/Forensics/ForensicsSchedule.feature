@VRM_Alerts @TC106004
Feature: Forensics Schedule

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
#    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    * CLI Clear vision logs
    Then CLI copy "/home/radware/Scripts/get_scheduled_forensic_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |

  
  @SID_2
  Scenario: VRM - Loging to VRM "Wizard" Test
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  
  @SID_3
  Scenario: VRM - Add New Forensics view Daily schedule
    When UI "Create" Forensics With Name "Daily Report"
      | Schedule              | Run Every:Daily,On Time:10:00 AM |
    When UI Click Button "Edit Forensics" with value "Daily Report"
    Then UI Click Button "Schedule Tab"
    Then UI Validate the attribute "Class" Of Label "Schedule Run Every" With Params "Daily" is "CONTAINS" to "selected"
    Then UI Validate Text field "Scheduling At Time" CONTAINS "10:00"
    Then UI Click Button "Close" with value ""
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Navigate to "AMS Forensics" page via homepage


  @SID_4
  Scenario: VRM - Add New Forensics Report schedule (current time + 2 min)-once
    When UI "Create" Forensics With Name "Once Report"
      | Time Definitions.Date | Quick:This Month            |
      | Schedule              | Run Every:Once, On Time:+2m |

  @SID_5
  Scenario: VRM - Add New Forensics Report schedule (current time + 2 min)-daily
    When UI "Create" Forensics With Name "daily Forensic"
      | Time Definitions.Date | Quick:This Month             |
      | Schedule              | Run Every:Daily, On Time:+2m |



  @SID_6
  Scenario: VRM - Add New Forensics Report schedule (Any day at 19:30) - weekly
    When UI "Create" Forensics With Name "weekly_Forensic"
      | Time Definitions.Date | Quick:This Month              |
      | Schedule              | Run Every:Weekly, On Time:07:30 PM |
  @SID_7
  Scenario: VRM - Validate weekly any day schedule
    Then CLI Run linux Command "/get_scheduled_forensic_value.sh weekly_Forensic" on "ROOT_SERVER_CLI" and validate result EQUALS "0 30 19 ? * *"

  @SID_8
  Scenario: VRM - Edit weekly schedule Wednesday
    Then UI Click Button "Edit Forensics" with value "weekly_Forensic"
    Then UI Click Button "Schedule Tab"
    Then UI Click Button "Scheduling Week Day" with value "WED"
    Then UI Click Button "Submit" with value "Submit"

  @SID_9
  Scenario: VRM - Validate weekly Wednesday schedule
    Then CLI Run linux Command "/get_scheduled_forensic_value.sh weekly_Forensic" on "ROOT_SERVER_CLI" and validate result EQUALS "0 30 19 ? * 4"

  @SID_10
  Scenario: VRM - Edit and validate weekly schedule When renaming report
    When UI "Edit" Forensics With Name "weekly_Forensic"
      | Basic Info | Description: Test,forensics name:weekly_Forensic1 |
    Then CLI Run linux Command "/get_scheduled_forensic_value.sh weekly_Forensic1" on "ROOT_SERVER_CLI" and validate result EQUALS "0 30 19 ? * 4"

  @SID_11
  Scenario: VRM - Add New Forensics Report schedule (current time + 2 min) - monthly
    When UI "Create" Forensics With Name "monthly Forensic"
      | Time Definitions.Date | Quick:This Month               |
      | Schedule              | Run Every:Monthly, On Time:+2m |

  @SID_12
  Scenario: VRM Forensic schedule - sleep to let report generation
    And Sleep "240"
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_13
  Scenario: VRM Forensic schedule - validate report once was generated

    Then UI Click Button "My Forensics" with value "Once Report"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Once Report"
    Then UI Click Button "My Forensics" with value "Once Report"

  @SID_14
  Scenario: VRM Forensic schedule - validate report daily was generated
    Then UI Click Button "My Forensics" with value "daily Forensic"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "daily Forensic"
    Then UI Click Button "My Forensics" with value "daily Forensic"


  @SID_15
  Scenario: VRM Forensic schedule - validate report monthly was generated
    Then UI Click Button "My Forensics" with value "monthly Forensic"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "monthly Forensic"
    Then UI Click Button "My Forensics" with value "monthly Forensic"



  @SID_16
  Scenario: Cleanup and check logs
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
