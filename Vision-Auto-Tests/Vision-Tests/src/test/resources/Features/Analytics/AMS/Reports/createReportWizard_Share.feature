Feature:  Report Delivery Wizard

  @SID_1
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720

  @SID_2
  Scenario: Clear Database and old reports on file-system
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: generate two attacks
    Given CLI simulate 2 attacks of type "rest_anomalies" on SetId "DefensePro_set_1" with attack ID
    Given CLI simulate 1 attacks of type "rest_dos" on SetId "DefensePro_set_1"

  @SID_4
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
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
    Then CLI Run remote linux "root" Command "echo "cleared" $(date) > /var/spool/mail/radware" on "genericLinuxServer"
    Then CLI Run remote linux "root" Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "genericLinuxServer"

  @SID_6
  Scenario: new Report Delivery
    Given UI "Create" Report With Name "Delivery_Test_report"
      | reportType | DefensePro Analytics Dashboard                                                            |
      | Share      | Email:[automation.vision1@radware.com, also@report.local],Subject:report delivery Subject |

  @SID_7
  Scenario: edit delivery card
    Given UI "Edit" Report With Name "Delivery_Test_report"
      | Format | CSV |
    And UI Click Button "Views.Expand" with value "Delivery_Test_report"
    And UI Click Button "Generate Now" with value "Delivery_Test_report"
    And Sleep "150"


  @SID_8
  Scenario: Validate Report Email recieved content
    Then CLI Run remote linux "root" Command "cat /var/spool/mail/reportuser > /tmp/reportdelivery.log" on "genericLinuxServer"
    Then CLI Run remote "root" Command "cat /var/spool/mail/reportuser|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject" |wc -l" on "genericLinuxServer" and validate result EQUALS "1"
    Then CLI Run remote "root" Command "cat /var/spool/mail/radware|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject" |wc -l" on "genericLinuxServer" and validate result EQUALS "1"

    Then CLI Run remote "root" Command "grep "From: APSolute Vision <qa_test@Radware.com>" /var/spool/mail/reportuser |wc -l" on "genericLinuxServer" and validate result EQUALS "1"
    Then CLI Run remote "root" Command "grep "From: APSolute Vision <qa_test@Radware.com>" /var/spool/mail/radware |wc -l" on "genericLinuxServer" and validate result EQUALS "1"

    Then CLI Run remote "root" Command "grep "X-Original-To: also@report.local" /var/spool/mail/reportuser |wc -l" on "genericLinuxServer" and validate result EQUALS "1"
    Then CLI Run remote "root" Command "grep "X-Original-To: automation.vision1@radware.com" /var/spool/mail/radware |wc -l" on "genericLinuxServer" and validate result EQUALS "1"

    Then CLI Run remote "root" Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip" /var/spool/mail/reportuser | wc -l" on "genericLinuxServer" and validate result EQUALS "1"
    Then CLI Run remote "root" Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip" /var/spool/mail/radware | wc -l" on "genericLinuxServer" and validate result EQUALS "1"

  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

    ############################################       TOP ATTACKS       ###################################################################################

  @SID_10
  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_11
  Scenario: VRM report validate CSV file TOP ATTACKS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|grep name,ruleName,Count |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_12
  Scenario:VRM report validate CSV file TOP ATTACKS content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",\"2\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -3|tail -1|grep -oP "\"DOSS-Anomaly-TCP-SYN-RST\",\"BDOS\",\"1\"" | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       ATTACKS BY THREAT CATEGORY       ######################################################################

  @SID_13
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By\ Threat\ Category.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_14
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By\ Threat\ Category.csv|head -1 |grep "name,ruleName,Count,endTime,category" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_15
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By\ Threat\ Category.csv|head -2 |tail -1|grep -oP "172.16.22.50,N/A,\"Incorrect IPv4 checksum\",\"Packet Anomalies\",Low,(\d{13}),2,Anomalies" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By\ Threat\ Category.csv|head -4 |tail -1|grep -oP "172.16.22.50,N/A,DOSS-Anomaly-TCP-SYN-RST,BDOS,Low,(\d{13}),1,DOSShield"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       TOP ATTACK DESTINATION       ###########################################################################

  @SID_16
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Destination.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_17
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Destination.csv"|head -1 |grep "name,ruleName,Count,destAddress" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Destination.csv"|head -2 |tail -1|grep -oP "172.16.22.50,0,Multiple,\"Incorrect IPv4 checksum\",\"Packet Anomalies\",(\d{13}),2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Destination.csv"|head -4 |tail -1|grep -oP "172.16.22.50,1028,1.1.1.8,DOSS-Anomaly-TCP-SYN-RST,BDOS,(\d{13}),1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       TOP ATTACK SOURCES       ###############################################################################

  @SID_19
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Sources.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_20
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Sources.csv"|head -1 |grep "name,ruleName,sourceAddress,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_21
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Sources.csv"|head -2 |tail -1|grep -oP "172.16.22.50,0,Multiple,\"Incorrect IPv4 checksum\",\"Packet Anomalies\",(\d{13}),2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Sources.csv"|head -4 |tail -1|grep -oP "172.16.22.50,1055,192.85.1.8,DOSS-Anomaly-TCP-SYN-RST,BDOS,(\d{13}),1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACK CATEGORIES BY BANDWIDTH       ###################################################################

  @SID_22
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack_Categories By Bandwidth.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_23
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack_Categories By Bandwidth.csv"|head -1 |grep "ruleName,category,packetBandwidth,packetCount" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_24
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack_Categories By Bandwidth.csv"|head -2 |tail -1|grep -oP "172.16.22.50,N/A,0,2,\"Packet Anomalies\",(\d{13}),Anomalies"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack_Categories By Bandwidth.csv"|head -3 |tail -1|grep -oP "172.16.22.50,N/A,56641,58469,BDOS,(\d{13}),DOSShield"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACK BY MITIGATION ACTION       ####################################################################

  @SID_25
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By Mitigation Action.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_26
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By Mitigation Action.csv"|head -1 |grep "name,actionType,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_27
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By Mitigation Action.csv"|head -2 |tail -1|grep -oP "172.16.22.50,Drop,N/A,\"Incorrect IPv4 checksum\",\"Packet Anomalies\",(\d{13}),2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By Mitigation Action.csv"|head -4 |tail -1|grep -oP "172.16.22.50,Drop,N/A,DOSS-Anomaly-TCP-SYN-RST,BDOS,(\d{13}),1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACKS BY PROTECTION POLICY       ####################################################################

  @SID_28
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By\ Protection\ Policy.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_29
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By\ Protection\ Policy.csv|head -1|grep "name,ruleName,Count,endTime" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_30
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By\ Protection\ Policy.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",2,(\d{13})" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_By\ Protection\ Policy.csv|head -3|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,1,(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       CRITICAK ATTACKS BY MITIGATION ACTION      #############################################################

  @SID_31
  Scenario: VRM report validate CSV file CRITICAK ATTACKS BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Critical_Attacks by Mitigation Action.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_32
  Scenario: VRM report validate CSV file CRITICAK ATTACKS BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Critical_Attacks by Mitigation Action.csv"|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP ATTACKS BY BANDWIDTH      ########################################################################

  @SID_33
  Scenario: VRM report validate CSV file TOP ATTACKS BY BANDWIDTH number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Bandwidth.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_34
  Scenario: VRM report validate CSV file TOP ATTACKS BY BANDWIDTH headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Bandwidth.csv"|head -1|grep "name,ruleName,packetBandwidth,packetCount" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_35
  Scenario: VRM report validate CSV file TOP ATTACKS BY BANDWIDTH content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Bandwidth.csv"|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",0,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Bandwidth.csv"|head -3|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,56641,58469"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP ATTACKS BY PROTOCOL      ########################################################################

  @SID_36
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Protocol.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_37
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Protocol.csv"|head -1|grep "name,ruleName,protocol,Count" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_38
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Protocol.csv"|head -2|tail -1|grep -oP "172.16.22.50,IP,N/A,\"Incorrect IPv4 checksum\",\"Packet Anomalies\",(\d{13}),2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Protocol.csv"|head -3|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,TCP,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP SCANNERS      ##################################################################################

  @SID_39
  Scenario: VRM report validate CSV file TOP SCANNERS number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Scanners.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_40
  Scenario: VRM report validate CSV file TOP SCANNERS headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Scanners.csv"|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  Scenario: Clear SMTP server log files
    Then CLI Run remote linux "root" Command "echo "cleared" $(date) > /var/spool/mail/radware" on "genericLinuxServer"
    Then CLI Run remote linux "root" Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "genericLinuxServer"
    Then CLI Run remote linux "root" Command "rm /var/spool/mail/reportuser" on "genericLinuxServer"

  Scenario: share mail validate pdf
    Given UI "Create" Report With Name "Mail"
      | Share  | Email:[also@report.local],Subject:report delivery Subject |
      | Format | PDF                                                       |
    And UI Click Button "Views.Expand" with value "Mail"
    And UI Click Button "Generate Now" with value "Mail"
    And Sleep "150"


  Scenario: Validate Report Email recieved pdf
    Then CLI Run remote linux "root" Command "cat /var/spool/mail/reportuser" on "genericLinuxServer"
    Then CLI Operations - Verify that output contains regex ".*Subject: report delivery Subject.*"
    Then CLI Operations - Verify that output contains regex ".*also@report.local.*"
    Then CLI Operations - Verify that output contains regex ".*Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf.*"
    Then CLI Run remote "root" Command "cat /var/spool/mail/reportuser|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject" |wc -l" on "genericLinuxServer" and validate result EQUALS "1"
    Then CLI Run remote "root" Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf" /var/spool/mail/reportuser | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run remote "root" Command "grep "X-Original-To: also@report.local" /var/spool/mail/reportuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"


  Scenario: share mail validate html
    Then CLI Run remote linux "root" Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "genericLinuxServer"
    Then CLI Run remote linux "root" Command "rm /var/spool/mail/reportuser" on "genericLinuxServer"
    Given UI "Create" Report With Name "Mail"
      | Share  | Email:[also@report.local],Subject:report delivery Subject |
      | Format | HTML                                                      |
    And UI Click Button "Views.Expand" with value "Mail"
    And UI Click Button "Generate Now" with value "Mail"
    And Sleep "150"
    Then CLI Run remote linux "root" Command "cat /var/spool/mail/reportuser" on "genericLinuxServer"
    Then CLI Operations - Verify that output contains regex ".*Subject: report delivery Subject.*"
    Then CLI Operations - Verify that output contains regex ".*also@report.local.*"
    Then CLI Operations - Verify that output contains regex ".*Content-Type: text/html.*"
    Then CLI Run remote "root" Command "cat /var/spool/mail/reportuser|tr -d "="|tr -d "\n"|grep -o "Content-Type: text/html" |wc -l" on "genericLinuxServer" and validate result EQUALS "1"


  Scenario: share mail validate csv
    Then CLI Run remote linux "root" Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "genericLinuxServer"
    Then CLI Run remote linux "root" Command "rm /var/spool/mail/reportuser" on "genericLinuxServer"
    Given UI "Create" Report With Name "Mail"
      | Share  | Email:[also@report.local],Subject:report delivery Subject |
      | Format | CSV                                                       |
    And UI Click Button "Views.Expand" with value "Mail"
    And UI Click Button "Generate Now" with value "Mail"
    And Sleep "150"
    Then CLI Run remote linux "root" Command "cat /var/spool/mail/reportuser" on "genericLinuxServer"
    Then CLI Operations - Verify that output contains regex ".*Subject: report delivery Subject.*"
    Then CLI Operations - Verify that output contains regex ".*also@report.local.*"
    Then CLI Run remote "root" Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip" /var/spool/mail/reportuser | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Operations - Verify that output contains regex ".*Content-Type: multipart/related.*"

  Scenario: edit share mail validate csv
    Then CLI Run remote linux "root" Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "genericLinuxServer"
    Then CLI Run remote linux "root" Command "echo "cleared" $(date) > /var/spool/mail/radware" on "genericLinuxServer"
    Then CLI Run remote linux "root" Command "rm /var/spool/mail/reportuser" on "genericLinuxServer"
    Given UI "Edit" Report With Name "Mail Edit"
      | Share  | Email:[radware@report.local,automation.vision1@radware.com],Subject:new report delivery Subject |
      | Format | PDF                                                                                             |
    And UI Click Button "Views.Expand" with value "Mail Edit"
    And UI Click Button "Generate Now" with value "Mail Edit"
    And Sleep "150"
    Then CLI Run remote linux "root" Command "cat /var/spool/mail/reportuser" on "genericLinuxServer"
    Then CLI Operations - Verify that output contains regex ".*Subject: new report delivery Subject.*"
    Then CLI Operations - Verify that output contains regex ".*radware@report.local.*"
    Then CLI Run remote "root" Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf" /var/spool/mail/reportuser | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run remote linux "root" Command "cat /var/spool/mail/radware" on "genericLinuxServer"
    Then CLI Operations - Verify that output contains regex ".*Subject: new report delivery Subject.*"
    Then CLI Operations - Verify that output contains regex ".*automation.vision1@radware.com.*"
    Then CLI Run remote "root" Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf" /var/spool/mail/radware | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"


  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |



