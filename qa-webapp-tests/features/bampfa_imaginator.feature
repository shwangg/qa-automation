Feature: The BAMPFA imaginator application

Scenario: Test the Imaginator by checking queries made with "Search the Metadata" and "Search for Images".
    Given I am on the "bampfa" homepage
    When I log in to "bampfa"
    Then I click "imaginator"
    Then I will enter "greek" and click "Search the Metadata"
    Then I click "1943.29"
    Then I find the content "Classification, Artist, Country, Artist birth Date, Artist death Date, Date Made, Dimensions, Materials, Full BAMPFA credit line, Century" in "div#content"
    Then I will enter "morning" and click "Search for Images"
    Then I verify a page only listing images
    When I open a new window by clicking "1966.45"
    Then I find the content "Classification, Artist, Country, Artist birth Date, Artist death Date, Date Made, Dimensions, Materials, Full BAMPFA credit line, Century" in "div#content"
