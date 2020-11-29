@TC117967
Feature: Negative test to validate Error Messages
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Create New Report Empty
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a name for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"


  @SID_3
  Scenario: Create New Report without Templates
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report without templates"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a template for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report without templates"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a template for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report without templates"?"
    Then UI Click Button "No"

  @SID_4
  Scenario: Create New Report with Report Name invalid
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To ","
    Then UI Click Button "Add Template" with value "HTTPS Flood"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Report name contains special characters."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save ","?"
    Then UI Click Button "No"

  @SID_5
  Scenario: Create New Report with Report with more than 50 Widgets
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report with more than 50 Widgets"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "The Report configuration contains too many widgets. A Report can contain no more than 50 widgets. The current configuration contains 60 widgets. Remove at least 10 widgets from the Report configuration and try again."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with more than 50 Widgets"?"
    Then UI Click Button "No"

  @SID_6
  Scenario: Create New Report with invalid Email
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report with invalid Email"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Set Text Field "Email" To "invalidEmail"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "The Share configuration of the Report is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with invalid Email"?"
    Then UI Click Button "No"

  @SID_7
  Scenario: Create New Report without Widgets
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report without Widgets"
    Then UI Click Button "Add Template" with value "HTTPS Flood"
    Then UI Click Button "Delete Widget" with value "HTTPS Flood_Inbound Traffic_0"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a widget for the Report Template."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with an Error share Email To"?"
    Then UI Click Button "No"

  @SID_8
  Scenario: Logout
    Then UI logout and close browser


    #todo when they closed the bug
#  scheduale once error input


