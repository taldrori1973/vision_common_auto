@ADC_Report @TC105967

Feature: DPM - Design Report Wizard

  @SID_1
  Scenario: Login and navigate to the Reports WizardRamat HaHayal, Tel Aviv-Yafo
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "ADC Reports" page via homePage

  @SID_2
  Scenario: Design the Report - delete all widgets and add one widget
    Given UI "Create" Report With Name "DesignADC"
      | Template | reportType:Application , Widgets:[Requests per Second] ,Applications:[Rejith_#convertIpToHexa(Alteon_Sim_Set_1);:80] |
      | Format   | Select: PDF                                                                                                          |

    Then UI "Validate" Report With Name "DesignADC"
      | Template | reportType:Application , Widgets:[Requests per Second] ,Applications:[Rejith_#convertIpToHexa(Alteon_Sim_Set_1);:80] |
      | Format   | Select: PDF                                                                                                          |
    Then UI "Generate" Report With Name "DesignADC"
      | timeOut | 60 |

  @SID_3
  Scenario: Design the Report - edit and delete the top widget
    Given UI "Create" Report With Name "TopWidgetsReport"
      | Template | reportType:Application , Widgets:[End-to-End Time,Requests per Second] ,Applications:[Rejith_#convertIpToHexa(Alteon_Sim_Set_1);:80] |
      | Format   | Select: CSV                                                                                                                          |
    Then UI "Validate" Report With Name "TopWidgetsReport"
      | Template | reportType:Application , Widgets:[End-to-End Time,Requests per Second] ,Applications:[Rejith_#convertIpToHexa(Alteon_Sim_Set_1);:80] |
      | Format   | Select: CSV                                                                                                                          |
    Then UI "Generate" Report With Name "TopWidgetsReport"
      | timeOut | 60 |

##    When UI Click Button "Expand" with value "TopWidgetsReport"
##    When UI Click Button "Generate Now" with value "TopWidgetsReport"
##    When Sleep "60"
#    Then UI Generate and Validate Report With Name "TopWidgetsReport" with Timeout of 300 Seconds
#    When UI Click Button "Log Preview" with value "TopWidgetsReport"
##    Then UI Validate Element Existence By Label "Widget found" if Exists "true" with value "Table-1"
#    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "TopWidgetsReport"

#
#  @SID_4
#  Scenario: Design the Report - Change position for widget
#    Given UI "Create" DPMReport With Name "changePosition"
#      | reportType | Virtual Service Report   |
#      | Design     | Position:Table,X:0,Y:460 |

  @SID_4
  Scenario: Design the Report - edit and delete the top widget
    Given UI "Create" Report With Name "NetworkReport"
      | Template | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[#getSUTValue(setID:Alteon_Sim_Set_0);] |
      | Format   | Select: CSV                                                                                                                |
    Then UI "Validate" Report With Name "NetworkReport"
      | Template | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[#getSUTValue(setID:Alteon_Sim_Set_0);] |
      | Format   | Select: CSV                                                                                                                |
    Then UI "Generate" Report With Name "TopWidgetsReport"
      | timeOut | 60 |

#
  @SID_5
  Scenario: Cleanup
    Then UI Delete Report With Name "DesignADC"
    Then UI Delete Report With Name "TopWidgetsReport"
    Then UI Delete Report With Name "NetworkReport"
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |

