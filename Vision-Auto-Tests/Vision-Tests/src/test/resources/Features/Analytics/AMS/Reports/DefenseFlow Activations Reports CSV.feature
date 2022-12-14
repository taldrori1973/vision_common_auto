@TC113494
Feature: DefenseFlow Activations Reports CSV

  @SID_1
  Scenario: revert DefenseFlow to snapshot
    Then Revert DefenseFlow to snapshot
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Start Attack PO_101
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 1087000000                              |
      | $.attackVolume.bytesPerSecond        | 13921400000                             |
      | $.protectedObjectName                | "PO_101"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a102" |
      | $.networksDetails.networks[0].ip     | "70.71.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.71.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_3
  Scenario: Start Attack PO_102
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 2087000000                              |
      | $.attackVolume.bytesPerSecond        | 23921400000                             |
      | $.protectedObjectName                | "PO_102"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a102" |
      | $.networksDetails.networks[0].ip     | "70.72.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.72.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_4
  Scenario: Start Attack PO_103
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 3087000000                              |
      | $.attackVolume.bytesPerSecond        | 33921400000                             |
      | $.protectedObjectName                | "PO_103"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a103" |
      | $.networksDetails.networks[0].ip     | "70.73.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.73.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_5
  Scenario: Start Attack PO_104
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 4087000000                              |
      | $.attackVolume.bytesPerSecond        | 43921400000                             |
      | $.protectedObjectName                | "PO_104"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a104" |
      | $.networksDetails.networks[0].ip     | "70.74.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.74.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_6
  Scenario: Start Attack PO_105
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 5087000000                              |
      | $.attackVolume.bytesPerSecond        | 53921400000                             |
      | $.protectedObjectName                | "PO_105"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a105" |
      | $.networksDetails.networks[0].ip     | "70.75.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.75.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_7
  Scenario: Start Attack PO_106
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 6087000000                              |
      | $.attackVolume.bytesPerSecond        | 63921400000                             |
      | $.protectedObjectName                | "PO_106"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a106" |
      | $.networksDetails.networks[0].ip     | "70.76.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.76.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_8
  Scenario: Start Attack PO_107
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 7087000000                              |
      | $.attackVolume.bytesPerSecond        | 73921400000                             |
      | $.protectedObjectName                | "PO_107"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a107" |
      | $.networksDetails.networks[0].ip     | "70.77.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.77.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_9
  Scenario: Start Attack PO_108
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 8087000000                              |
      | $.attackVolume.bytesPerSecond        | 83921400000                             |
      | $.protectedObjectName                | "PO_108"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a108" |
      | $.networksDetails.networks[0].ip     | "70.78.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.78.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_10
  Scenario: Start Attack PO_109
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 9087000000                              |
      | $.attackVolume.bytesPerSecond        | 93921400000                             |
      | $.protectedObjectName                | "PO_109"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a109" |
      | $.networksDetails.networks[0].ip     | "70.79.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.79.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_11
  Scenario: Start Attack PO_111
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 11087000000                             |
      | $.attackVolume.bytesPerSecond        | 113921400000                            |
      | $.protectedObjectName                | "PO_111"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a111" |
      | $.networksDetails.networks[0].ip     | "80.71.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.71.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_12
  Scenario: Start Attack PO_112
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 12087000000                             |
      | $.attackVolume.bytesPerSecond        | 123921400000                            |
      | $.protectedObjectName                | "PO_112"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a112" |
      | $.networksDetails.networks[0].ip     | "80.72.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.72.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_13
  Scenario: Start Attack PO_113
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 13087000000                             |
      | $.attackVolume.bytesPerSecond        | 133921400000                            |
      | $.protectedObjectName                | "PO_113"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a113" |
      | $.networksDetails.networks[0].ip     | "80.73.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.73.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_14
  Scenario: Start Attack PO_114
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 14087000000                             |
      | $.attackVolume.bytesPerSecond        | 143921400000                            |
      | $.protectedObjectName                | "PO_114"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a114" |
      | $.networksDetails.networks[0].ip     | "80.74.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.74.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_15
  Scenario: Start Attack PO_115
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 15087000000                             |
      | $.attackVolume.bytesPerSecond        | 153921400000                            |
      | $.protectedObjectName                | "PO_115"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a115" |
      | $.networksDetails.networks[0].ip     | "80.75.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.75.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_16
  Scenario: waiting to fetch Data from DefenseFlow
    Then Sleep "300"

  @SID_17
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-reporter_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_REPORTER" is up with timeout "45" minutes

  @SID_18
  Scenario: Clear data
    Given CLI Reset radware password
#    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "docker exec -it config_kvision-reporter_1 sh -c \"rm /usr/local/tomcat/VRM_report*\"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    * CLI Clear vision logs


  @SID_19
  Scenario:Login
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "radware" and password "radware"


  @SID_20
  Scenario: Navigate to AMS report
    And UI Navigate to "AMS Reports" page via homePage

  @SID_21
  Scenario: Create DefenseFlow report
    Given UI "Create" Report With Name "DFCSV"
      | Template | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Duration,Top 10 Activations by Attack Rate (Gbps),Top 10 Activations by Attack Rate (Mpps),DDoS Attack Activations per Period,DDoS Peak Attack per Period], Protected Objects:[All] |
      | Format   | Select: CSV                                                                                                                                                                                                                                         |


  @SID_22
  Scenario: Generate Report
    Then UI Click Button "My Report" with value "DFCSV"
    Then UI Click Button "Generate Report Manually" with value "DFCSV"
    Then Sleep "65"

  @SID_23
  Scenario: VRM report unzip local CSV file
    Then CLI Copy files contains name "VRM_report_*.zip" from container "config_kvision-reporter_1" from path "/usr/local/tomcat" to path "/opt/radware/mgt-server/third-party/tomcat/bin/"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_24
  Scenario: VRM report validate CSV file DDoS_Attack Activations per Selected Period.csv
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/DDoS Attack Activations per Period-DefenseFlow Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/DDoS Attack Activations per Period-DefenseFlow Analytics.csv"|head -1|tail -1|grep updateTime,distinct_count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/DDoS Attack Activations per Period-DefenseFlow Analytics.csv"|head -2|tail -1|grep 14|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_25
  Scenario: VRM report validate CSV file DDoS_Peak Attack per Selected Period
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/DDoS Peak Attack per Period-DefenseFlow Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/DDoS Peak Attack per Period-DefenseFlow Analytics.csv"|head -1|tail -1|grep maxBandwidthBps,updateTime,activationId,protectedObjectName,destinationNetwork|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/DDoS Peak Attack per Period-DefenseFlow Analytics.csv"|head -2|tail -1|grep 1231371200000,.*,16,PO_115,80.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_26
  Scenario: VRM report validate CSV file Top_10 Attacks by Duration
    Then CLI Run linux Command " cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Duration-DefenseFlow Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Duration-DefenseFlow Analytics.csv"|head -1|tail -1|grep duration,distinct_count,activationId,protectedObjectName,destinationNetwork|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_27
  Scenario: VRM report validate CSV file Top_10 Attacks by Rate Gbps
    Then CLI Run linux Command " cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -1|tail -1|grep maxBandwidthBps,distinct_count,activationId,protectedObjectName,destinationNetwork|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -2|tail -1|grep 1231371200000,1,16,PO_115,80.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -3|tail -1|grep 1151371200000,1,15,PO_114,80.74.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -4|tail -1|grep 1071371200000,1,14,PO_113,80.73.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -5|tail -1|grep 991371200000,1,13,PO_112,80.72.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -6|tail -1|grep 911371200000,1,12,PO_111,80.71.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -7|tail -1|grep 751371200000,1,11,PO_109,70.79.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -8|tail -1|grep 671371200000,1,10,PO_108,70.78.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -9|tail -1|grep 591371200000,1,9,PO_107,70.77.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -10|tail -1|grep 511371200000,1,8,PO_106,70.76.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Gbps)-DefenseFlow Analytics.csv"|head -11|tail -1|grep 431371200000,1,7,PO_105,70.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_28
  Scenario: VRM report validate CSV file Top 10 Activations by Attack Rate (Mpps)
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -1|tail -1|grep distinct_count,maxPacketRatePps,activationId,protectedObjectName,destinationNetwork|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -2|tail -1|grep 1,15087000000,16,PO_115,80.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -3|tail -1|grep 1,14087000000,15,PO_114,80.74.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -4|tail -1|grep 1,13087000000,14,PO_113,80.73.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -5|tail -1|grep 1,12087000000,13,PO_112,80.72.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -6|tail -1|grep 1,11087000000,12,PO_111,80.71.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -7|tail -1|grep 1,9087000000,11,PO_109,70.79.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -8|tail -1|grep 1,8087000000,10,PO_108,70.78.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -9|tail -1|grep 1,7087000000,9,PO_107,70.77.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -10|tail -1|grep 1,6087000000,8,PO_106,70.76.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top 10 Activations by Attack Rate (Mpps)-DefenseFlow Analytics.csv"|head -11|tail -1|grep 1,5087000000,7,PO_105,70.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  @SID_30
  Scenario: Cleanup
    Then UI Delete Report With Name "DFCSV"
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |