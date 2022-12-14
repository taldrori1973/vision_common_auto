@TC117964
Feature:DefenseFlow Analytics Part 1

  
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  @SID_2
  Scenario: Top Attacks by Duration Report 1
    Given UI "Create" Report With Name "Top Attacks by Duration 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                           |
      | Time Definitions.Date | Quick:15m                                                                                                   |
    Then UI "Validate" Report With Name "Top Attacks by Duration 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                           |
      | Time Definitions.Date | Quick:15m                                                                                                   |
    Then UI Delete Report With Name "Top Attacks by Duration 1"


  @SID_3
  Scenario: Top Attacks by Duration Report 2
    Given UI "Create" Report With Name "Top Attacks by Duration 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration],Protected Objects:[All] |
      | Format                | Select: PDF                                                                                          |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
    Then UI "Validate" Report With Name "Top Attacks by Duration 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
    Then UI Delete Report With Name "Top Attacks by Duration 2"

  @SID_4
  Scenario: Top Attacks by Duration Report 3
    Given UI "Create" Report With Name "Top Attacks by Duration 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Relative:[Days,2]                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                          |
    Then UI "Validate" Report With Name "Top Attacks by Duration 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Relative:[Days,2]                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                          |
    Then UI Delete Report With Name "Top Attacks by Duration 3"

  @SID_5
  Scenario: Top Attacks by Duration Report 4
    Given UI "Create" Report With Name "Top Attacks by Duration 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Time Definitions.Date | Relative:[Months,2]                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                              |
    Then UI "Validate" Report With Name "Top Attacks by Duration 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Time Definitions.Date | Relative:[Months,2]                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                              |
    Then UI Delete Report With Name "Top Attacks by Duration 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_6
  Scenario: Top Attacks by Count Report 1
    Given UI "Create" Report With Name "Top Attacks by Count Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Count],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Quick:1D                                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                            |
    Then UI "Validate" Report With Name "Top Attacks by Count Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Count],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Quick:1D                                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                            |
    Then UI Delete Report With Name "Top Attacks by Count Report 1"

  @SID_7
  Scenario: Top Attacks by Count Report 2
    Given UI "Create" Report With Name "Top Attacks by Count Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Count], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |
    Then UI "Validate" Report With Name "Top Attacks by Count Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Count], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |
    Then UI Delete Report With Name "Top Attacks by Count Report 2"

  @SID_8
  Scenario: Top Attacks by Count Report 3
    Given UI "Create" Report With Name "Top Attacks by Count Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Count], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                       |
      | Time Definitions.Date | Quick:This Week                                                                                    |
    Then UI "Validate" Report With Name "Top Attacks by Count Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Count], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                       |
      | Time Definitions.Date | Quick:This Week                                                                                    |
    Then UI Delete Report With Name "Top Attacks by Count Report 3"

  @SID_9
  Scenario: Top Attacks by Count Report 4
    Given UI "Create" Report With Name "Top Attacks by Count Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Count], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                              |
      | Time Definitions.Date | Relative:[Days,3]                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
    Then UI "Validate" Report With Name "Top Attacks by Count Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Count], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                              |
      | Time Definitions.Date | Relative:[Days,3]                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
    Then UI Delete Report With Name "Top Attacks by Count Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_10
  Scenario: Top Attacks by Rate Report 1
    Given UI "Create" Report With Name "Top Attacks by Rate Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Quick:This Week                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
    Then UI "Validate" Report With Name "Top Attacks by Rate Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Quick:This Week                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
    Then UI Delete Report With Name "Top Attacks by Rate Report 1"

  @SID_11
  Scenario: Top Attacks by Rate Report 2
    Given UI "Create" Report With Name "Top Attacks by Rate Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
    Then UI "Validate" Report With Name "Top Attacks by Rate Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
    Then UI Delete Report With Name "Top Attacks by Rate Report 2"

  @SID_12
  Scenario: Top Attacks by Rate Report 3
    Given UI "Create" Report With Name "Top Attacks by Rate 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                      |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                   |
    Then UI "Validate" Report With Name "Top Attacks by Rate 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                      |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                   |
    Then UI Delete Report With Name "Top Attacks by Rate 3"

  @SID_13
  Scenario: Top Attacks by Rate Report 4
    Given UI "Create" Report With Name "Top Attacks by Rate Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                             |
      | Time Definitions.Date | Relative:[Months,4]                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                          |
    Then UI "Validate" Report With Name "Top Attacks by Rate Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                             |
      | Time Definitions.Date | Relative:[Months,4]                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                          |
    Then UI Delete Report With Name "Top Attacks by Rate Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_14
  Scenario: Top Attacks by Protocol Report 1
    Given UI "Create" Report With Name "Top Attacks by Protocol Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Protocol],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:30m                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                                                               |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Protocol],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:30m                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                                                               |
    Then UI Delete Report With Name "Top Attacks by Protocol Report 1"

  @SID_15
  Scenario: Top Attacks by Protocol Report 2
    Given UI "Create" Report With Name "Top Attacks by Protocol Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Protocol], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Protocol], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
    Then UI Delete Report With Name "Top Attacks by Protocol Report 2"

  @SID_16
  Scenario: Top Attacks by Protocol Report 3
    Given UI "Create" Report With Name "Top Attacks by Protocol Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Protocol], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                    |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Protocol], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                    |
    Then UI Delete Report With Name "Top Attacks by Protocol Report 3"

  @SID_17
  Scenario: Top Attacks by Protocol Report 4
    Given UI "Create" Report With Name "Top Attacks by Protocol Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Protocol], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Time Definitions.Date | Quick:Quarter                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                              |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Protocol], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Time Definitions.Date | Quick:Quarter                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                              |
    Then UI Delete Report With Name "Top Attacks by Protocol Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_18
  Scenario: Top Attack Destination Report 1
    Given UI "Create" Report With Name "Top Attack Destination Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Destination],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:Previous Month                                                                                      |
    Then UI "Validate" Report With Name "Top Attack Destination Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Destination],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:Previous Month                                                                                      |
    Then UI Delete Report With Name "Top Attack Destination Report 1"

  @SID_19
  Scenario: Top Attack Destination Report 2
    Given UI "Create" Report With Name "Top Attack Destination  Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Destination], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                          |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
    Then UI "Validate" Report With Name "Top Attack Destination  Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Destination], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                          |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
    Then UI Delete Report With Name "Top Attack Destination  Report 2"

  @SID_20
  Scenario: Top Attack Destination Report 3
    Given UI "Create" Report With Name "Top Attack Destination Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Destination], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                      |
    Then UI "Validate" Report With Name "Top Attack Destination Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Destination], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                      |
    Then UI Delete Report With Name "Top Attack Destination Report 3"

  @SID_21
  Scenario: Top Attack Destination Report 4
    Given UI "Create" Report With Name "Top Attack Destination Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Destination], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
    Then UI "Validate" Report With Name "Top Attack Destination Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Destination], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
    Then UI Delete Report With Name "Top Attack Destination Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_22
  Scenario: Top Attack Sources Report 1
    Given UI "Create" Report With Name "Top Attack Sources Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Sources],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:15m                                                                                             |
    Then UI "Validate" Report With Name "Top Attack Sources Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Sources],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:15m                                                                                             |
    Then UI Delete Report With Name "Top Attack Sources Report 1"

  @SID_23
  Scenario: Top Attack Sources Report 2
    Given UI "Create" Report With Name "Top Attack Sources Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Sources], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Quick:This Week                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
    Then UI "Validate" Report With Name "Top Attack Sources Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Sources], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Quick:This Week                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
    Then UI Delete Report With Name "Top Attack Sources Report 2"

  @SID_24
  Scenario: Top Attack Sources Report 3
    Given UI "Create" Report With Name "Top Attack Sources Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Sources], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                  |
    Then UI "Validate" Report With Name "Top Attack Sources Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Sources], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                  |
    Then UI Delete Report With Name "Top Attack Sources Report 3"

  @SID_25
  Scenario: Top Attack Sources Report 4
    Given UI "Create" Report With Name "Top Attack Sources Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Sources], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                            |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
    Then UI "Validate" Report With Name "Top Attack Sources Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attack Sources], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                            |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
    Then UI Delete Report With Name "Top Attack Sources Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_26
  Scenario: Traffic Bandwidth Report 1
    Given UI "Create" Report With Name "Traffic Bandwidth Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[{Traffic Bandwidth:[30]}],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[{Traffic Bandwidth:[30]}],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                |
    Then UI Delete Report With Name "Traffic Bandwidth Report 1"

  @SID_27
  Scenario: Traffic Bandwidth Report 2
    Given UI "Create" Report With Name "Traffic Bandwidth Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[{Traffic Bandwidth:[40]}], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Quick:3M                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[{Traffic Bandwidth:[40]}], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Quick:3M                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
    Then UI Delete Report With Name "Traffic Bandwidth Report 2"

  @SID_28
  Scenario: Traffic Bandwidth Report 3
    Given UI "Create" Report With Name "Traffic Bandwidth Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[{Traffic Bandwidth:[All Protected Objects]}], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                          |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[{Traffic Bandwidth:[All Protected Objects]}], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                          |
    Then UI Delete Report With Name "Traffic Bandwidth Report 3"

  @SID_29
  Scenario: Traffic Bandwidth Report 4
    Given UI "Create" Report With Name "Traffic Bandwidth Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[{Traffic Bandwidth:[All Protected Objects]}], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                                    |
      | Time Definitions.Date | Quick:1H                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                 |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[{Traffic Bandwidth:[All Protected Objects]}], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                                    |
      | Time Definitions.Date | Quick:1H                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                 |
    Then UI Delete Report With Name "Traffic Bandwidth Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_30
  Scenario: Traffic Rate Report 1
    Given UI "Create" Report With Name "Traffic Rate Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Traffic Rate],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                               |
      | Time Definitions.Date | Quick:15m                                                                                       |
    Then UI "Validate" Report With Name "Traffic Rate Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Traffic Rate],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                               |
      | Time Definitions.Date | Quick:15m                                                                                       |
    Then UI Delete Report With Name "Traffic Rate Report 1"

  @SID_31
  Scenario: Traffic Rate Report 2
    Given UI "Create" Report With Name "Traffic Rate Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Traffic Rate], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                |
      | Logo                  | reportLogoPNG.png                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
    Then UI "Validate" Report With Name "Traffic Rate Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Traffic Rate], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                |
      | Logo                  | reportLogoPNG.png                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
    Then UI Delete Report With Name "Traffic Rate Report 2"

  @SID_32
  Scenario: Traffic Rate Report 3
    Given UI "Create" Report With Name "Traffic Rate Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Traffic Rate], Protected Objects:[All] |
      | Format                | Select: HTML                                                                               |
      | Time Definitions.Date | Relative:[Days,3]                                                                          |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                               |
    Then UI "Validate" Report With Name "Traffic Rate Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Traffic Rate], Protected Objects:[All] |
      | Format                | Select: HTML                                                                               |
      | Time Definitions.Date | Relative:[Days,3]                                                                          |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                               |
    Then UI Delete Report With Name "Traffic Rate Report 3"

  @SID_33
  Scenario: Traffic Rate Report 4
    Given UI "Create" Report With Name "Traffic Rate Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Traffic Rate], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                      |
      | Time Definitions.Date | Relative:[Months,4]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
    Then UI "Validate" Report With Name "Traffic Rate Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Traffic Rate], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                      |
      | Time Definitions.Date | Relative:[Months,4]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
    Then UI Delete Report With Name "Traffic Rate Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_34
  Scenario: DDoS Peak Attack per Period Report 1
    Given UI "Create" Report With Name "DDoS Peak Attack per Period Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Peak Attack per Period],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:1D                                                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                                   |
    Then UI "Validate" Report With Name "DDoS Peak Attack per Period Report 1"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Peak Attack per Period],Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:1D                                                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                                   |
    Then UI Delete Report With Name "DDoS Peak Attack per Period Report 1"

  @SID_35
  Scenario: DDoS Peak Attack per Period Report 2
    Given UI "Create" Report With Name "DDoS Peak Attack per Period Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Peak Attack per Period], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                          |
      | Schedule              | Run Every:Once, On Time:+6H                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
    Then UI "Validate" Report With Name "DDoS Peak Attack per Period Report 2"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Peak Attack per Period], Protected Objects:[All] |
      | Format                | Select: PDF                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                          |
      | Schedule              | Run Every:Once, On Time:+6H                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
    Then UI Delete Report With Name "DDoS Peak Attack per Period Report 2"

  @SID_36
  Scenario: DDoS Peak Attack per Period Report 3
    Given UI "Create" Report With Name "DDoS Peak Attack per Period Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Peak Attack per Period], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                              |
      | Time Definitions.Date | Quick:This Week                                                                                           |
    Then UI "Validate" Report With Name "DDoS Peak Attack per Period Report 3"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Peak Attack per Period], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                              |
      | Time Definitions.Date | Quick:This Week                                                                                           |
    Then UI Delete Report With Name "DDoS Peak Attack per Period Report 3"

  @SID_37
  Scenario: DDoS Peak Attack per Period Report 4
    Given UI "Create" Report With Name "DDoS Peak Attack per Period Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Peak Attack per Period], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                     |
      | Time Definitions.Date | Relative:[Days,3]                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                  |
    Then UI "Validate" Report With Name "DDoS Peak Attack per Period Report 4"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Peak Attack per Period], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                     |
      | Time Definitions.Date | Relative:[Days,3]                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                  |
    Then UI Delete Report With Name "DDoS Peak Attack per Period Report 4"


    # ------------------------------------------------------------------------------------------------------------------------------------------------------------


  @SID_38
  Scenario: Logout
    Then UI logout and close browser