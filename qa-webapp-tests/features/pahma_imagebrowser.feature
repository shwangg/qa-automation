Feature: The PAHMA imagebrowser

Scenario: Find and use the imagebrowser feature, including making searches, verifying headers, downloading .csv files, and clicking tabs.
    Given I am on the "pahma" homepage
    When I log in to "pahma"
    Then I click "imagebrowser"
    When I search for "textile" and enter "10"
    Then I click "1-13841"
    Then I find the content "Cradle frame" in "div#content"
    When I click "Sign out"
    Then I find the content "search" in "div#content-main"