@TC106773
Feature: ADC dashboard Current Totals Widget
# pre-requisites: simulator that will include 30 ports and will contain fields with various types of data units. e.g. K, M, G, T

  @SID_1
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_2
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then Sleep "120"

  @SID_3
  Scenario: Login and go to ADC device network
    Then REST Login with user "sys_admin" and password "radware"
#    Then REST Vision Install License Request "vision-reporting-module-ADC"

    Then UI Login with user "sys_admin" and password "radware"
    Then REST Add device with SetId "Alteon_Set_50.50.101.31" into site "Alteons_for_DPM-Fakes"
    Then REST Add device with SetId "Alteon_Set_50.50.101.32" into site "Alteons_for_DPM-Fakes"
    Then UI Wait For Device To Show Up In The Topology Tree "Alteon_Set_50.50.101.31" with timeout 300 seconds
    Then UI Wait For Device To Show Up In The Topology Tree "Alteon_Set_50.50.101.32" with timeout 300 seconds


    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.31"
    Then UI Click Button "NetworkTab"
    * Sleep "180"
    When Browser Refresh Page
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.31"
    Then UI Click Button "NetworkTab"

  @SID_4
  Scenario: Validation: data correctness and exact 1 Kbps presentation
    Then UI Validate Text field "PortsThrouputTotal_transmit" EQUALS "1"
    Then UI Validate Text field "PortsThrouputTotal_transmit_unit" EQUALS "K"

  @SID_5
  Scenario: Validation: data correctness and less than 1 Kbps presentation
    Then UI Validate Text field "PortsThrouputTotal_received" EQUALS "999"
    Then UI Validate Element Existence By Label "PortsThrouputTotal_received_unit" if Exists "false"

  @SID_6
  Scenario: Validation: data correctness and exact 1 Mbps presentation
    Then UI Validate Text field "PortsPPSTotal_transmit" EQUALS "1"
    Then UI Validate Text field "PortsPPSTotal_transmit_unit" EQUALS "M"

  @SID_7
  Scenario: Validation: data correctness and less than 1 Mbps presentation
    Then UI Validate Text field "PortsPPSTotal_received" EQUALS "999.9"
    Then UI Validate Text field "PortsPPSTotal_received_unit" EQUALS "K"

  @SID_8
  Scenario: Validation: data correctness and exact 1 Gbps presentation
    When UI Navigate to "VISION SETTINGS" page via homePage
    Then UI logout and close browser
    Then UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "Application Dashboard" page via homePage
    When UI Navigate to "VISION SETTINGS" page via homePage
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.32"
    Then UI Click Button "NetworkTab"

    Then UI Validate Text field "PortsThrouputTotal_transmit" EQUALS "1"
    Then UI Validate Text field "PortsThrouputTotal_transmit_unit" EQUALS "G"

  @SID_9
  Scenario: Validation: data correctness and less than 1 Gbps presentation
    Then UI Validate Text field "PortsThrouputTotal_received" EQUALS "999.9"
    Then UI Validate Text field "PortsThrouputTotal_received_unit" EQUALS "M"

  @SID_10
  Scenario: Validation: data correctness and less than 1 Tbps presentation
    Then UI Validate Text field "PortsPPSTotal_transmit" EQUALS "999.8"
    Then UI Validate Text field "PortsPPSTotal_transmit_unit" EQUALS "G"

  @SID_11
  Scenario: CleanUp
    Then REST Delete Device By IP "50.50.101.31"
    Then REST Delete Device By IP "50.50.101.32"
    Then UI logout and close browser