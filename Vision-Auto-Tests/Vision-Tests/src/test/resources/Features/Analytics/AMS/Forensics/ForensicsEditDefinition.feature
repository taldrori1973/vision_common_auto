@VRM_Report2 @TC106001

Feature: Forensics Edit Definition
  
  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    * CLI Clear vision logs
  
  @SID_2
  Scenario: Run DP simulator
    And CLI simulate 1 attacks of type "rest_black_ip46" on SetId "DefensePro_Set_1"
    And CLI simulate 1 attacks of type "vrm_bdos" on SetId "DefensePro_Set_2" and wait 80 seconds

  
  @SID_3
  Scenario: VRM - Login to VRM "Wizard" Test
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "AMS Forensics" page via homepage

  
  @SID_4
  Scenario: forensics create basic report
    When UI "Create" Forensics With Name "Test Edit"
      |  |  |
    Then UI Click Button "My Forensics" with value "Test Edit"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Test Edit"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Test Edit,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 3
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Test Edit_0"

  
  @SID_5
  Scenario: forensics definition edit forensic name
    When UI "Edit" Forensics With Name "Test Edit"
      | Basic Info | Description:,forensics name:Test Edit |

  
  @SID_6
  Scenario: forensics definition edit all fields
    When UI "Edit" Forensics With Name "Test Edit"
      | Basic Info            | Description:desc                                                   |
      | Time Definitions.Date | Quick:1M                                                           |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:HTTP 403 Forbidden |
      | Output                | Start Time,Action,Attack ID,Risk                                   |
#      | Schedule              | Run Every:Daily,On Time:+2m                                        |
      | Delivery              | Email:[automation.vision1@radware.com],Subject:mySubject           |
  
  @SID_7
  Scenario: Validate forensics definition edit criteria
    When UI "Edit" Forensics With Name "Test Edit"
      | Criteria | Event Criteria:Protocol,Operator:Not Equals,Value:IP |
    Then UI Click Button "My Forensics" with value "Test Edit"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Test Edit"
    Then Sleep "60"
    And UI Click Button "Views.Forensic" with value "Test Edit,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
  
  @SID_8
  Scenario: Validate forensics definition edit time definition
    # move one attack 48 hours backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "78-1526381752"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-172800000'"}}'" on "ROOT_SERVER_CLI"
    When UI "Edit" Forensics With Name "Test Edit"
      | Time Definitions.Date | Relative:[Hours,12] |
    Then UI Click Button "My Forensics" with value "Test Edit"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Test Edit"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Test Edit,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    Then UI Delete Forensics With Name "Test Edit"

  @SID_9
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |



