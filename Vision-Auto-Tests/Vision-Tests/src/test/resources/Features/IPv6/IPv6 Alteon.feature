@TC108916
Feature: IPv6 Manage Alteon

  @SID_1
  Scenario: Delete Alteon and site if exists
    Then MYSQL DELETE FROM "device_file" Table in "VISION_NG" Schema WHERE "fk_dev_site_tree_el=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19')"
    Then MYSQL DELETE FROM "dpm_virtual_services" Table in "VISION_NG" Schema WHERE "fk_device=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19')"
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='Alteon_200a::172:17:164:19'"
    Then MYSQL DELETE FROM "device_setup" Table in "VISION_NG" Schema WHERE "fk_dev_access_device_acces=(select row_id from device_access where mgt_ip='200a:0:0:0:172:17:164:19')"
    Then MYSQL DELETE FROM "device_access" Table in "VISION_NG" Schema WHERE "mgt_ip='200a:0:0:0:172:17:164:19'"
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='Alteons-IPv6'"

  @SID_2
  Scenario: Open the SitesAndClusters Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_3
  Scenario: Add new Site to tree
    Then UI Add new Site "Alteons-IPv6" under Parent "Default"

  @SID_4
  Scenario: Add new Alteon to site
    Then UI Add "Alteon_IPv6_Set_1" under "Alteons-IPv6" site

  @SID_5
  Scenario: Lock and verify Alteon status
    Given UI Wait For Device To Show Up In The Topology Tree "Alteon_IPv6_Set_1" with timeout 120 seconds
    When UI verify Device Status "Alteon_IPv6_Set_1" if Expected device Status "Up or Maintenance"
    Then UI Lock Device "Alteon_IPv6_Set_1" under "Sites And Devices"

  @SID_6
  Scenario: Delete Alteon devices from tree
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete "Alteon_IPv6_Set_1" from topology tree

  @SID_7
  Scenario: Delete Alteon site
    Then UI Delete TopologyTree Element "Alteons-IPv6" by topologyTree Tab "SitesAndClusters"

  @SID_8
  Scenario: logout
    Then UI logout and close browser

