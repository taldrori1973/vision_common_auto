@TC122738
Feature: Report introduction and executive summary
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given Setup email server
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    Then UI Set Text Field "Subject Header" To "Alert Notification Message"
    Then UI Set Text Field "From Header" To "Automation system"
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    And UI Navigate to "AMS Reports" page via homePage

  @SID_3
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_4
  Scenario: create new Report intro_executive summary
    Given UI "Create" Report With Name "Report intro_executive summary"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                        |
      | Format           | Select: PDF                                                                                                                                            |
      | ExecutiveSummary | SummaryBody: Automation test, Title: false, Bold:false, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
      | Share            | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                                    |
    Then UI "Validate" Report With Name "Report intro_executive summary"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                        |
      | Format           | Select: PDF                                                                                                                                            |
      | ExecutiveSummary | SummaryBody: Automation test, Title: false, Bold:false, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
      | Share            | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                                    |

    Then UI "Generate" Report With Name "Report intro_executive summary"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"

    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf"" EQUALS "1"
    Given Clear email history for user "setup"

  @SID_5
  Scenario: Edit HTML Format new Report intro_executive summary
    Given UI "Edit" Report With Name "Report intro_executive summary"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "Report intro_executive summary"
      | Format | Select: HTML |

    Then UI "Generate" Report With Name "Report intro_executive summary"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"

    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).html"" EQUALS "1"
    Given Clear email history for user "setup"

  @SID_6
  Scenario: Edit csv Format new Report intro_executive summary
    Given UI "Edit" Report With Name "Report intro_executive summary"
      | Format | Select: CSV |
    Then UI "Validate" Report With Name "Report intro_executive summary"
      | Format | Select: CSV |

    Then UI "Generate" Report With Name "Report intro_executive summary"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary_0"

    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "1"
    Given Clear email history for user "setup"
    Then UI Delete Report With Name "Report intro_executive summary"

  @SID_7
  Scenario: create new Report intro_executive summary1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary1"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format           | Select: PDF                                                                                                                                           |
      | ExecutiveSummary | SummaryBody: Automation test, Title: false, Bold:false, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary1"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format           | Select: PDF                                                                                                                                           |
      | ExecutiveSummary | SummaryBody: Automation test, Title: false, Bold:false, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Generate" Report With Name "Report intro_executive summary1"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary1_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary1"

  @SID_8
  Scenario: create new Report intro_executive summary2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary2"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                      |
      | Format           | Select: PDF                                                                                                                                          |
      | ExecutiveSummary | SummaryBody: Automation test, Title: false, Bold:true, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary2"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                      |
      | Format           | Select: PDF                                                                                                                                          |
      | ExecutiveSummary | SummaryBody: Automation test, Title: false, Bold:true, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Generate" Report With Name "Report intro_executive summary2"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary2_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary2"

  @SID_9
  Scenario: create new Report intro_executive summary3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary3"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                      |
      | Format           | Select: PDF                                                                                                                                          |
      | ExecutiveSummary | SummaryBody: Automation test, Title: true, Bold:false, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary3"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                      |
      | Format           | Select: PDF                                                                                                                                          |
      | ExecutiveSummary | SummaryBody: Automation test, Title: true, Bold:false, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Generate" Report With Name "Report intro_executive summary3"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary3_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary3"

  @SID_10
  Scenario: create new Report intro_executive summary4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary4"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format           | Select: PDF                                                                                                                                           |
      | ExecutiveSummary | SummaryBody: Automation test, Title: true, Bold:false, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary4"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format           | Select: PDF                                                                                                                                           |
      | ExecutiveSummary | SummaryBody: Automation test, Title: true, Bold:false, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Generate" Report With Name "Report intro_executive summary4"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary4_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary4"

  @SID_11
  Scenario: create new Report intro_executive summary5
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary5"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                      |
      | Format           | Select: PDF                                                                                                                                          |
      | ExecutiveSummary | SummaryBody: Automation test, Title: true, Bold:true, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary5"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                      |
      | Format           | Select: PDF                                                                                                                                          |
      | ExecutiveSummary | SummaryBody: Automation test, Title: true, Bold:true, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Generate" Report With Name "Report intro_executive summary5"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary5_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary5"

  @SID_12
  Scenario: create new Report intro_executive summary6
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary6"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format           | Select: PDF                                                                                                                                           |
      | ExecutiveSummary | SummaryBody: Automation test, Title: false, Bold:true, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary6"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format           | Select: PDF                                                                                                                                           |
      | ExecutiveSummary | SummaryBody: Automation test, Title: false, Bold:true, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Generate" Report With Name "Report intro_executive summary6"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary6_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary6"

  @SID_13
  Scenario: create new Report intro_executive summary7
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary7"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                     |
      | Format           | Select: PDF                                                                                                                                         |
      | ExecutiveSummary | SummaryBody: Automation test, Title: true, Bold:true, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary7"
      | Template-1       | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                     |
      | Format           | Select: PDF                                                                                                                                         |
      | ExecutiveSummary | SummaryBody: Automation test, Title: true, Bold:true, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Generate" Report With Name "Report intro_executive summary7"
      | timeOut | 60 |
    Then UI Click Button "Log Preview" with value "Report intro_executive summary7_0"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary7"

  @SID_14
  Scenario: Logout
    Then UI logout and close browser