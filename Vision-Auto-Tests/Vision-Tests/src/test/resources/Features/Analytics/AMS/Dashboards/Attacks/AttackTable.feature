@TC114832
Feature: Attacks Table

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-attack*"
    * REST Delete ES index "dp-tr*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on SetId "DefensePro_Set_2" with loopDelay 15000
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on SetId "DefensePro_Set_1" with loopDelay 15000
    Given CLI simulate 1 attacks of type "VRM_attacks" on SetId "DefensePro_Set_2"
    Given CLI simulate 1 attacks of type "VRM_attacks" on SetId "DefensePro_Set_1" and wait 230 seconds

    When CLI Run remote linux Command "^C" on "ROOT_SERVER_CLI"
    Then Sleep "10"
    When CLI Run remote linux Command "curl -XPOST -H "Content-type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.startTime='$(date -d \"-2 hour\" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    When CLI Run remote linux Command "curl -XPOST -H "Content-type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST -H "Content-type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST -H "Content-type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST -H "Content-type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"

    When CLI Run remote linux Command "curl -XPOST -H "Content-type:application/json" localhost:9200/dp-traffic-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.51"}},"script":{"source":"ctx._source.timeStamp='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST -H "Content-type:application/json" localhost:9200/dp-traffic-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.51"}},"script":{"source":"ctx._source.timeStamp='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST -H "Content-type:application/json" localhost:9200/dp-traffic-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.51"}},"script":{"source":"ctx._source.timeStamp='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"


  @SID_3
  Scenario:  login
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request??"vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Attacks" page via homePage

  @SID_4
  Scenario: validate the table count
    Then UI Validate the attribute "aria-checked" Of Label "Auto Refresh" With Params "" is "EQUALS" to "true"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 14
    When UI set "Auto Refresh" switch button to "off"
    Given UI Click Button "Accessibility Menu"
    Then UI Select Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    Then UI Click Button "Accessibility Menu"

  @SID_5
  Scenario: validate scope selection with table
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       |          |
#    Then UI Validate "Attacks Table" Table rows count GTE to 12
#    Then UI Validate "Attacks Table" Table rows count LTE to 13
    Then UI Validate "Attacks Table" Table rows count EQUALS to 0

    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_2 |       |          |
    Then UI Validate search in table "Attacks Table" in searchLabel "tableSearch" with text "ACL"
      | columnName  | Value               |
      | Attack Name | Black List          |
      | Attack Name | TCP Mid Flow packet |
    Then UI Validate "Attacks Table" Table rows count GTE to 6
    Then UI Validate "Attacks Table" Table rows count LTE to 8

  @SID_6
  Scenario: validate all the data
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId | ports | policies |

    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    When UI Validate the attribute "id" Of Label "Attacks Table Total Items" With Params "35" is "EQUALS" to "attacksTableCount"


  @SID_7
  Scenario: validate sampleData
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "Black_IPV6"
    Then Sleep "3"
    Then UI Click Button "Auto Refresh"
    Then Sleep "6"
    Then UI Click Button "Sample Data Button"
    Then Sleep "3"
    Then UI Validate "SampleDataTable" Table rows count GTE to 2
    Then UI Click Button by Class "anticon anticon-close ant-modal-close-icon"
#    Then UI Click Button "closeTable"


  @SID_8
  Scenario: validate the frames1
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Navigate to "DefensePro Attacks" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    Then Sleep "3"
    Then UI Select Time From: 0 To: 10 Time, in Line Chart data "Attacks Dashboard Traffic Widget" with timeFormat "yyyy-MM-dd'T'HH:mm:ssXXX"
    Then UI Validate "Attacks Table" Table rows count GT to 6

  @SID_9
  Scenario: Validate downloaded capture file
    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
#    Then Delete downloaded file with name "attack_7839-1402580209_packets.cap"
#    When UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Destination Ports" findBy cellValue "1025"
#    And UI Click Button "PCAP"
#    Then Sleep "3"
#    Then Validate downloaded file size with name "attack_7839-1402580209_packets.pcap" equal to 304
#    Then Delete downloaded file with name "attack_7839-1402580209_packets.cap"

  @SID_10
  Scenario: validate Auto refresh
    Given UI Click Button "Accessibility Menu"
    Then UI UnSelect Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    Then UI Click Button "Accessibility Menu"
    Then Sleep "30"
    And UI Click Button "Auto Refresh" with value ""
    Then UI Validate the attribute "aria-checked" Of Label "Auto Refresh" With Params "" is "EQUALS" to "false"
    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
#    Then UI Validate the attribute "aria-checked" Of Label "Auto Refresh" With Params "" is "EQUALS" to "true"

    And UI logout and close browser



