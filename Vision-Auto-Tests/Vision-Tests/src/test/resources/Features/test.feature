@runa
Feature:test



  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homePage
  Scenario: create new Output Protocol Protocol Equal
    When UI "Create" Forensics With Name "Output Protocol Protocol Equal"
      | Criteria | Event Criteria:Protocol,Operator:Not Equals,Value:IP |

#  @SID_10
#  Scenario: create new Output Protocol Protocol Equal
#    When UI "Create" Forensics With Name "Output Protocol Protocol Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Protocol                                                                       |
#      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[IGMP]                           |
#      | devices               | All                                                                            |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: CSV                                                                    |
#
#  @SID_11
#  Scenario: create new Output Radware ID Protocol Equal
#    When UI "Create" Forensics With Name "Output Radware ID Protocol Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Radware ID                                                                                                       |
#      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[Non-IP]                                                           |
#      | devices               | All                                                                                                              |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_12
#  Scenario: create new Output Duration Protocol Equal
#    When UI "Create" Forensics With Name "Output Duration Protocol Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Duration                                                                       |
#      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[SCTP]                           |
#      | devices               | All                                                                            |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |
#
#  @SID_13
#  Scenario: create new Output Total Packets Dropped Protocol Equal
#    When UI "Create" Forensics With Name "Output Total Packets Dropped Protocol Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Total Packets Dropped                                                                                            |
#      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[ICMPv6]                                                           |
#      | devices               | All                                                                                                              |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_14
#  Scenario: create new Output Max pps Protocol Equal
#    When UI "Create" Forensics With Name "Output Max pps Protocol Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Max pps                                                                        |
#      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[Other]                          |
#      | devices               | index:10                                                                       |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: CSV                                                                    |
#
#  @SID_15
#  Scenario: create new Output Total Mbits Dropped Protocol Equal
#    When UI "Create" Forensics With Name "Output Total Mbits Dropped Protocol Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Total Mbits Dropped                                                                                              |
#      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[IP,TCP,UDP,ICMP,IGMP,Non-IP,SCTP,ICMPv6,Other]                    |
#      | devices               | index:10                                                                                                         |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_16
#  Scenario: create new Output Max Kbps Protocol Not Equal
#    When UI "Create" Forensics With Name "Output Max Kbps Protocol Not Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Max Kbps                                                                       |
#      | Criteria              | Event Criteria:Protocol,Operator:Not Equals,Value:[ICMP,IGMP,Non-IP]           |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |
#
#  @SID_17
#  Scenario: create new Output Physical Port Protocol Not Equal
#    When UI "Create" Forensics With Name "Output Physical Port Protocol Not Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Physical Port                                                                                                    |
#      | Criteria              | Event Criteria:Protocol,Operator:Not Equals,Value:[IP,TCP,UDP]                                                   |
#      | devices               | All                                                                                                              |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_18
#  Scenario: create new Output Risk Protocol Equal
#    When UI "Create" Forensics With Name "Output Risk Protocol Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Risk                                                                           |
#      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[ICMPv6,Other]                   |
#      | devices               | All                                                                            |
#      | Time Definitions.Date | Quick:1Y                                                                       |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: CSV                                                                    |
#
#  @SID_19
#  Scenario: create new Output VLAN Tag Protocol Not Equal
#    When UI "Create" Forensics With Name "Output VLAN Tag Protocol Not Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | VLAN Tag                                                                                                         |
#      | Criteria              | Event Criteria:Protocol,Operator:Not Equals,Value:[IP,TCP,UDP,ICMP,IGMP,Non-IP,SCTP,ICMPv6,Other]                |
#      | devices               | All                                                                                                              |
#      | Time Definitions.Date | Quick:This Month                                                                                                 |
#      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_20
#  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Risk Equal
#    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Risk Equal"
#      | Product               | DefenseFlow                                                                                          |
#      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped |
#      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Info]                                                     |
#      | devices               | indec:10                                                                                             |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                     |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                      |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
#      | Format                | Select: HTML                                                                                         |
#
#  @SID_21
#  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag Risk Equal
#    When UI "Create" Forensics With Name "Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag Risk Equal"
#      | Product               | DefenseFlow                                                                                                                                     |
#      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag |
#      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Low]                                                                                                 |
#      | devices               | All                                                                                                                                             |
#      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                              |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                    |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                |
#      | Format                | Select: CSV                                                                                                                                     |
#
#  @SID_22
#  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Risk Equal
#    When UI "Create" Forensics With Name "Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Risk Equal"
#      | Product               | DefenseFlow                                                                                            |
#      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps |
#      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Medium]                                                     |
#      | devices               | index:10                                                                                               |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
#      | Format                | Select: CSV                                                                                            |
#
#  @SID_23
#  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Risk Equal
#    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Risk Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action                                         |
#      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[High]                                                                 |
#      | devices               | All                                                                                                              |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_24
#  Scenario: create new Output Policy Name,Source IP Address Risk Equal
#    When UI "Create" Forensics With Name "Output Policy Name,Source IP Address Risk Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Policy Name,Source IP Address                                                  |
#      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Info,Low,Medium,High]               |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |
#
#  @SID_25
#  Scenario: create new Output Destination IP Address,Destination Port,Direction Risk Not Equal
#    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction Risk Not Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Destination IP Address,Destination Port,Direction                                                                |
#      | Criteria              | Event Criteria:Risk,Operator:Not Equals,Value:[Low,Medium]                                                       |
#      | devices               | All                                                                                                              |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_26
#  Scenario: create new Output All Risk Equal
#    When UI "Create" Forensics With Name "Output All Risk Equal"
#      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                        |
#      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag |
#      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Low,Medium]                                                                                                                                                                                                                                             |
#      | devices               | All                                                                                                                                                                                                                                                                                                |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                     |
#      | Format                | Select: CSV                                                                                                                                                                                                                                                                                        |
#
#  @SID_27
#  Scenario: create new Output Device IP Address Risk Not Equal
#    When UI "Create" Forensics With Name "Output Device IP Address Risk Not Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Device IP Address                                                                                                |
#      | Criteria              | Event Criteria:Risk,Operator:Not Equals,Value:[Info,High]                                                        |
#      | devices               | All                                                                                                              |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_28
#  Scenario: create new Output End Time Risk Equal
#    When UI "Create" Forensics With Name "Output End Time Risk Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | End Time                                                                       |
#      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Medium,High]                        |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |
#
#  @SID_29
#  Scenario: create new Output Start Time Risk Not Equal
#    When UI "Create" Forensics With Name "Output Start Time Risk Not Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Start Time                                                                                                       |
#      | Criteria              | Event Criteria:Risk,Operator:Not Equals,Value:[Info,Low,Medium,High]                                             |
#      | devices               | All                                                                                                              |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_30
#  Scenario: create new Output Threat Category Source IP Equal
#    When UI "Create" Forensics With Name "Output Threat Category Source IP Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Threat Category                                                                |
#      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:2.2.2.2           |
#      | devices               | All                                                                            |
#      | Time Definitions.Date | Quick:1Y                                                                       |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: CSV                                                                    |
#
#  @SID_31
#  Scenario: create new Output Attack Name1 Source IP Not Equal
#    When UI "Create" Forensics With Name "Output Attack Name1 Source IP Not Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Attack Name                                                                                                      |
#      | Criteria              | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv4,IPValue:4.4.4.1                                         |
#      | devices               | All                                                                                                              |
#      | Time Definitions.Date | Quick:This Month                                                                                                 |
#      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_32
#  Scenario: create new Output Attack Name2 Source IP Equal
#    When UI "Create" Forensics With Name "Output Attack Name2 Source IP Equal"
#      | Product               | DefenseFlow                                                                           |
#      | Output                | Attack Name                                                                           |
#      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv6,IPValue:::ffff:0:255.255.255.255 |
#      | devices               | indec:10                                                                              |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                      |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                       |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |
#      | Format                | Select: HTML                                                                          |
#
#  @SID_33
#  Scenario: create new Output Action Source IP Not Equal
#    When UI "Create" Forensics With Name "Output Action Source IP Not Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Action                                                                                                           |
#      | Criteria              | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv6,IPValue:64:ff9b::255.255.255.255                        |
#      | devices               | All                                                                                                              |
#      | devices               | All                                                                                                              |
#      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_34
#  Scenario: create new Output Attack ID Source IP Equal
#    When UI "Create" Forensics With Name "Output Attack ID Source IP Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Attack ID                                                                                                        |
#      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b             |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_35
#  Scenario: create new Output Policy Name Source IP Equal
#    When UI "Create" Forensics With Name "Output Policy Name Source IP Equal"
#      | Product               | DefenseFlow                                                                              |
#      | Output                | Policy Name                                                                              |
#      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b |
#      | devices               | index:10                                                                                 |
#      | Time Definitions.Date | Quick:1D                                                                                 |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                             |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
#      | Format                | Select: CSV                                                                              |
#
#  @SID_36
#  Scenario: create new Output Source IP Address Source Port Equal
#    When UI "Create" Forensics With Name "Output Source IP Address Source Port Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Source IP Address                                                                                                |
#      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:100                                           |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
#      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_37
#  Scenario: create new Output Source Ports Source Port Not Equal
#    When UI "Create" Forensics With Name "Output Source Port Source Port Not Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Source Port                                                                    |
#      | Criteria              | Event Criteria:Source Port,Operator:Not Equals,portType:Port,portValue:1024    |
#      | devices               | index:10                                                                       |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |
#
#  @SID_38
#  Scenario: create new Output Destination IP Address Source Port Equal
#    When UI "Create" Forensics With Name "Output Destination IP Address Source Port Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Destination IP Address                                                                                           |
#      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:53                                            |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_39
#  Scenario: create new Output Destination Port Source Port Equal
#    When UI "Create" Forensics With Name "Output Destination Port Source Port Equal"
#      | Product               | DefenseFlow                                                                             |
#      | Output                | Destination Port                                                                        |
#      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port Range,portFrom:500,portTo:1024 |
#      | devices               | index:10                                                                                |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                             |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body          |
#      | Format                | Select: CSV                                                                             |
#
#  @SID_40
#  Scenario: create new Output Direction Source Port Not Equal
#    When UI "Create" Forensics With Name "Output Direction Source Port Not Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Direction                                                                                                        |
#      | Criteria              | Event Criteria:Source Port,Operator:Not Equals,portType:Port Range,portFrom:90,portTo:100                        |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_41
#  Scenario: create new Output Protocol Threat Category Equal
#    When UI "Create" Forensics With Name "Output Protocol Threat Category Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Protocol                                                                       |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[ACL]                     |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |
#
#  @SID_42
#  Scenario: create new Output Radware ID Threat Category Equal
#    When UI "Create" Forensics With Name "Output Radware ID Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Radware ID                                                                                                       |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Anti Scanning]                                             |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_43
#  Scenario: create new Output Duration Threat Category Equal
#    When UI "Create" Forensics With Name "Output Duration Threat Category Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Duration                                                                       |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Behavioral DoS]          |
#      | devices               | index:10                                                                       |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: CSV                                                                    |
#
#  @SID_44
#  Scenario: create new Output Total Packets Dropped Threat Category Equal
#    When UI "Create" Forensics With Name "Output Total Packets Dropped Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Total Packets Dropped                                                                                            |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[DoS]                                                       |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_45
#  Scenario: create new Output Max pps Threat Category Equal
#    When UI "Create" Forensics With Name "Output Max pps Threat Category Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Max pps                                                                        |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[HTTP Flood]              |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |
#
#  @SID_46
#  Scenario: create new Output Total Mbits Dropped Threat Category Equal
#    When UI "Create" Forensics With Name "Output Total Mbits Dropped Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Total Mbits Dropped                                                                                              |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[HTTPS Flood]                                               |
#      | devices               | index:10                                                                                                         |
#      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_47
#  Scenario: create new Output Max Kbps Threat Category Equal
#    When UI "Create" Forensics With Name "Output Max Kbps Threat Category Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Max Kbps                                                                       |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Intrusions]              |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Quick:1Y                                                                       |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: CSV                                                                    |
#
#  @SID_48
#  Scenario: create new Output Physical Port Threat Category Equal
#    When UI "Create" Forensics With Name "Output Physical Port Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Physical Port                                                                                                    |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Cracking Protection]                                       |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Quick:This Month                                                                                                 |
#      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_49
#  Scenario: create new Output Risk Threat Category Equal
#    When UI "Create" Forensics With Name "Output Risk Threat Category Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Risk                                                                           |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[SYN Flood]               |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |
#
#  @SID_50
#  Scenario: create new Output VLAN Tag Threat Category Equal
#    When UI "Create" Forensics With Name "Output VLAN Tag Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | VLAN Tag                                                                                                         |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Anomalies]                                                 |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_51
#  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Threat Category Equal
#    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Threat Category Equal"
#      | Product               | DefenseFlow                                                                                          |
#      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Stateful ACL]                                  |
#      | devices               | index:10                                                                                             |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
#      | Format                | Select: CSV                                                                                          |
#
#  @SID_52
#  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag Threat Category Equal
#    When UI "Create" Forensics With Name "Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                                                      |
#      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag  |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[DNS Flood]                                                                                 |
#      | devices               | index:10                                                                                                                                         |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                  |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                 |
#      | Format                | Select: CSV With Attack Details                                                                                                                   |
#
#  @SID_53
#  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Threat Category Equal
#    When UI "Create" Forensics With Name "Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Threat Category Equal"
#      | Product               | DefenseFlow                                                                                            |
#      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Bandwidth Management]                            |
#      | devices               | index:10                                                                                               |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                       |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                        |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
#      | Format                | Select: HTML                                                                                           |
#
#  @SID_54
#  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Threat Category Equal
#    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action                                         |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Traffic Filters]                                           |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV                                                                                                      |
#
#  @SID_55
#  Scenario: create new Output Policy Name,Source IP Address Threat Category Equal
#    When UI "Create" Forensics With Name "Output Policy Name,Source IP Address Threat Category Equal"
#      | Product               | DefenseFlow                                                                    |
#      | Output                | Policy Name,Source IP Address                                                  |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Malicious IP Addresses]  |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: CSV                                                                    |
#
#  @SID_56
#  Scenario: create new Output Destination IP Address,Destination Port,Direction Threat Category Equal
#    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                      |
#      | Output                | Destination IP Address,Destination Port,Direction                                                                |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Geolocation]                                               |
#      | devices               | index:10                                                                                                         |
#      | Time Definitions.Date | Quick:3M                                                                                                         |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format                | Select: CSV With Attack Details                                                                                   |
#
#  @SID_57
#  Scenario: create new Output All Threat Category Equal
#    When UI "Create" Forensics With Name "Output All Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                        |
#      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Connection PPS]                                                                                                                                                                                                                              |
#      | devices               | index:10                                                                                                                                                                                                                                                                                           |
#      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                   |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                     |
#      | Format                | Select: HTML                                                                                                                                                                                                                                                                                       |
#
#  @SID_58
#  Scenario: create new Output Start Time Threat Category Equal
#    When UI "Create" Forensics With Name "Output Start Timen Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                                                                                                                                                                                         |
#      | Output                | Start Time                                                                                                                                                                                                                                                                          |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[ACL,Anti Scanning,Behavioral DoS,DoS,HTTP Flood,HTTPS Flood,Intrusions,Cracking Protection,SYN Flood,Anomalies,Stateful ACL,DNS Flood,Bandwidth Management,Traffic Filters,Malicious IP Addresses,Geolocation,Connection PPS] |
#      | devices               | index:10                                                                                                                                                                                                                                                                            |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                     |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                      |
#      | Format                | Select: HTML                                                                                                                                                                                                                                                                        |
#
#  @SID_59
#  Scenario: create new Output End Time Threat Category Equal
#    When UI "Create" Forensics With Name "Output End Time Threat Category Equal"
#      | Product               | DefenseFlow                                                                                                           |
#      | Output                | End Time                                                                                                              |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Anti Scanning,Behavioral DoS,DoS,Cracking Protection,SYN Flood] |
#      | devices               | index:10                                                                                                              |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                        |
#      | Format                | Select: CSV                                                                                                           |
#
#  @SID_60
#  Scenario: create new Output Device IP Address Threat Category Not Equal
#    When UI "Create" Forensics With Name "Output Device IP Address Threat Category Not Equal"
#      | Product               | DefenseFlow                                                                                                                                     |
#      | Output                | Device IP Address                                                                                                                               |
#      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[HTTP Flood,HTTPS Flood,Anomalies,Stateful ACL,Traffic Filters,Malicious IP Addresses] |
#      | devices               | index:10                                                                                                                                        |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                                                 |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                |
#      | Format                | Select: CSV With Attack Details                                                                                                                  |
#
#  @SID_61
#  Scenario: create new Output Threat Category Threat Category Not Equal
#    When UI "Create" Forensics With Name "Output Threat Category Threat Category Not Equal"
#      | Product               | DefenseFlow                                                                         |
#      | Output                | Threat Category                                                                     |
#      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[DNS Flood,Connection PPS] |
#      | devices               | index:10                                                                            |
#      | Time Definitions.Date | Relative:[Days,2]                                                                   |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                        |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body      |
#      | Format                | Select: HTML                                                                        |
#
#  @SID_62
#  Scenario: create new Output Attack Name1,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps Threat Category Not Equal
#    When UI "Create" Forensics With Name "Output Attack Name1,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps Threat Category Not Equal"
#      | Product               | DefenseFlow                                                                                                                                                                                                                                                                             |
#      | Output                | Attack Name,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps                                                                                                                                                                                                                  |
#      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[ACL,Anti Scanning,Behavioral DoS,DoS,HTTP Flood,HTTPS Flood,Intrusions,Cracking Protection,SYN Flood,Anomalies,Stateful ACL,DNS Flood,Bandwidth Management,Traffic Filters,Malicious IP Addresses,Geolocation,Connection PPS] |
#      | devices               | index:10                                                                                                                                                                                                                                                                                |
#      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                                                                                                                                                     |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                        |
#      | Format                | Select: CSV                                                                                                                                                                                                                                                                             |
#
#  @SID_63
#  Scenario: create new Output Attack Name2,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps Custom
#    When UI "Create" Forensics With Name "Output Attack Name2,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps Custom"
#      | Product               | DefenseFlow                                                                                                                                            |
#      | Output                | Attack Name,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps                                                                                 |
#      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Http 403 Forbidden;Event Criteria:Duration,Operator:Equals,Value:[5-10 min],condition.Custom:1 AND 2 |
#      | devices               | index:10                                                                                                                                               |
#      | Time Definitions.Date | Quick:1D                                                                                                                                               |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                                                           |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                         |
#      | Format                | Select: CSV                                                                                                                                            |
#
#  @SID_64
#  Scenario: create new Output Start Time,End Time,Device IP Address,Action,Source IP Address,Source Port,Destination IP Address,Destination Port Custom
#    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Action,Source IP Address,Source Port,Destination IP Address,Destination Port Custom"
#      | Product               | DefenseFlow                                                                                                                                                       |
#      | Output                | Start Time,End Time,Device IP Address,Action,Source IP Address,Source Port,Destination IP Address,Destination Port                                                |
#      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Challenge,Event Criteria:Threat Category,Operator:Equals,Value:[Malicious IP Addresses],condition.Custom:1 OR 2 |
#      | devices               | index:10                                                                                                                                                          |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                  |
#      | Schedule              | Run Every:once, On Time:+6H                                                                                                                                       |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                  |
#      | Format                | Select: CSV With Attack Details                                                                                                                                    |
#
#  @SID_65
#  Scenario: Logout
#    Then UI logout and close browser
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##  Scenario: fdfss
##    Then UI Login with user "sys_admin" and password "radware"
##    Then UI Navigate to "New Forensics" page via homePage
##    When UI "Validate" Forensics With Name "criter"
###      | Protected Objects     | ahlam,Alina,Moshe                                |
##      | Output                | Attack Name,Attack ID,Source IP Address,Destination IP Address                 |
##      | Description           | blalbablabla                                                                   |
###      | Time Definitions.Date | Relative:[Weeks,2]|
##      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                |
##      | Share   | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware|
###      | Product               | AppWall|
###      | Product               | DefenseFlow                                                                    |
###      | devices               | All                                                                            |
###      | devices               | index:10,policies:[pol_1];index:11,ports:[1,2],policies:[pol_1];               |
###      | Criteria              | Event Criteria:Attack ID,Operator:Not Equals,Value:123; Event Criteria:Attack ID,Operator:Not Equals,Value:1234;|
##      | Criteria              | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv4,IPValue:192.85.1.2;   |
###      | Applications          | A1,ADZ,automation37                                                            |
##      | devices    | index:10,policies:[Policy14, Policy15],ports:[1,2]; index:11,policies:[Policy14, pol_1],ports:[1,2]                     |
##      | Time Definitions.Date | Absolute:[-4d,-3d]                                                                    |
###      | Time Definitions.Date | Absolute:[27.02.2017 01:00:00, +0d] |
###      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
##  Then UI "Validate" Forensics With Name "bababa"
###    | Protected Objects     | ahlam,Alina,Moshe                                |
###    | Applications          | A1,ADZ,automation37                                                            |
##    | Time Definitions.Date | Absolute:[-4d,-3d]                                                                    |
##    | devices    | index:10,policies:[Policy14, Policy15],ports:[1,2]; index:11,policies:[Policy14, pol_1],ports:[1,2]                     |
##    | Output                | Attack Name,Attack ID,Source IP Address,Destination IP Address                 |
##    | Description           | blalbablabla                                                                   |
###    | Time Definitions.Date | Relative:[Weeks,2]|
###    | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                |
##    | Share   | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware|
##    | Applications          | A1,ADZ,automation37                                                            |
###    | Product               | AppWall|
###    | Product               | DefenseFlow                                                                    |
##
###    Then select forensics schedule with details "Run Every:Monthly, On Time:+6H, At Months:[OCT]"
##
##
##
##
##
##
##
##
