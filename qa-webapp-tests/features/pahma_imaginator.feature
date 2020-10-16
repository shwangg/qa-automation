Feature: The PAHMA imaginator application

Scenario: Test the Imaginator by checking queries made with "Search the Metadata" and "Search for Images".
    Given I am on the "pahma" homepage
    When I log in to "pahma"
    Then I click "imaginator"
    Then I will enter "augustus" and click "Search the Metadata"
    Then I click "2-13166"
    Then I find the content "Lat / Long, Object Type, Context of Use, Dimensions, Comment, Collection Date" in "div#content"
    Then I will enter "seed beater" and click "Search for Images"
    Then I click "1-730"
    Then I find the content "Seed beater" in "div#content"
    When I click "Sign out"
    Then I find the content "search" in "div#content-main"