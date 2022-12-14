@TC107990
Feature: HTTPS Flood Dashboard - RBAC

  @SID_1
  Scenario: Update Policies
    Given CLI Reset radware password
    * REST Login with activation with user "radware" and password "radware"
    Given REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then REST Update Policies for All DPs
    Then REST Login with user "sec_admin_realDPs_pol1" and password "radware"
    Then REST Generic API Request "PUT" for "User Preferences->Landing Page" Body params "globalLandingPage=toolboxLandingPage" Expected result "ok"

  @SID_2
  Scenario: HTTPS Servers RBAC - One Policy All Devices
    Given UI Login with user "sec_admin_realDPs_pol1" and password "radware"
    And UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then HTTPS Scope Selection Validate RBAC with Devices IPs "172.16.22.50,172.16.22.51" and the Following Policies and Page Size 50
      | deviceIp     | policyName |
      | 172.16.22.50 | pol1       |
      | 172.16.22.51 | pol1       |

    Then UI Logout

  @SID_3
  Scenario: HTTPS Servers RBAC - One Policy One Device
    Then REST Login with user "sec_admin_DP51_pol1" and password "radware"
    Then REST Generic API Request "PUT" for "User Preferences->Landing Page" Body params "globalLandingPage=toolboxLandingPage" Expected result "ok"
    Given UI Login with user "sec_admin_DP51_pol1" and password "radware"
    Then UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then HTTPS Scope Selection Validate RBAC with Devices IPs "172.16.22.51" and the Following Policies and Page Size 50
      | deviceIp     | policyName |
      | 172.16.22.51 | pol1       |
    Then REST Login with user "sec_admin_DP51_pol1" and password "radware"
    Then REST Generic API Request "PUT" for "User Preferences->Landing Page" Body params "" Expected result "ok"
    Given UI Logout

  @SID_4
  Scenario: HTTPS RBAC with scope "all" user
    When UI Login with user "Vision_Reporter_user" and password "radware"
    Then UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then HTTPS Scope Selection Validate RBAC with Devices IPs "172.16.22.50,172.16.22.51" and the Following Policies and Page Size 50
      | deviceIp     | policyName |
      | 172.16.22.50 | all        |
      | 172.16.22.51 | all        |
    Then UI logout and close browser
