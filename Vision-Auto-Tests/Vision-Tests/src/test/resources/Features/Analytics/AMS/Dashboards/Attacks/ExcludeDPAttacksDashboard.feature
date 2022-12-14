@TC121781
Feature: Exclude DP Attacks Dashboard

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator - ErtFeed_GeoFeed
    Given CLI simulate 1000 attacks of type "ErtFeed_GeoFeed" on SetId "DefensePro_Set_2" with loopDelay 15000 and wait 120 seconds

  @SID_3
  Scenario:  login to vision
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"

  @SID_4
  Scenario: navigate to attacks dashboard
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then UI UnSelect Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    When UI set "Auto Refresh" switch button to "off"
    Given UI Click Button "Accessibility Menu"
    Then UI Select Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    Then UI Click Button "Accessibility Menu"

  @SID_5
  Scenario:  Validate data before Exclude Malicious IP Addresses
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "false"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 1
      | columnName      | value                  |
      | Attack Category | Malicious IP Addresses |

    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
      | columnName      | value       |
      | Attack Category | Geolocation |

  @SID_6
  Scenario:  Validate data after Exclude Malicious IP Addresses
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "true"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
      | columnName      | value       |
      | Attack Category | Geolocation |

  @SID_7
  Scenario: Clean data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_8
  Scenario: Run DP simulator -IP_FEED_Modified
    Given CLI simulate 1000 attacks of type "IP_FEED_Modified" on SetId "DefensePro_Set_2" with loopDelay 15000 and wait 120 seconds

  @SID_9
  Scenario:  navigate to attacks dashboard
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then Sleep "2"

  @SID_10
  Scenario:  Validate data after check Exclude Malicious IP Addresses
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "false"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 627 with offset 2
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "true"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 1 with offset 1

  @SID_11
  Scenario: Run DP simulator - HTTPS
    Given CLI simulate 1000 attacks of type "HTTPS" on SetId "DefensePro_Set_2" with loopDelay 15000 and wait 120 seconds

  @SID_12
  Scenario:  navigate to attack dashboard
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then Sleep "2"

  @SID_13
  Scenario:  Validate data after check Exclude Malicious IP Addresses and only HTTPS appears
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "false"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 629 with offset 2
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "true"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 3 with offset 1
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
      | columnName      | value       |
      | Attack Category | HTTPS Flood |

    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 1
      | columnName      | value       |
      | Attack Category | HTTPS Flood |

  @SID_14
  Scenario:  Cancel "stop auto refresh"
    Then UI UnSelect Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"

  @SID_15
  Scenario: Logout and close browser
    Given UI logout and close browser