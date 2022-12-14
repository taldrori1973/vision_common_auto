@TC112566
Feature: CLI System AVR

  @SID_1
  Scenario: system avr enable cancel
    When REST Delete ES index "dp-attack-raw*"
    Then CLI Clear vision logs
    Then CLI Run remote linux Command "sed -i 's/sql.persist.allow=.*$/sql.persist.allow=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/collectors.properties" on "ROOT_SERVER_CLI"
    When CLI Operations - Run Radware Session command "system avr enable"
    When CLI Operations - Run Radware Session command "n"

  @SID_2
  Scenario: system avr enable
    When CLI Operations - Run Radware Session command "system avr enable"
    When CLI Operations - Run Radware Session command "y" timeout 200

  @SID_3
  Scenario: system avr enable again
    When CLI Operations - Run Radware Session command "system avr enable"
    Then CLI Operations - Verify that output contains regex ".*The AVR service is already enabled.*"

  @SID_4
  Scenario: verify write to sql enabled
    Given CLI Run linux Command "system avr status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "is running." in any line Retry 250 seconds
    When Sleep "15"
    When CLI Run remote linux Command "vision_ng -e "delete from security_attacks;"" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "vision_ng -e "delete from df_security_attacks;"" on "ROOT_SERVER_CLI"
    When CLI simulate 1 attacks of type "rest_anomalies" on DefensePro_Set_2
    Then CLI Run linux Command "vision -NB -e "select count(*) from avr_security_attacks;"" on "ROOT_SERVER_CLI" and validate result GT "0" Retry 60 seconds

  @SID_5
  Scenario: verify services running
    Then CLI Run linux Command "service avrservice status|head -1|grep "mainengine.exe"|awk '{print$4,$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is running..."
    Then CLI Run linux Command "service avrservice status|tail -1|grep "monitoringengine.exe"|awk '{print$4,$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is running..."

  @SID_6
  Scenario: verify syslog proxy enabled
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "count=1;while [ $count -le 120 ]; do  cat /home/radware/AW_Attacks/AppwallAttackTypes/Injection1 \| netcat " |
      | #visionIP                                                                                                     |
      | " 2215; sleep 1;let "count+=1";done"                                                                          |
    Then CLI Run linux Command "tail -1 /var/avr/diaglogs/monitoringdiag.log |awk -F":" '{print$5}'|awk '{print$1}'" on "ROOT_SERVER_CLI" and validate result GTE "1" Retry 120 seconds
    Then Sleep "15"
    Then CLI Run remote linux Command "tail -20 /var/avr/diaglogs/monitoringdiag.log" on "ROOT_SERVER_CLI"

  @SID_7
  Scenario: system avr disable
    When CLI Operations - Run Radware Session command "system avr disable"
#    Then CLI Operations - Verify that output contains regex "Disabling the APSolute Vision Reporter service requires restarting the APSolute Vision Collector service. Continue? [Y/n]"
    When CLI Operations - Run Radware Session command "y" timeout 200
    Then CLI Operations - Verify that output contains regex ".*Stopping APSolute Vision Collectors Server.*[  OK  ].*"
    Then CLI Operations - Verify that output contains regex ".*Starting APSolute Vision Collectors Server.*[  OK  ].*"
    Then CLI Operations - Verify that output contains regex ".*Stopping Apsolute Vision Reporter Service:.*[  OK  ].*"

  @SID_8
  Scenario: verify write to sql disabled
    Then CLI Run remote linux Command "vision_ng -e "delete from security_attacks;"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "vision -e "delete from bdos_real_time_rate;"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "vision_ng -e "delete from packet_reports;"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "vision -e "delete from dns_real_time_rate;"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "vision_ng -e "delete from http_traf_stats_anomaly;"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "vision -e "delete from traffic_utilizations;"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "vision -e "delete from traffic_utilizations_per_policy;"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "vision_ng -e "delete from df_security_attacks;"" on "ROOT_SERVER_CLI"

    Then CLI simulate 1 attacks of type "rest_bdosdns" on DefensePro_Set_2
    Then CLI simulate 1 attacks of type "rest_traffic_diff_Policy15out" on DefensePro_Set_2
    Then CLI simulate 1 attacks of type "rest_http_server_16.16.16.10" on DefensePro_Set_2
    Then CLI simulate 1 attacks of type "rest_bdos" on DefensePro_Set_2 and wait 40 seconds

    Then CLI Run linux Command "vision -NB -e "select count(*) from avr_security_attacks;"" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "vision -NB -e "select count(*) from bdos_real_time_rate;"" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "vision_ng -NB -e "select count(*) from packet_reports;"" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "vision -NB -e "select count(*) from dns_real_time_rate;"" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "vision_ng -NB -e "select count(*) from http_traf_stats_anomaly;"" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "vision -NB -e "select count(*) from traffic_utilizations;"" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "vision -NB -e "select count(*) from traffic_utilizations_per_policy;"" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run remote linux Command "vision_ng -e "delete from df_security_attacks;"" on "ROOT_SERVER_CLI"
  @SID_9
  Scenario: verify services stopped
    Then CLI Run linux Command "service avrservice status|head -1|grep "mainengine.exe"|awk '{print$2,$3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is stopped"
    Then CLI Run linux Command "service avrservice status|tail -1|grep "monitoringengine.exe"|awk '{print$2,$3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is stopped"
    Then CLI Run remote linux Command "service avrservice status" on "ROOT_SERVER_CLI"

  @SID_10
  Scenario: system avr disable again
    When CLI Operations - Run Radware Session command "system avr disable"
    Then CLI Operations - Verify that output contains regex ".*The APSolute Vision Reporter service is already disabled.*"

  @SID_11
  Scenario: Verify DP insert to ES
    Then Sleep "30"
    Then CLI Run linux Command "curl -s -XGET localhost:9200/_cat/indices/dp-attack-raw* |wc -l" on "ROOT_SERVER_CLI" and validate result GTE "0" Retry 40 seconds
    When REST Delete ES index "dp-attack-raw*"
    Then CLI Run linux Command "curl -s -XGET localhost:9200/_cat/indices/dp-attack-raw* |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 40 seconds
    Then Sleep "30"
    Given CLI Run linux Command "system avr status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "is stopped." in any line Retry 250 seconds
    Then CLI Run linux Command "curl -s -XGET localhost:9200/_cat/indices/dp-attack-raw* |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 40 seconds
    When CLI simulate 1 attacks of type "rest_anomalies" on DefensePro_Set_2 and wait 35 seconds
    Then CLI Run linux Command "curl -s -XGET localhost:9200/_cat/indices/dp-attack-raw* |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1" Retry 120 seconds

  @SID_12
  Scenario: Verify AppWall insert to ES
    When REST Delete ES index "appwall-v2-attack-raw*"
    Then CLI Run linux Command "curl -s -XGET localhost:9200/_cat/indices/appwall-v2-attack-raw* |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/AppwallAttackTypes/Injection1 \| netcat " |
      | #visionIP                                                               |
      | " 2215"                                                                 |
    Then Sleep "60"
    Then CLI Run linux Command "curl -s -XGET localhost:9200/_cat/indices/appwall-v2-attack-raw* |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_13
  Scenario: system avr disable after reboot
    Then CLI Operations - Run Root Session command "reboot"
    Then Sleep "360"
    Then CLI Connect Root
    Then CLI Run linux Command "service avrservice status|head -1|grep "mainengine.exe"|awk '{print$2,$3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is stopped"
    Then CLI Run linux Command "service avrservice status|tail -1|grep "monitoringengine.exe"|awk '{print$2,$3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is stopped"
    Then CLI Connect Root

  @SID_14
  Scenario: system avr enable
    When CLI Operations - Run Radware Session command "system avr enable"
    When CLI Operations - Run Radware Session command "y" timeout 220
    Then CLI Operations - Verify that output contains regex ".*Stopping APSolute Vision Collectors Server.*[  OK  ].*"
    Then CLI Operations - Verify that output contains regex ".*Starting APSolute Vision Collectors Server.*[  OK  ].*"
    Then CLI Operations - Verify that output contains regex ".*Starting Apsolute Vision Reporter Service:.*[  OK  ].*"

  @SID_15
  Scenario: verify write to sql enabled
    Then CLI Run remote linux Command "vision -e "delete from traffic_utilizations;"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "vision -e "delete from traffic_utilizations_per_policy;"" on "ROOT_SERVER_CLI"
    When Sleep "90"
    Then CLI simulate 2 attacks of type "rest_traffic_diff_Policy15out" on DefensePro_Set_2 and wait 30 seconds
    Then CLI Run linux Command "vision -NB -e "select count(*) from traffic_utilizations;"" on "ROOT_SERVER_CLI" and validate result GT "0"
    Then CLI Run linux Command "vision -NB -e "select count(*) from traffic_utilizations_per_policy;"" on "ROOT_SERVER_CLI" and validate result GT "0"

  @SID_16
  Scenario: verify services running
    Then CLI Run linux Command "service avrservice status|head -1|grep "mainengine.exe"|awk '{print$4,$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is running..."
    Then CLI Run linux Command "service avrservice status|tail -1|grep "monitoringengine.exe"|awk '{print$4,$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is running..."

  @SID_17
  Scenario: verify syslog proxy enabled
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/AppwallAttackTypes/Injection1 \| netcat " |
      | #visionIP                                                               |
      | " 2215"                                                                 |
    Then Sleep "60"
    Then CLI Run linux Command "tail -1 /var/avr/diaglogs/monitoringdiag.log |awk -F":" '{print$5}'|awk '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: Cleanup
    Then CLI wait to vision services up for 600 seconds
    * CLI Check if logs contains
      | logType | expression       | isExpected   |
      | TOMCAT  | fatal            | NOT_EXPECTED |
      | TOMCAT  | is not monitored | IGNORE       |






