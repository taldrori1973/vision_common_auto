@TC119241
Feature: Basic tests for Forensics parameters


  @SID_1
  Scenario: Navigate to NEW ForensicsS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"

  @SID_2
  Scenario: Validate Forensics Parameters Name
    Then UI Text of "Name Tab" equal to "Name"
    Then UI Text of "Time Tab" equal to "Time"
    Then UI Text of "Schedule Tab" equal to "Schedule"
    Then UI Text of "Share Tab" equal to "Share"
    Then UI Text of "Format Tab" equal to "Format"

  @SID_3
  Scenario: Forensics Name is selected
    Then UI Click Button "Name Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | true  |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_4
  Scenario: Forensics Time is selected
    Then UI Click Button "Time Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Time Tab     |       | true  |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_5
  Scenario: Forensics Schedule is selected
    Then UI Click Button "Schedule Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | true  |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_6
  Scenario: Forensics Share is selected
    Then UI Click Button "Share Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | true  |
      | Format Tab   |       | false |

  @SID_7
  Scenario: Forensics Format is selected
    Then UI Click Button "Format Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | true  |

  @SID_8
  Scenario: Forensics Product DefensePro is selected
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param       | value |
      | Product Tab | DefensePro  | true  |
      | Product Tab | DefenseFlow | false |
      | Product Tab | AppWall     | false |
#    Then UI Text of "Forensics Product Type" equal to "DefensePro"

  @SID_9
  Scenario: Forensics Product DefenseFlow is selected
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param       | value |
      | Product Tab | DefensePro  | false |
      | Product Tab | DefenseFlow | true  |
      | Product Tab | AppWall     | false |
#    Then UI Text of "Forensics Product Type" equal to "DefenseFlow"

  @SID_10
  Scenario: Forensics Product AppWall is selected
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param       | value |
      | Product Tab | DefensePro  | false |
      | Product Tab | DefenseFlow | false |
      | Product Tab | AppWall     | true  |
#    Then UI Text of "Forensics Product Type" equal to "AppWall"

  @SID_11
  Scenario: Forensics Format HTML Button is clicked
    Then UI Click Button "Format HTML Type"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label                               | param | value |
      | Format HTML Type                    |       | true  |
      | Format CSV Type                     |       | false |
      | Format CSV With Attack Details Type |       | false |
    Then UI Text of "Forensics Format Type" with extension "html" equal to "HTML"

  @SID_12
  Scenario: Forensics Format CSV Button is clicked
    Then UI Click Button "Format CSV Type"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label                               | param | value |
      | Format HTML Type                    |       | false |
      | Format CSV Type                     |       | true  |
      | Format CSV With Attack Details Type |       | false |
    Then UI Text of "Forensics Format Type" with extension "csv" equal to "CSV"

  @SID_13
  Scenario: Forensics Format CSV With Attack Details Button is clicked
    Then UI Click Button "Format CSV With Attack Details Type"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label                               | param | value |
      | Format HTML Type                    |       | false |
      | Format CSV Type                     |       | false |
      | Format CSV With Attack Details Type |       | true  |
#  data-debug-id
#    Then UI Text of "Forensics Format Type" with extension "csv" equal to "CSV W/Details"

  ##################### Name Section tests ###############################

  @SID_14
  Scenario: Validate Forensics Name and Description
    Then UI Validate the attribute "placeholder" Of Label "Forensics Name" is "EQUALS" to "Type here"
    Then UI Set Text Field "Forensics Name" To " "
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "&"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "Test"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(212, 212, 212)"
    Then UI Set Text Field "Forensics Name" To "test~a"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test`"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test!!"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test#"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test$"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test%"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test^"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test&"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test*"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test+"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test="
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test\"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test-"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test?"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test["
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test]"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test'"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test;"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test,"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test/"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test{"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test}"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test:"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test<"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test>"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "@"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(212, 212, 212)"
    Then UI Set Text Field "Forensics Name" To "("
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(212, 212, 212)"
    Then UI Set Text Field "Forensics Name" To ")"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(212, 212, 212)"

    Then UI Set Text Field "Forensics Description" To "Description for Forensics"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Description" equals "rgb(212, 212, 212)"