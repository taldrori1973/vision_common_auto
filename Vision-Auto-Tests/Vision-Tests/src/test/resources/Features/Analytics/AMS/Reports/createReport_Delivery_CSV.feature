@VRM_Report2 @TC108070

Feature:  Report AMS analytics CSV Validations

  @SID_1
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-reporter_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_REPORTER" is up with timeout "45" minutes
    Given CLI Reset radware password


  @SID_2
  Scenario: Clear Database and old reports on file-system
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "docker exec -it config_kvision-reporter_1 sh -c "rm /usr/local/tomcat/VRM_report*"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    Given Setup email server

  @SID_3
  Scenario: generate two attacks
#   Given CLI simulate 2 attacks of type "rest_anomalies" on "DefensePro" 10 with attack ID
    Given CLI simulate 2 attacks of type "rest_anomalies" on SetId "DefensePro_Set_1" with attack ID
#   Given CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 10 and wait 60 seconds
    Given CLI simulate 1 attacks of type "rest_dos" on SetId "DefensePro_Set_1" and wait 60 seconds


  @SID_4
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    Then UI Set Text Field "Subject Header" To "Alert Notification Message"
    Then UI Set Text Field "From Header" To "Automation system"
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    And UI Navigate to "AMS Reports" page via homePage


  @SID_5
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_6
  Scenario: Create new Report Analytics CSV Delivery
    #Make sure all attacks are at the same time
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.50"}},"script":{"source":"ctx._source.endTime='$(date +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    Given UI "Create" Report With Name "TC108070"
      | Template              | reportType:DefensePro Analytics,Widgets:[ALL], devices:[All], showTable:true |
      | Share      | Email:[Test, Test2],Subject:TC108070 Subject |
      | Format     | Select: CSV                                  |


  @SID_7
  Scenario: Validate delivery card and generate report
    Then UI "Generate" Report With Name "TC108070"
      | timeOut | 120 |

  @SID_8
  Scenario: Validate Report Email received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: TC108070 Subject"" EQUALS "2"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "2"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: Test2@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "2"

  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Copy files contains name "VRM_report_[0-9]+.zip" from container "config_kvision-reporter_1" from path "/usr/local/tomcat" to path "/opt/radware/mgt-server/third-party/tomcat/bin/" with timeout 80
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

    ############################################       Top\ Attacks       ###################################################################################

  @SID_10
  Scenario: VRM report validate CSV file Top\ Attacks number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"


  @SID_11
  Scenario: VRM report validate CSV file Top\ Attacks headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|grep name,ruleName,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_12
  Scenario:VRM report validate CSV file Top\ Attacks content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -3|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,1" | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       ATTACKS BY THREAT CATEGORY       ######################################################################

  @SID_13
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_14
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -1 |grep "name,ruleName,Count,category" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_15
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2 |tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",2,Anomalies" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Anomalies"


    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -4 |tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,1,DOSShield"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -4|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -4|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -4|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSShield"


    ############################################       TOP ATTACK DESTINATION       ###########################################################################

  @SID_16
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"

  @SID_17
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv|head -1 |grep "Country,Address,Count,Percent" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv|head -3 |tail -1|grep -oP "AU,1.1.1.8,1,33.3333" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_19
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv|head -5 |tail -1|grep -oP "Total Count,,3" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_20
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv |tail -1|grep -oP "Total Hits,,3" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       TOP ATTACK SOURCES       ###############################################################################

  @SID_21
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"

  @SID_22
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -1 |grep "Country,Address,Count,Percent" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_23
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -3 |tail -1|grep -oP "US,192.85.1.8,1,33.3333" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_24
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -5 |tail -1|grep -oP "Total Count,,3" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_25
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv |tail -1|grep -oP "Total Hits,,3" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       ATTACK CATEGORIES BY BANDWIDTH       ###################################################################

  @SID_26
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_27
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -1 |grep "category,ruleName,packetBandwidth" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_28
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -2 |tail -1|grep -oP "Anomalies,\"Packet Anomalies\",0"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -3 |tail -1|grep -oP "DOSShield,BDOS,56641"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACK BY MITIGATION ACTION       ####################################################################

  @SID_29
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_30
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -1 |grep "name,actionType,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_31
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2 |tail -1|grep -oP "\"Incorrect IPv4 checksum\",Drop,\"Packet Anomalies\",2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -4 |tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,Drop,BDOS,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACKS BY PROTECTION POLICY       ####################################################################

  @SID_32
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_33
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -1|grep "name,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_34
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"


    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Protection\ Policy-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       CRITICAK ATTACKS BY MITIGATION ACTION      #############################################################

  @SID_35
  Scenario: VRM report validate CSV file CRITICAL ATTACKS BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Critical\ Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_36
  Scenario: VRM report validate CSV file CRITICAL ATTACKS BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Critical\ Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP ALLOWED ATTACKERS      ############################################################################

  @SID_37
  Scenario: VRM report validate CSV file TOP ALLOWED ATTACKERS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Allowed\ Attackers-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    # Changed result to 0 once this template was removed in 4.20

  @SID_38
  Scenario: VRM report validate CSV file TOP ALLOWED ATTACKERS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Allowed\ Attackers-DefensePro\ Analytics.csv|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    # Changed result to 0 once this template was removed in 4.20

      ############################################       Top\ Attacks BY BANDWIDTH      ########################################################################

#  @SID_39
#  Scenario: VRM report validate CSV file Top\ Attacks BY BANDWIDTH number of lines
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Bandwidth.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"
#
#  @SID_40
#  Scenario: VRM report validate CSV file Top\ Attacks BY BANDWIDTH headers
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks\ by\ Bandwidth.csv|head -1|grep "name,ruleName,endTime,packetBandwidth,packetcount" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#
#  @SID_41
#  Scenario: VRM report validate CSV file Top\ Attacks BY BANDWIDTH content
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks\ by\ Bandwidth.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),0,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks\ by\ Bandwidth.csv|head -3|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),56641,58469"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       Top\ Attacks BY PROTOCOL      ########################################################################

  @SID_42
  Scenario: VRM report validate CSV file Top\ Attacks BY PROTOCOL number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks\ by\ Protocol-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_43
  Scenario: VRM report validate CSV file Top\ Attacks BY PROTOCOL headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks\ by\ Protocol-DefensePro\ Analytics.csv|head -1|grep "name,ruleName,protocol,Count" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_44
  Scenario: VRM report validate CSV file Top\ Attacks BY PROTOCOL content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks\ by\ Protocol-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",IP,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks\ by\ Protocol-DefensePro\ Analytics.csv|head -4|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,TCP,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP SCANNERS      ##################################################################################

  @SID_45
  Scenario: VRM report validate CSV file TOP SCANNERS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Scanners-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_46
  Scenario: VRM report validate CSV file TOP SCANNERS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Scanners-DefensePro\ Analytics.csv|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_47
  Scenario: Edit report format - from CSV to PDF
    Given UI "Create" Report With Name "just English characters"
      | Template   | reportType:DefensePro Analytics,Widgets:[ALL], devices:[All], showTable:true |
      | Share      | Email:[Test],Subject:english characters subject,Body:english characters body |

    When UI "Edit" Report With Name "just English characters"
      | Format | Select: PDF |

    Then UI "Validate" Report With Name "just English characters"
      | Template   | reportType:DefensePro Analytics,Widgets:[ALL], devices:[All], showTable:true |
      | Share      | Email:[Test],Subject:english characters subject,Body:english characters body |
      | Format     | Select: PDF                                                                  |


  @SID_48
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
