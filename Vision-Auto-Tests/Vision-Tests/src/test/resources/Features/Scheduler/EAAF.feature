@TC109746 @Functional
Feature: ERT Active Attackers Feed for DP

  @SID_1
  Scenario: Remove MIS Reputation Feed file from Server
    Then CLI Run remote linux Command "rm -f "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json.gz"" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: change reputation_feed.properties to work with MIS
    Then CLI Run remote linux Command "sed -i 's/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp2*/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp/g' /opt/radware/mgt-server/properties/reputation_feed.properties" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Login
    Given UI Login with user "radware" and password "radware"

  @SID_4
  Scenario: Remove EAAF task from table
    When UI Remove All Tasks with tha Value "ERT Active Attackers Feed for DefensePro" at Column "Task Type"

  @SID_5
  Scenario: Schedule ERT Active Attackers Feed for DefensePro task
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI Add Attackers feed task with name "testFeed" interval "3 Hours" destination devices indexes "DefensePro_Set_2" with default params

  @SID_6
  Scenario: Validate MRF File downloaded.
    Then CLI Run linux Command "[ -a "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json.gz" ] && echo "File Found" || echo "File Not Found"" on "ROOT_SERVER_CLI" and validate result CONTAINS "File Found" in any line

  @SID_7
  Scenario: Logout
    Then UI logout and close browser

  @SID_8
  Scenario: Remove MIS Reputation Feed file from Server
    Then CLI Run remote linux Command "rm -f "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json.gz"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f "/opt/radware/storage/reputation-feed/BaselineRepFeed.json"" on "ROOT_SERVER_CLI"

  @SID_9
  Scenario: change reputation_feed.properties to work with MIS
    Then CLI Run remote linux Command "sed -i 's/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp2*/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp/g' /opt/radware/mgt-server/properties/reputation_feed.properties" on "ROOT_SERVER_CLI"

  @SID_10
  Scenario: Remove MIS Reputation Feed file from Server
    Then CLI Run remote linux Command "rm -f "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json.gz"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f "/opt/radware/storage/reputation-feed/BaselineRepFeed.json"" on "ROOT_SERVER_CLI"

  @SID_11
  Scenario: change reputation_feed.properties to work with constant file
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI" with timeOut 90
    Then CLI Run remote linux Command "sed -i 's/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp*/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp2/g' /opt/radware/mgt-server/properties/reputation_feed.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI" with timeOut 120
    Then Sleep "120"

  @SID_12
  Scenario: copy MRF file from genericLinuxServer
    Then CLI copy "/root/BaselineRepFeed.json" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage/reputation-feed/temp"


  @SID_13
  Scenario: Login
    Given UI Login with user "radware" and password "radware"

  @SID_14
  Scenario: Remove EAAF task from table
    When UI Remove All Tasks with tha Value "ERT Active Attackers Feed for DefensePro" at Column "Task Type"

  @SID_15
  Scenario: Clear DP8.18 BlackList
    Then UI Clear blackList from "DefensePro" device with index "DefensePro_Set_2"

  @SID_16
  Scenario: Schedule ERT Active Attackers Feed for DefensePro task
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI Add Attackers feed task with name "testFeedDP8.18" interval "3 Hours" destination devices indexes "DefensePro_Set_2" with default params

  @SID_17
  Scenario: Number of Rows
    Then Sleep "200"
    Then UI Validate "DefensePro" device with index "DefensePro_Set_2" BlackList Number of Rows, contains 0 rows

#  Scenario: validate srcNetwork
#    Then UI Validate "DefensePro" device with index 11 BlackList, contains SrcNetwork:"1552"

  @SID_18
  Scenario: Logout
    Then UI logout and close browser

  Scenario: Login
    Given UI Login with user "radware" and password "radware"

  @SID_14
  Scenario: Remove EAAF task from table
    When UI Remove All Tasks with tha Value "ERT Active Attackers Feed for DefensePro" at Column "Task Type"

  @SID_15
  Scenario: Clear DP8.19 BlackList
    Then UI Clear blackList from "DefensePro" device with index "DefensePro_Set_2"

  @SID_16
  Scenario: Schedule ERT Active Attackers Feed for DefensePro task
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI Add Attackers feed task with name "testFeedDP8.19" interval "3 Hours" destination devices indexes "DefensePro_Set_2" with default params

#  @SID_1validate task succed
#  Scenario: Number of Rows
#    Then Sleep "120"
#    Then UI Validate "DefensePro" device with index 11 BlackList Number of Rows, contains 24000 rows

#  @SID_19
#  Scenario: validate task succed
#    Then Sleep "200"
#    When UI Navigate to "SCHEDULER" page via homePage
#    Then UI validate Vision Table row by keyValue with elementLabel "scheduledTasks" findBy columnName "Name" findBy KeyValue "testFeedDP8.19"
#      | columnName            | value   | isDate |
#      | Last Execution Status | Success | false  |

#  Scenario: validate srcNetwork
#    Then UI Validate "DefensePro" device with index 11 BlackList, contains SrcNetwork:"1552"

  @SID_18
  Scenario: Logout
    Then UI logout and close browser

  @SID_21
  Scenario: Remove MIS Reputation Feed file from Server
    Then CLI Run remote linux Command "rm -f "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json.gz"" on "ROOT_SERVER_CLI"

  @SID_22
  Scenario: change reputation_feed.properties to work with MIS
    Then CLI Run remote linux Command "sed -i 's/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp2*/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp/g' /opt/radware/mgt-server/properties/reputation_feed.properties" on "ROOT_SERVER_CLI"

  @SID_23
  Scenario: Login
    Given UI Login with user "radware" and password "radware"


  @SID_24
  Scenario: Remove EAAF task from table
    When UI Remove All Tasks with tha Value "ERT Active Attackers Feed for DefensePro" at Column "Task Type"

  @SID_25
  Scenario: Schedule ERT Active Attackers Feed for DefensePro task - 12 Hours
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI Add Attackers feed task with name "testFeed" interval "12 Hours" destination devices indexes "DefensePro_Set_2" with default params
#    Then Run command "mysql -prad123 quartz -BNe "select from_unixtime(NEXT_FIRE_TIME/1000) from qrtz_triggers where JOB_NAME like'ERTActiveDDoSFeedTask%';"" and validate task time close to 12
    Then MYSQL Validate The Time by SELECT "from_unixtime(NEXT_FIRE_TIME/1000)" Column FROM "QUARTZ" Schema and "qrtz_triggers" Table WHERE "JOB_NAME like'ERTActiveDDoSFeedTask%'" Close to 12

#    Then CLI Run linux Command "mysql -prad123 quartz -BNe "select REPEAT_INTERVAL from qrtz_simple_triggers where TRIGGER_NAME like 'trigger_ERTActiveDDoSFeedTask%';"" on "ROOT_SERVER_CLI" and validate result EQUALS "43200000"
    #Then MYSQL Validate Single Value by SELECT "REPEAT_INTERVAL" Column FROM "QUARTZ" Schema and "qrtz_simple_triggers" Table WHERE "TRIGGER_NAME like 'trigger_ERTActiveDDoSFeedTask%'" EQUALS 43200000

  @SID_26
  Scenario: Validate MRF File downloaded.
    Then CLI Run linux Command "[ -a "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json.gz" ] && echo "File Found" || echo "File Not Found"" on "ROOT_SERVER_CLI" and validate result CONTAINS "File Found" in any line

  @SID_27
  Scenario: validate task succed
    Then Sleep "100"
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI validate Vision Table row by keyValue with elementLabel "scheduledTasks" findBy columnName "Name" findBy KeyValue "testFeed"
      | columnName            | value   | isDate |
      | Last Execution Status | Success | false  |

  @SID_28
  Scenario: Logout
    Then UI logout and close browser

  @SID_29
  Scenario: Remove MIS Reputation Feed file from Server
    Then CLI Run remote linux Command "rm -f "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json.gz"" on "ROOT_SERVER_CLI"

  @SID_30
  Scenario: change reputation_feed.properties to work with MIS
    Then CLI Run remote linux Command "sed -i 's/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp2*/ert\.reputation\.feed\.temp\.download\.path\=\/opt\/radware\/storage\/reputation-feed\/temp/g' /opt/radware/mgt-server/properties/reputation_feed.properties" on "ROOT_SERVER_CLI"

  @SID_31
  Scenario: Login
    Given UI Login with user "radware" and password "radware"


  @SID_32
  Scenario: Remove EAAF task from table
    When UI Remove All Tasks with tha Value "ERT Active Attackers Feed for DefensePro" at Column "Task Type"

  @SID_33
  Scenario: Schedule ERT Active Attackers Feed for DefensePro task - daily
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI Add Attackers feed task with name "testFeedDaily" interval "Daily" destination devices indexes "DefensePro_Set_2" with default params
#    Then Run command "mysql -prad123 quartz -BNe "select from_unixtime(NEXT_FIRE_TIME/1000) from qrtz_triggers where JOB_NAME like'ERTActiveDDoSFeedTask%';"" and validate task time close to 24
    Then MYSQL Validate The Time by SELECT "from_unixtime(NEXT_FIRE_TIME/1000)" Column FROM "QUARTZ" Schema and "qrtz_triggers" Table WHERE "JOB_NAME like'ERTActiveDDoSFeedTask%'" Close to 24

#    Then CLI Run linux Command "mysql -prad123 quartz -BNe "select REPEAT_INTERVAL from qrtz_simple_triggers where TRIGGER_NAME like 'trigger_ERTActiveDDoSFeedTask%';"" on "ROOT_SERVER_CLI" and validate result EQUALS "86400000"
    #Then MYSQL Validate Single Value by SELECT "REPEAT_INTERVAL" Column FROM "QUARTZ" Schema and "qrtz_simple_triggers" Table WHERE "TRIGGER_NAME like 'trigger_ERTActiveDDoSFeedTask%'" EQUALS 86400000


  @SID_34
  Scenario: Validate MRF File downloaded.
    Then CLI Run linux Command "[ -a "/opt/radware/storage/reputation-feed/temp/BaselineRepFeed.json.gz" ] && echo "File Found" || echo "File Not Found"" on "ROOT_SERVER_CLI" and validate result CONTAINS "File Found" in any line

  @SID_35
  Scenario: validate task success
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI validate Vision Table row by keyValue with elementLabel "scheduledTasks" findBy columnName "Name" findBy KeyValue "testFeedDaily"
      | columnName            | value   | isDate |
      | Last Execution Status | Success | false  |
    When UI Remove All Tasks with tha Value "ERT Active Attackers Feed for DefensePro" at Column "Task Type"
