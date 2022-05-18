@TC126291
Feature: EAAF-Ip Lookup
#  @SID_1
#    Scenario: delete data from elastic search
#    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "eaaf-attack-*"
#    Then Sleep "300"

  @TEAA
  @SID_2
  Scenario: login and navigate ERT dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "EAAF Dashboard" page via homePage

  @SID_3
  Scenario: click iplookup and write valide ip
    Given UI Click Button "IP Lookup"
    Then UI Set Text Field "IPlookup search" To "113.172.213.32"
    Then Sleep "5"

    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "VN"
      | columnName     | value       |
      | Country Code   | VN          |
      | Device         | 50.50.100.1 |
      | Policy         | ERT         |
      | Volume (Kbits) | 284         |
      | Packets        | 287.0       |


#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
#      | columnName     | value             |
#      | Country Code   | US                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 854.1120405681431 |
#      | Packets        | 861.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "AT"
#      | columnName     | value             |
#      | Country Code   | AT                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 854.1120405681431 |
#      | Packets        | 861.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "PT"
#      | columnName     | value             |
#      | Country Code   | PT                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 854.1120405681431 |
#      | Packets        | 861.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "NL"
#      | columnName     | value             |
#      | Country Code   | NL                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 851.1360404267907 |
#      | Packets        | 858.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
#      | columnName     | value             |
#      | Country Code   | US                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 851.1360404267907 |
#      | Packets        | 858.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "ID"
#      | columnName     | value              |
#      | Country Code   | ID                 |
#      | Device         | 50.50.100.1        |
#      | Policy         | ERT                |
#      | Volume (Kbits) | 2847.0401352271438 |
#      | Packets        | 2870.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
#      | columnName     | value              |
#      | Country Code   | US                 |
#      | Device         | 50.50.100.1        |
#      | Policy         | ERT                |
#      | Volume (Kbits) | 2847.0401352271438 |
#      | Packets        | 2870.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "AT"
#      | columnName     | value              |
#      | Country Code   | AT                 |
#      | Device         | 50.50.100.1        |
#      | Policy         | ERT                |
#      | Volume (Kbits) | 2847.0401352271438 |
#      | Packets        | 2870.0             |
#
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "PT"
#      | columnName     | value              |
#      | Country Code   | PT                 |
#      | Device         | 50.50.100.1        |
#      | Policy         | ERT                |
#      | Volume (Kbits) | 2847.0401352271438 |
#      | Packets        | 2870.0             |




    Then UI Validate Text field "count results" EQUALS "1 Results"

################################ CSV section to be edited ##################################

  @SID_5
  Scenario: export CSV
    Then CLI Run remote linux Command "rm /home/qa_builder/Downloads/file.csv" on "SLAVE_SERVER_CLI"
    Then CLI Run remote linux Command "rm -r /home/radware/Downloads/TC126291" on "GENERIC_LINUX_SERVER"

    Then Sleep "10"
    Then UI Click Button "Export To CSV"

    Then CLI Run remote linux Command "mkdir -p /home/radware/Downloads/TC126291/" on "GENERIC_LINUX_SERVER"
    Then CLI copy "/home/qa_builder/Downloads/file.csv" from "SLAVE_SERVER_CLI" to "GENERIC_LINUX_SERVER" "/home/radware/Downloads/TC126291/"


  @Salve
  @SID_6
  Scenario: Validate detailed csv iplookup
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv |wc -l" on "SLAVE_SERVER_CLI" and validate result EQUALS "2"

  @SID_13
  Scenario: VRM report validate CSV iplookup headers
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -1|grep "\"deviceIp\",\"trafficPacketCount\",\"countryCode\",\"trafficVolume\",2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "trafficPacketCount"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "countryCode"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "countryCode"


  @SID_14
  Scenario:VRM report validate CSV file iplookup content
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -2|tail -1|grep -oP "\"50.50.100.1\",\"287\",\"VN\",\"284\" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""50.50.100.1""
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "287"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""VN""
    Then CLI Run linux Command "cat /home/radware/Downloads/TC126291/file.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "284"


  @SID_7
  Scenario: click iplookup and write unvalide ip

    Then UI Set Text Field "IPlookup search" To "344.344.344.344"
    Then UI Validate Text field "unvalid ip" EQUALS "IP address not found. Try a different one."