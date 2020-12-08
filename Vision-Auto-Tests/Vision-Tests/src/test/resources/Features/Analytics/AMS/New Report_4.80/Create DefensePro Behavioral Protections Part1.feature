@Behavioral
Feature: DefensePro Behavioral Protections Part1


  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"


    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_2
  Scenario: DNS-SOA 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SOA 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                           |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                        |
    Then UI "Validate" Report With Name "DNS_SOA 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                           |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                        |
    Then UI Delete Report With Name "DNS_SOA 1"

  @SID_3
  Scenario: DNS-SOA 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SOA 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}],devices:[All] |
      | Format                | Select: CSV                                                                            |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                           |
    Then UI "Validate" Report With Name "DNS_SOA 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}],devices:[All] |
      | Format                | Select: CSV                                                                            |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                           |
    Then UI Delete Report With Name "DNS_SOA 2"

  @SID_4
  Scenario:  DNS-SOA 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SOA 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv6]}],devices:[All] |
      | Format                | Select: PDF                                                                            |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Quick:3M                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
    Then UI "Validate" Report With Name "DNS_SOA 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv6]}],devices:[All] |
      | Format                | Select: PDF                                                                            |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Quick:3M                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
    Then UI Delete Report With Name "DNS_SOA 3"

  @SID_5
  Scenario:  DNS-SOA 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SOA 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv6]}],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                        |
      | Time Definitions.Date | Quick:This Month                                                                                    |
    Then UI "Validate" Report With Name "DNS_SOA 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv6]}],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                        |
      | Time Definitions.Date | Quick:This Month                                                                                    |
    Then UI Delete Report With Name "DNS_SOA 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_6
  Scenario: DNS-SRV 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SRV 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv6]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                           |
      | Time Definitions.Date | Quick: 1H                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                        |
    Then UI "Validate" Report With Name "DNS_SRV 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv6]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                           |
      | Time Definitions.Date | Quick: 1H                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                        |
    Then UI Delete Report With Name "DNS_SRV 1"

  @SID_7
  Scenario: DNS-SRV 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SRV 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv6]}],devices:[All] |
      | Format                | Select: CSV                                                                            |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Quick: 15m                                                                             |
    Then UI "Validate" Report With Name "DNS_SRV 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv6]}],devices:[All] |
      | Format                | Select: CSV                                                                            |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Quick: 15m                                                                             |
    Then UI Delete Report With Name "DNS_SRV 2"

  @SID_8
  Scenario:  DNS-SRV 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SRV 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv4]}],devices:[All] |
      | Format                | Select: PDF                                                                            |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Quick:This Week                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
    Then UI "Validate" Report With Name "DNS_SRV 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv4]}],devices:[All] |
      | Format                | Select: PDF                                                                            |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Quick:This Week                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
    Then UI Delete Report With Name "DNS_SRV 3"

  @SID_9
  Scenario:  DNS-SRV 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SRV 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv4]}],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                     |
    Then UI "Validate" Report With Name "DNS_SRV 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv4]}],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                     |
    Then UI Delete Report With Name "DNS_SRV 4"

        # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_10
  Scenario: DNS-SRV 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_Other 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                             |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                      |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                          |
    Then UI "Validate" Report With Name "DNS_Other 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                             |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                      |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                          |
    Then UI Delete Report With Name "DNS_Other 1"

  @SID_11
  Scenario: DNS-Other 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_Other 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv4]}],devices:[All] |
      | Format                | Select: CSV                                                                              |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick: 15m                                                                               |
    Then UI "Validate" Report With Name "DNS_Other 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv4]}],devices:[All] |
      | Format                | Select: CSV                                                                              |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick: 15m                                                                               |
    Then UI Delete Report With Name "DNS_Other 2"

  @SID_12
  Scenario:  DNS-Other 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_Other 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv6]}],devices:[All] |
      | Format                | Select: PDF                                                                              |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:This Week                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
    Then UI "Validate" Report With Name "DNS_Other 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv6]}],devices:[All] |
      | Format                | Select: PDF                                                                              |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:This Week                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
    Then UI Delete Report With Name "DNS_Other 3"

  @SID_13
  Scenario:  DNS-Other 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_Other 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv6]}],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
    Then UI "Validate" Report With Name "DNS_Other 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv6]}],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
    Then UI Delete Report With Name "DNS_Other 4"

        # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_14
  Scenario: Excluded UDP Traffic 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Excluded UDP Traffic 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, bps, inbound]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
    Then UI "Validate" Report With Name "Excluded UDP Traffic 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, bps, inbound]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
    Then UI Delete Report With Name "Excluded UDP Traffic 1"

  @SID_15
  Scenario: Excluded UDP Traffic 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Excluded UDP Traffic 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, pps, Outbound]}],devices:[All] |
      | Format                | Select: CSV                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:Previous Month                                                                                               |
    Then UI "Validate" Report With Name "Excluded UDP Traffic 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, pps, Outbound]}],devices:[All] |
      | Format                | Select: CSV                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:Previous Month                                                                                               |
    Then UI Delete Report With Name "Excluded UDP Traffic 2"

  @SID_16
  Scenario:  Excluded UDP Traffic 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Excluded UDP Traffic 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}],devices:[All] |
      | Format                | Select: PDF                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:This Month                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                     |
    Then UI "Validate" Report With Name "Excluded UDP Traffic 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}],devices:[All] |
      | Format                | Select: PDF                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:This Month                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                     |
    Then UI Delete Report With Name "Excluded UDP Traffic 3"

  @SID_17
  Scenario:  Excluded UDP Traffic 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Excluded UDP Traffic 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, pps, inbound]}],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                |
    Then UI "Validate" Report With Name "Excluded UDP Traffic 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, pps, inbound]}],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                |
    Then UI Delete Report With Name "Excluded UDP Traffic 4"

        # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_18
  Scenario: Widgets 3_7_8_11_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_8_11_13 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                 |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                 |
    Then UI Delete Report With Name "Widgets 3_7_8_11_13 Report 1"

  @SID_19
  Scenario: Widgets 3_7_8_11_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_8_11_13 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, Outbound]}, {BDoS-UDP:[IPv4, pps, Outbound]}, {BDoS-UDP Fragmented:[IPv4, pps, Outbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                   |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                                |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, Outbound]}, {BDoS-UDP:[IPv4, pps, Outbound]}, {BDoS-UDP Fragmented:[IPv4, pps, Outbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                   |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                                |
    Then UI Delete Report With Name "Widgets 3_7_8_11_13 Report 2"

  @SID_20
  Scenario:  Widgets 3_7_8_11_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_8_11_13 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv6, bps, Outbound]}, {BDoS-UDP:[IPv6, bps, Outbound]}, {BDoS-UDP Fragmented:[IPv6, bps, Outbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                   |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                      |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv6, bps, Outbound]}, {BDoS-UDP:[IPv6, bps, Outbound]}, {BDoS-UDP Fragmented:[IPv6, bps, Outbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                   |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                      |
    Then UI Delete Report With Name "Widgets 3_7_8_11_13 Report 3"

  @SID_21
  Scenario:  Widgets 3_7_8_11_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_8_11_13 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, inbound]}, {BDoS-UDP:[IPv4, pps, inbound]}, {BDoS-UDP Fragmented:[IPv4, pps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                               |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, inbound]}, {BDoS-UDP:[IPv4, pps, inbound]}, {BDoS-UDP Fragmented:[IPv4, pps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                               |
    Then UI Delete Report With Name "Widgets 3_7_8_11_13 Report 4"

       # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_22
  Scenario: Widgets 1_4_6_8_9_11_12_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, bps, inbound]}, {BDoS-TCP Fragmented:[IPv4, bps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {BDoS-ICMP:[IPv4, bps, inbound]}, {DNS-TXT:[IPv6]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv6]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                                                                                                                                                                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                   |
    Then UI "Validate" Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, bps, inbound]}, {BDoS-TCP Fragmented:[IPv4, bps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {BDoS-ICMP:[IPv4, bps, inbound]}, {DNS-TXT:[IPv6]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv6]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                                                                                                                                                                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                   |
    Then UI Delete Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 1"

  @SID_23
  Scenario: Widgets 1_4_6_8_9_11_12_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, Outbound]}, {BDoS-TCP Fragmented:[IPv4, pps, Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, Outbound]}, {BDoS-UDP Fragmented:[IPv4, pps, Outbound]}, {BDoS-ICMP:[IPv4, pps, Outbound]}, {DNS-TXT:[IPv6]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                                                                                                                                    |
    Then UI "Validate" Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, Outbound]}, {BDoS-TCP Fragmented:[IPv4, pps, Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, Outbound]}, {BDoS-UDP Fragmented:[IPv4, pps, Outbound]}, {BDoS-ICMP:[IPv4, pps, Outbound]}, {DNS-TXT:[IPv6]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                                                                                                                                    |
    Then UI Delete Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 2"

  @SID_24
  Scenario:  Widgets 1_4_6_8_9_11_12_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv6, bps, Outbound]}, {BDoS-TCP Fragmented:[IPv6, bps, Outbound]}, {BDoS-TCP SYN ACK:[IPv6, bps, Outbound]}, {BDoS-UDP Fragmented:[IPv6, bps, Outbound]}, {BDoS-ICMP:[IPv6, bps, Outbound]}, {DNS-TXT:[IPv6]}, {DNS-A:[IPv6]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                                                        |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                                                                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                          |
    Then UI "Validate" Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv6, bps, Outbound]}, {BDoS-TCP Fragmented:[IPv6, bps, Outbound]}, {BDoS-TCP SYN ACK:[IPv6, bps, Outbound]}, {BDoS-UDP Fragmented:[IPv6, bps, Outbound]}, {BDoS-ICMP:[IPv6, bps, Outbound]}, {DNS-TXT:[IPv6]}, {DNS-A:[IPv6]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                                                        |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                                                                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                          |
    Then UI Delete Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 3"

  @SID_25
  Scenario:  Widgets 1_4_6_8_9_11_12_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, inbound]}, {BDoS-TCP Fragmented:[IPv4, pps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, inbound]}, {BDoS-UDP Fragmented:[IPv4, pps, inbound]}, {BDoS-ICMP:[IPv4, pps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                                 |
    Then UI "Validate" Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, inbound]}, {BDoS-TCP Fragmented:[IPv4, pps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, inbound]}, {BDoS-UDP Fragmented:[IPv4, pps, inbound]}, {BDoS-ICMP:[IPv4, pps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                                 |
    Then UI Delete Report With Name "Widgets 1_4_6_8_9_11_12_13 Report 4"

      # ------------------------------------------------------------------------------------------------------------------------------------------------------------


  @SID_26
  Scenario: Widgets 1_2_4_5_6_10_18 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_4_5_6_10_18 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, bps, inbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, inbound]}, {BDoS-TCP Fragmented:[IPv4, bps, inbound]}, {BDoS-TCP RST:[IPv4, bps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, bps, inbound]}, {BDoS-IGMP:[IPv4, bps, inbound]}, {DNS-SRV:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                                                                                                                                                                                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                             |
    Then UI "Validate" Report With Name "Widgets 1_2_4_5_6_10_18 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, bps, inbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, inbound]}, {BDoS-TCP Fragmented:[IPv4, bps, inbound]}, {BDoS-TCP RST:[IPv4, bps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, bps, inbound]}, {BDoS-IGMP:[IPv4, bps, inbound]}, {DNS-SRV:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                                                                                                                                                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                             |
    Then UI Delete Report With Name "Widgets 1_2_4_5_6_10_18 Report 1"

  @SID_27
  Scenario: Widgets 1_2_4_5_6_10_18 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_4_5_6_10_18 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, Outbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, Outbound]}, {BDoS-TCP Fragmented:[IPv4, pps, Outbound]}, {BDoS-TCP RST:[IPv4, pps, Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, Outbound]}, {BDoS-IGMP:[IPv4, pps, Outbound]}, {DNS-SRV:[IPv4]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                                                                                          |
    Then UI "Validate" Report With Name "Widgets 1_2_4_5_6_10_18 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, Outbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, Outbound]}, {BDoS-TCP Fragmented:[IPv4, pps, Outbound]}, {BDoS-TCP RST:[IPv4, pps, Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, Outbound]}, {BDoS-IGMP:[IPv4, pps, Outbound]}, {DNS-SRV:[IPv4]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                                                                                          |
    Then UI Delete Report With Name "Widgets 1_2_4_5_6_10_18 Report 2"

  @SID_28
  Scenario:  Widgets 1_2_4_5_6_10_18 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_4_5_6_10_18 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv6, bps, Outbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv6, inbound]}, {BDoS-TCP Fragmented:[IPv6, bps, Outbound]}, {BDoS-TCP RST:[IPv6, bps, Outbound]}, {BDoS-TCP SYN ACK:[IPv6, bps, Outbound]}, {BDoS-IGMP:[IPv6, bps, Outbound]}, {DNS-SRV:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                    |
    Then UI "Validate" Report With Name "Widgets 1_2_4_5_6_10_18 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv6, bps, Outbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv6, inbound]}, {BDoS-TCP Fragmented:[IPv6, bps, Outbound]}, {BDoS-TCP RST:[IPv6, bps, Outbound]}, {BDoS-TCP SYN ACK:[IPv6, bps, Outbound]}, {BDoS-IGMP:[IPv6, bps, Outbound]}, {DNS-SRV:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                    |
    Then UI Delete Report With Name "Widgets 1_2_4_5_6_10_18 Report 3"

  @SID_29
  Scenario:  Widgets 1_2_4_5_6_10_18 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_4_5_6_10_18 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, inbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, Outbound]}, {BDoS-TCP Fragmented:[IPv4, pps, inbound]}, {BDoS-TCP RST:[IPv4, pps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, inbound]}, {BDoS-IGMP:[IPv4, pps, inbound]}, {DNS-SRV:[IPv6]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                                            |
    Then UI "Validate" Report With Name "Widgets 1_2_4_5_6_10_18 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, inbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, Outbound]}, {BDoS-TCP Fragmented:[IPv4, pps, inbound]}, {BDoS-TCP RST:[IPv4, pps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, inbound]}, {BDoS-IGMP:[IPv4, pps, inbound]}, {DNS-SRV:[IPv6]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                                            |
    Then UI Delete Report With Name "Widgets 1_2_4_5_6_10_18 Report 4"

     # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_30
  Scenario: Widgets 3_7_10_11_12_13_18 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_10_11_12_13_18 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-IGMP:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}, {DNS-SRV:[IPv6]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                         |
    Then UI "Validate" Report With Name "Widgets 3_7_10_11_12_13_18 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-IGMP:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}, {DNS-SRV:[IPv6]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                         |
    Then UI Delete Report With Name "Widgets 3_7_10_11_12_13_18 Report 1"

  @SID_31
  Scenario: Widgets 3_7_10_11_12_13_18 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_10_11_12_13_18 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, Outbound]}, {BDoS-UDP:[IPv4, pps, Outbound]}, {BDoS-IGMP:[IPv4, pps, Outbound]}, {DNS-TXT:[IPv4]},  {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}, {DNS-SRV:[IPv6]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                                 |
    Then UI "Validate" Report With Name "Widgets 3_7_10_11_12_13_18 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, Outbound]}, {BDoS-UDP:[IPv4, pps, Outbound]}, {BDoS-IGMP:[IPv4, pps, Outbound]}, {DNS-TXT:[IPv4]},  {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}, {DNS-SRV:[IPv6]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                                 |
    Then UI Delete Report With Name "Widgets 3_7_10_11_12_13_18 Report 2"

  @SID_32
  Scenario:  Widgets 3_7_10_11_12_13_18 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_10_11_12_13_18 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv6, bps, Outbound]}, {BDoS-UDP:[IPv6, bps, Outbound]}, {BDoS-IGMP:[IPv6, bps, Outbound]}, {DNS-TXT:[IPv6]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}, {DNS-SRV:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Quick:3M                                                                                                                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                              |
    Then UI "Validate" Report With Name "Widgets 3_7_10_11_12_13_18 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv6, bps, Outbound]}, {BDoS-UDP:[IPv6, bps, Outbound]}, {BDoS-IGMP:[IPv6, bps, Outbound]}, {DNS-TXT:[IPv6]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}, {DNS-SRV:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Quick:3M                                                                                                                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                              |
    Then UI Delete Report With Name "Widgets 3_7_10_11_12_13_18 Report 3"

  @SID_33
  Scenario:  Widgets 3_7_10_11_12_13_18 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_10_11_12_13_18 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, inbound]}, {BDoS-UDP:[IPv4, pps, inbound]}, {BDoS-IGMP:[IPv4, pps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}, {DNS-SRV:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                      |
    Then UI "Validate" Report With Name "Widgets 3_7_10_11_12_13_18 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, inbound]}, {BDoS-UDP:[IPv4, pps, inbound]}, {BDoS-IGMP:[IPv4, pps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}, {DNS-SRV:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                      |
    Then UI Delete Report With Name "Widgets 3_7_10_11_12_13_18 Report 4"

     # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_34
  Scenario: Widgets 3_4_5_6_7_8_9_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-TCP Fragmented:[IPv4, bps, inbound]}, {BDoS-TCP RST:[IPv4, bps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {BDoS-ICMP:[IPv4, bps, inbound]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                                                           |
    Then UI "Validate" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-TCP Fragmented:[IPv4, bps, inbound]}, {BDoS-TCP RST:[IPv4, bps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {BDoS-ICMP:[IPv4, bps, inbound]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                                                           |
    Then UI Delete Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 1"

  @SID_35
  Scenario: Widgets 3_4_5_6_7_8_9_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, Outbound]}, {BDoS-TCP Fragmented:[IPv4, pps, Outbound]}, {BDoS-TCP RST:[IPv4, pps, Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, Outbound]}, {BDoS-UDP:[IPv4, pps, Outbound]}, {BDoS-UDP Fragmented:[IPv4, pps, Outbound]}, {BDoS-ICMP:[IPv4, pps, Outbound]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                                                                                                                         |
    Then UI "Validate" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, Outbound]}, {BDoS-TCP Fragmented:[IPv4, pps, Outbound]}, {BDoS-TCP RST:[IPv4, pps, Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, Outbound]}, {BDoS-UDP:[IPv4, pps, Outbound]}, {BDoS-UDP Fragmented:[IPv4, pps, Outbound]}, {BDoS-ICMP:[IPv4, pps, Outbound]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                                                                                                                         |
    Then UI Delete Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 2"

  @SID_36
  Scenario:  Widgets 3_4_5_6_7_8_9_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv6, bps, Outbound]}, {BDoS-TCP Fragmented:[IPv6, bps, Outbound]}, {BDoS-TCP RST:[IPv6, bps, Outbound]}, {BDoS-TCP SYN ACK:[IPv6, bps, Outbound]}, {BDoS-UDP:[IPv6, bps, Outbound]}, {BDoS-UDP Fragmented:[IPv6, bps, Outbound]}, {BDoS-ICMP:[IPv6, bps, Outbound]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                                    |
    Then UI "Validate" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv6, bps, Outbound]}, {BDoS-TCP Fragmented:[IPv6, bps, Outbound]}, {BDoS-TCP RST:[IPv6, bps, Outbound]}, {BDoS-TCP SYN ACK:[IPv6, bps, Outbound]}, {BDoS-UDP:[IPv6, bps, Outbound]}, {BDoS-UDP Fragmented:[IPv6, bps, Outbound]}, {BDoS-ICMP:[IPv6, bps, Outbound]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                                    |
    Then UI Delete Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 3"

  @SID_37
  Scenario:  Widgets 3_4_5_6_7_8_9_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, inbound]}, {BDoS-TCP Fragmented:[IPv4, pps, inbound]}, {BDoS-TCP RST:[IPv4, pps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, inbound]}, {BDoS-UDP:[IPv4, pps, inbound]}, {BDoS-UDP Fragmented:[IPv4, pps, inbound]}, {BDoS-ICMP:[IPv4, pps, inbound]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                                                                                                                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                                                                                                                                                            |
    Then UI "Validate" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, pps, inbound]}, {BDoS-TCP Fragmented:[IPv4, pps, inbound]}, {BDoS-TCP RST:[IPv4, pps, inbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, inbound]}, {BDoS-UDP:[IPv4, pps, inbound]}, {BDoS-UDP Fragmented:[IPv4, pps, inbound]}, {BDoS-ICMP:[IPv4, pps, inbound]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                                                                                                                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                                                                                                                                                            |
    Then UI Delete Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 4"

      # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_38
  Scenario: Widgets 1_2_6_11_12_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_6_11_12_13 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, bps, inbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, inbound]}, {BDoS-TCP SYN ACK:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                             |
    Then UI "Validate" Report With Name "Widgets 1_2_6_11_12_13 Report 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, bps, inbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, inbound]}, {BDoS-TCP SYN ACK:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                             |
    Then UI Delete Report With Name "Widgets 1_2_6_11_12_13 Report 1"

  @SID_39
  Scenario: Widgets 1_2_6_11_12_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_6_11_12_13 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:{BDoS-TCP SYN:[IPv4, pps, Outbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, Outbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                       |
    Then UI "Validate" Report With Name "Widgets 1_2_6_11_12_13 Report 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:{BDoS-TCP SYN:[IPv4, pps, Outbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4, Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, Outbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}}], devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                       |
    Then UI Delete Report With Name "Widgets 1_2_6_11_12_13 Report 2"

  @SID_40
  Scenario:  Widgets 1_2_6_11_12_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_6_11_12_13 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv6, bps, Outbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv6 inbound]}, {BDoS-TCP SYN ACK:[IPv6, bps, Outbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                                                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                |
    Then UI "Validate" Report With Name "Widgets 1_2_6_11_12_13 Report 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv6, bps, Outbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv6 inbound]}, {BDoS-TCP SYN ACK:[IPv6, bps, Outbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                                                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                |
    Then UI Delete Report With Name "Widgets 1_2_6_11_12_13 Report 3"

  @SID_41
  Scenario:  Widgets 1_2_6_11_12_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_6_11_12_13 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, inbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4 Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                                              |
    Then UI "Validate" Report With Name "Widgets 1_2_6_11_12_13 Report 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP SYN:[IPv4, pps, inbound]}, {BDoS-Advanced-UDP Rate-Invariant:[IPv4 Outbound]}, {BDoS-TCP SYN ACK:[IPv4, pps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-A:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                                              |
    Then UI Delete Report With Name "Widgets 1_2_6_11_12_13 Report 4"


  @SID_62
  Scenario: Logout
    Then UI logout and close browser