@TC121706
Feature: WAN Link Status Table

  @SID_1
  Scenario: Login and Navigate to System and Network Dashboard page
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.6.5.0-DD-1.00-10.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.6.5.0-DD-1.00-10.jar" on "ROOT_SERVER_CLI" with timeOut 240
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then UI Login with user "radware" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage

  @SID_2
  Scenario: Go into Link Proof dashboard in second drill
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | LP_simulator_101 |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Text of "LinkProofTab" equal to "LinkProof"
    Then UI Click Button "LinkProofTab"
    Then UI Text of "WAN Link Status Header" equal to "Status"

  @SID_3
  Scenario: Validate The total number of row in table
    Then UI Validate "WAN Link Status Table" Table rows count EQUALS to 9

  @SID_4
  Scenario: Validate WAN Link Status Table table by Status Sorting
    Then UI Validate Table "WAN Link Status Table" is Sorted by
      | columnName | order     | compareMethod   |
      | Status     | Ascending | WAN_LINK_STATUS |


  @SID_5
  Scenario: Validate WAN1 equal to Giora123
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "Giora123"
      | columnName          | value       |
      | Status              | Failed      |
      | WAN Link IP         | 23.23.23.23 |
      | Upload Throughput   | 0 bps       |
      | Download Throughput | 0 bps       |
      | CEC                 | 0           |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "0 bps"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "0 bps"

  @SID_6
  Scenario: Validate WAN2 equal to mansour_1
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "mansour_1"
      | columnName          | value    |
      | Status              | Failed   |
      | WAN Link IP         | 88.8.8.8 |
      | Upload Throughput   | 0 bps    |
      | Download Throughput | 0 bps    |
      | CEC                 | 0        |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "0 bps"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "0 bps"

  @SID_7
  Scenario: Validate WAN3 equal to Prometheus_is_no_team_to_be_in
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "Prometheus_is_no_team_to_be_in"
      | columnName          | value   |
      | Status              | Failed  |
      | WAN Link IP         | 2.2.2.2 |
      | Upload Throughput   | 0 bps   |
      | Download Throughput | 0 bps   |
      | CEC                 | 0       |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "0 bps"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "0 bps"

  @SID_8
  Scenario: Validate WAN4 equal to Ahlam_WAN
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "Ahlam_WAN"
      | columnName  | value   |
      | Status      | Running |
      | WAN Link IP | 7.7.7.7 |
      | CEC         | 5       |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "201.5 Kbps / 1.3 Mbps 5%"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "3.4 Mbps / 3.1 Mbps 12%"

  @SID_9
  Scenario: Validate WAN5 equal to Maha_Wan
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "Maha_Wan"
      | columnName  | value   |
      | Status      | Running |
      | WAN Link IP | 3.3.3.3 |
      | CEC         | 4       |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "3 Mbps / 12 Mbps 25%"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "20 Kbps / 60 Kbps 33%"

  @SID_10
  Scenario: Validate WAN6 equal to EdiWanLinks
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "EdiWanLinks"
      | columnName  | value   |
      | Status      | Running |
      | WAN Link IP | 4.4.4.4 |
      | CEC         | 5       |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "201.5 Kbps / 1 Mbps 2%"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "3.4 Mbps / 3.2 Mbps 12%"

  @SID_11
  Scenario: Validate WAN7 equal to Radware1
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "Radware1"
      | columnName  | value       |
      | Status      | Running     |
      | WAN Link IP | 77.77.77.77 |
      | CEC         | 4           |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "6 Mbps / 12 Mbps 50%"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "31 Kbps / 200 Kbps 30%"

  @SID_12
  Scenario: Validate WAN8 equal to w1
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "w1"
      | columnName  | value   |
      | Status      | Running |
      | WAN Link IP | 1.1.1.1 |
      | CEC         | 2       |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "201.5 Kbps / 1 Mbps 2%"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "3.4 Mbps / 3 Mbps 12%"

  @SID_13
  Scenario: Validate WAN8 equal to w2
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "w2"
      | columnName          | value      |
      | Status              | Running    |
      | WAN Link IP         | 2.1.1.1    |
      | Upload Throughput   | 233.5 Kbps |
      | Download Throughput | 3.7 Mbps   |
      | CEC                 | 1          |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "233.5 Kbps"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "3.7 Mbps"

  @SID_14
  Scenario: Logout
    Then UI logout and close browser